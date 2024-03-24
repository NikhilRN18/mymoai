import pandas as pd
import numpy as np
import os
from scipy.stats import mode
from sklearn.neighbors import NearestNeighbors
from sklearn.preprocessing import StandardScaler
from datetime import datetime

# Define numerical and categorical features
numerical_features = ['salary', 'dependents', 'creditScore']  # Example numerical features
categorical_features = ['city', 'state', 'country', 'occupation', 'education']  # Example categorical features

# Function to calculate age from year, month, and day
def calculate_age(year, month, day):
    today = datetime.today()
    return today.year - year - ((today.month, today.day) < (month, day))

def calculate_cluster_averages(cluster_dir):
    cluster_averages = []
    for filename in os.listdir(cluster_dir):
        if filename.startswith("cluster_") and filename.endswith(".csv"):
            filepath = os.path.join(cluster_dir, filename)
            df = pd.read_csv(filepath)
            
            # Correctly calculate age and append it to the DataFrame
            df['age'] = df.apply(lambda row: calculate_age(row['year'], row['month'], row['day']), axis=1)
            
            # Ensure numerical_features list includes 'age' for this operation
            current_numerical_features = numerical_features + ['age']
            
            # Calculate mean for numerical features
            num_means = df[current_numerical_features].mean()
            
            # Calculate mode for categorical features
            cat_modes = df[categorical_features].apply(lambda x: mode(x, nan_policy='omit').mode[0], axis=0)
            
            # Combine numerical means and categorical modes into one Series
            cluster_avg = pd.concat([num_means, cat_modes])
            cluster_averages.append(cluster_avg)
    
    return pd.DataFrame(cluster_averages)


# Function to preprocess new user data, including calculating age
def preprocess_new_user(new_user_data, scaler=None):
    # Ensure new_user_data is a single dictionary; convert to a DataFrame
    user_df = pd.DataFrame([new_user_data])
    
    # Directly calculate age from the user's provided year, month, and day
    user_df['age'] = user_df.apply(lambda x: calculate_age(x["year"], x['month'], x['day']), axis=1)
    
    # Drop the original year, month, day columns after calculating age
    user_df.drop(["year", 'month', 'day'], axis=1, inplace=True)
    
    # If a scaler is provided and applicable, apply it to the numerical features
    # Note: Make sure the scaler has been fit previously, or fit it here if necessary
    if scaler:
        numerical_features_with_age = numerical_features + ['age']
        user_df[numerical_features_with_age] = scaler.transform(user_df[numerical_features_with_age])
    
    return user_df



# Function to find the closest cluster using Nearest Neighbors
def find_closest_cluster(new_user_data, cluster_averages):
    # Initialize NearestNeighbors
    nn = NearestNeighbors(n_neighbors=1)
    nn.fit(cluster_averages[numerical_features + ['age']])  # Fit using numerical features including 'age'
    
    # Preprocess the new user data
    new_user_processed = preprocess_new_user(new_user_data)
    
    # Find the closest cluster
    distances, indices = nn.kneighbors(new_user_processed[numerical_features + ['age']])
    closest_cluster_index = indices[0][0]
    return closest_cluster_index

# Example usage
cluster_dir = "clusters"  
cluster_averages = calculate_cluster_averages(cluster_dir)

user_data = {
    "firstName": "Elena",
    "lastName": "Ramirez",
    "month": 11,
    "day": 3,
    "year": 1990,
    "email": "elenaramirez@example.com",
    "phoneNumber": 1234567890,
    "city": "San Francisco",
    "state": "CA",
    "country": "USA",
    "occupation": "Consultant",
    "education": "Master",
    "salary": 85000,  # Reflecting the occupation and education level trend
    "dependents": 0,
    "creditScore": 800
}


# Normalize or preprocess new_user_data similarly to how cluster data was scaled
scaler = StandardScaler().fit(cluster_averages[numerical_features + ['age']])  # Fit scaler to cluster averages
new_user_processed = preprocess_new_user(user_data, scaler)

# Assuming new_user_processed is a DataFrame with a single row
closest_cluster_index = find_closest_cluster(new_user_processed.iloc[0], cluster_averages)
print(f"The new user is most similar to cluster: {closest_cluster_index}")
