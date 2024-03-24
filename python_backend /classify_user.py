import pandas as pd
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.base import BaseEstimator, TransformerMixin
from datetime import datetime
import numpy as np

# Custom transformer to apply weights to numerical features
class FeatureWeighter(BaseEstimator, TransformerMixin):
    def __init__(self, weights):
        self.weights = weights

    def fit(self, X, y=None):
        return self

    def transform(self, X):
        return X * self.weights

# Custom transformer to duplicate one-hot encoded columns based on weight
class CategoricalFeatureWeighter(BaseEstimator, TransformerMixin):
    def __init__(self, weights):
        """
        weights: dict
            A dictionary where keys are the names of the categorical features
            and values are the weights (integers) indicating the number of times
            to duplicate the one-hot encoded columns for each feature.
        """
        self.weights = weights

    def fit(self, X, y=None):
        return self

    def transform(self, X):
        if not isinstance(X, pd.DataFrame):
            raise ValueError("Input must be a pandas DataFrame")
            
        for feature, weight in self.weights.items():
            if feature in X.columns:
                for _ in range(weight - 1):  # -1 because the original column already exists
                    for col in [col for col in X if col.startswith(feature)]:
                        X[col + f'_dup_{_}'] = X[col]
        return X

# Function to calculate age from birthdate
def calculate_age(row):
    birthdate = datetime(row['year'], row['month'], row['day'])
    today = datetime.today()
    return today.year - birthdate.year - ((today.month, today.day) < (birthdate.month, birthdate.day))

# Define weights for the numerical features
numerical_weights = np.array([1.0,  # Age
                              1.5,  # Salary (example: higher weight means more influence)
                              1.0,  # Dependents
                              1.0]) # CreditScore

# Define weights for categorical features
categorical_weights = {'occupation': 2, 'city': 2}  # Example weights

# Preprocessing steps
categorical_features = ['city', 'state', 'country', 'occupation', 'education']
numerical_features = ['age', 'salary', 'dependents', 'creditScore']

numerical_preprocessor = Pipeline(steps=[
    ('weighter', FeatureWeighter(weights=numerical_weights)),
    ('scaler', StandardScaler())
])

categorical_preprocessor = Pipeline(steps=[
    ('encoder', OneHotEncoder(sparse_output=False)),
    ('weighter', CategoricalFeatureWeighter(weights=categorical_weights))
])

preprocessor = ColumnTransformer(
    transformers=[
        ('num', numerical_preprocessor, numerical_features),
        ('cat', categorical_preprocessor, categorical_features)
    ], remainder='passthrough')

# The K-Means clustering model with preprocessing pipeline
kmeans = Pipeline(steps=[('preprocessor', preprocessor),
                         ('cluster', KMeans(n_clusters=10, random_state=42))])

# Function to prepare the user data for prediction
def prepare_user_data(user_data):
    user_df = pd.DataFrame([user_data])
    user_df['age'] = user_df.apply(calculate_age, axis=1)
    user_df.drop(['month', 'day', 'year', 'firstName', 'lastName', 'email', 'phoneNumber'], axis=1, inplace=True)
    return user_df

# Function to predict and assign a new user to a moai
def assign_to_moai(user_data, kmeans_model):
    prepared_data = prepare_user_data(user_data)
    cluster_label = kmeans_model.predict(prepared_data)[0]
    return cluster_label

# Example user data (for demonstration purposes, you'd replace this with actual user input)
user_data = {
    "firstName": "John",
    "lastName": "Doe",
    "month": 5,
    "day": 15,
    "year": 1990,
    "email": "johndoe@example.com",
    "phoneNumber": 1234567890,
    "city": "New York",
    "state": "NY",
    "country": "USA",
    "occupation": "Software Engineer",
    "education": "Bachelor",
    "salary": 90000,
    "dependents": 2,
    "creditScore": 720
}

# Assuming the model has been fitted with data previously
# To predict and assign the new user to a moai:
# recommended_moai = assign_to_moai(user_data, kmeans)
