import pandas as pd
import numpy as np
import os
from scipy.stats import mode
from sklearn.neighbors import NearestNeighbors
from sklearn.preprocessing import StandardScaler

# Define numerical and categorical features without 'age'
numerical_features = ['salary', 'dependents', 'creditScore']
categorical_features = ['city', 'state', 'country', 'occupation', 'education']

# Define weights for numerical and categorical features
numerical_weights = {'salary': 3.0, 'dependents': 1.3, 'creditScore': 2.0}
categorical_weights = {'city': 1.0, 'state': 1.0, 'country': 1.0, 'occupation': 1.0, 'education': 1.0}


def calculate_cluster_averages(cluster_dir, numerical_weights):
    cluster_averages = []
    for filename in os.listdir(cluster_dir):
        if filename.startswith("cluster_") and filename.endswith(".csv"):
            filepath = os.path.join(cluster_dir, filename)
            df = pd.read_csv(filepath)
            
            # Apply weights to numerical features
            for feature, weight in numerical_weights.items():
                df[feature] *= weight
            
            # Calculate weighted mean for numerical features
            num_means = df[list(numerical_weights.keys())].mean()
            
            # Calculate mode for categorical features using pandas.DataFrame.mode
            cat_modes = df[categorical_features].mode().iloc[0]
            
            # Combine numerical means and categorical modes into one Series
            cluster_avg = pd.concat([num_means, cat_modes])
            cluster_averages.append(cluster_avg)
    
    return pd.DataFrame(cluster_averages)


def preprocess_new_user(new_user_data, scaler, numerical_weights=None):
    user_df = pd.DataFrame([new_user_data])
    
    # Apply weights to numerical features if weights are provided
    if numerical_weights:
        for feature, weight in numerical_weights.items():
            if feature in user_df.columns:
                user_df[feature] *= weight
    
    # Apply scaling if provided and numerical_weights is not None
    if scaler and numerical_weights:
        features_to_scale = list(numerical_weights.keys())
        user_df[features_to_scale] = scaler.transform(user_df[features_to_scale])
    
    return user_df



def find_closest_cluster(new_user_data, cluster_averages):
    nn = NearestNeighbors(n_neighbors=1)
    # Fit NearestNeighbors using only numerical features
    nn.fit(cluster_averages[numerical_features])

    # Ensure numerical_weights is defined if your function uses it
    numerical_weights = {'salary': 1.0, 'dependents': 1.0, 'creditScore': 1.0}  # Adjust as needed

    # Define a scaler if you're using one, otherwise pass None
    scaler = None  # Replace None with your scaler if you're scaling numerical features

    # Correctly pass all required arguments to preprocess_new_user
    new_user_processed = preprocess_new_user(new_user_data, scaler, numerical_weights)

    # Ensure that new_user_processed is correctly formatted for knneighbors call
    if not isinstance(new_user_processed, np.ndarray):
        # If new_user_processed is a DataFrame, select numerical features for distance calculation
        new_user_processed = new_user_processed[numerical_features].to_numpy()

    # Find the closest cluster
    distances, indices = nn.kneighbors(new_user_processed.reshape(1, -1))  # Reshape for single sample
    closest_cluster_index = indices[0][0]
    return closest_cluster_index

# Example usage
cluster_dir = "clusters"
cluster_averages = calculate_cluster_averages(cluster_dir, numerical_weights)
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
    "salary": 300000,  # Reflecting the occupation and education level trend
    "dependents": 2,
    "creditScore": 530
}

# Assuming scaler is defined and fitted; if not, set scaler=None
scaler = StandardScaler().fit(cluster_averages[numerical_features])  # Example fitting; adjust as needed

# Adjust the call to include all necessary arguments
new_user_processed = preprocess_new_user(user_data, scaler, numerical_weights)

closest_cluster_index = find_closest_cluster(new_user_processed.iloc[0], cluster_averages)
print(f"The new user is most similar to cluster: {closest_cluster_index}")
