import pandas as pd
import numpy as np
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.metrics.pairwise import euclidean_distances
from datetime import datetime
from sklearn.base import BaseEstimator, TransformerMixin
import os
from sklearn.base import BaseEstimator, TransformerMixin
import numpy as np

class FeatureWeighter(BaseEstimator, TransformerMixin):
    def __init__(self, weights):
        self.weights = weights  # weights should now be a dict with indices as keys

    def fit(self, X, y=None):
        return self

    def transform(self, X):
        # Initialize an array to hold the transformed features
        transformed_X = np.zeros_like(X)
        
        # Check if X is a DataFrame or numpy array and handle accordingly
        if isinstance(X, pd.DataFrame):
            # If X is a DataFrame, iterate over weights and apply them by column name
            for feature_name, weight in self.weights.items():
                if feature_name in X.columns:
                    X[feature_name] = X[feature_name] * weight
            transformed_X = X.values
        elif isinstance(X, np.ndarray):
            # If X is a numpy array, iterate over weights assuming keys are column indices
            for feature_index, weight in self.weights.items():
                # Apply weight by index, ensure index is within bounds
                if 0 <= feature_index < X.shape[1]:
                    transformed_X[:, feature_index] = X[:, feature_index] * weight
                else:
                    # Copy the column as is if the index is not in weights
                    transformed_X[:, feature_index] = X[:, feature_index]
        else:
            raise TypeError("Input must be a pandas DataFrame or a numpy array.")
        
        return transformed_X



class CategoricalFeatureWeighter(BaseEstimator, TransformerMixin):
    def __init__(self, weights):
        self.weights = weights

    def fit(self, X, y=None):
        return self

    def transform(self, X):
        for feature, weight in self.weights.items():
            if feature in X.columns:
                for _ in range(weight - 1):
                    duplicated_columns = X.filter(like=feature)
                    for col in duplicated_columns.columns:
                        X[f'{col}_dup_{_}'] = X[col]
        return X

def calculate_age(year, month, day):
    birthdate = datetime(year, month, day)
    today = datetime.today()
    return today.year - birthdate.year - ((today.month, today.day) < (birthdate.month, birthdate.day))

# Assuming numerical and categorical weights are defined
numerical_weights = {'age': 1.0, 'salary': 1.5, 'dependents': 1.0, 'creditScore': 1.0}
categorical_weights = {'occupation': 2, 'city': 2}

# Preprocessing pipelines
numerical_features = ['age', 'salary', 'dependents', 'creditScore']
categorical_features = ['city', 'state', 'country', 'occupation', 'education']

numerical_preprocessor = Pipeline([
    ('weighter', FeatureWeighter(numerical_weights)),
    ('scaler', StandardScaler())
])

categorical_preprocessor = Pipeline([
    ('encoder', OneHotEncoder(sparse_output=False)),
    ('weighter', CategoricalFeatureWeighter(categorical_weights))
])

preprocessor = ColumnTransformer(
    transformers=[
        ('num', numerical_preprocessor, numerical_features),
        ('cat', categorical_preprocessor, categorical_features)
    ], remainder='passthrough')

def load_existing_cluster_centroids():
    centroids = []
    cluster_names = []
    clusters_directory = "clusters"
    for filename in os.listdir(clusters_directory):
        if filename.startswith("cluster_") and filename.endswith(".csv"):
            cluster_id = filename.split('_')[1][:-4]  # Extract the cluster ID
            filepath = os.path.join(clusters_directory, filename)
            df = pd.read_csv(filepath)
            
            # Assuming 'calculate_age' function is defined as above and necessary conversions are handled
            df['age'] = df.apply(lambda row: calculate_age(row['year'], row['month'], row['day']), axis=1)
            df.drop(['month', 'day', 'year'], axis=1, inplace=True, errors='ignore')
            
            # Apply preprocessing
            preprocessed_data = preprocessor.fit_transform(df)
            
            # Calculate centroid
            centroid = np.mean(preprocessed_data, axis=0)
            centroids.append(centroid)
            cluster_names.append(cluster_id)
            
    return np.array(centroids), cluster_names

# Assigning a new user to an existing cluster
def assign_to_existing_cluster(user_data, preprocessor, centroids, cluster_names):
    # Preprocess user data
    user_df = pd.DataFrame([user_data])
    user_df['age'] = calculate_age(user_data['year'], user_data['month'], user_data['day'])
    user_df.drop(['month', 'day', 'year', 'firstName', 'lastName', 'email', 'phoneNumber'], axis=1, inplace=True)
    
    preprocessed_user_data = preprocessor.fit_transform(user_df)
    
    # Determine the closest cluster
    distances = euclidean_distances(preprocessed_user_data, centroids)
    closest_cluster_idx = np.argmin(distances)
    return cluster_names[closest_cluster_idx]

user_data = {
    "firstName": "Elena",
    "lastName": "Ramirez",
    "month": 11,
    "day": 3,
    "year": 1990,
    "email": "elenaramirez@example.com",
    "phoneNumber": 1234567890,
    "city": "Boston",
    "state": "MA",
    "country": "USA",
    "occupation": "Consultant",
    "education": "Bachelor",
    "salary": 25000,  # Reflecting the occupation and education level trend
    "dependents": 0,
    "creditScore": 800
}

# Load centroids and cluster names
centroids, cluster_names = load_existing_cluster_centroids()

# Assign user to a cluster
closest_cluster = assign_to_existing_cluster(user_data, preprocessor, centroids, cluster_names)
print(f"The closest cluster for the new user is: {closest_cluster}")
