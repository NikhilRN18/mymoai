import pandas as pd
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.base import BaseEstimator, TransformerMixin
from sklearn.cluster import KMeans
from datetime import datetime
import numpy as np
import os

# Custom transformer to convert arrays to DataFrame
class ArrayToDataFrame(BaseEstimator, TransformerMixin):
    def fit(self, X, y=None):
        return self
    
    def transform(self, X):
        if not isinstance(X, pd.DataFrame):
            return pd.DataFrame(X)
        return X

# Custom transformer to apply weights to numerical features
class FeatureWeighter(BaseEstimator, TransformerMixin):
    def __init__(self, weights):
        self.weights = weights

    def fit(self, X, y=None):
        return self

    def transform(self, X):
        return X * self.weights

# Custom transformer to duplicate one-hot encoded columns based on weights
class CategoricalFeatureWeighter(BaseEstimator, TransformerMixin):
    def __init__(self, weights):
        self.weights = weights

    def fit(self, X, y=None):
        return self

    def transform(self, X):
        if not isinstance(X, pd.DataFrame):
            X = pd.DataFrame(X)
        for feature, weight in self.weights.items():
            if feature in X.columns:
                for _ in range(weight - 1):
                    for col in [col for col in X if col.startswith(feature)]:
                        X[col + f'_dup_{_}'] = X[col]
        return X

# Function to calculate age from birthdate
def calculate_age(year, month, day):
    today = datetime.today()
    return today.year - year - ((today.month, today.day) < (month, day))

# Load your dataset
# Make sure to adjust the path to where your dataset is located
df = pd.read_csv("people.csv")

# Assuming your dataset includes columns for 'year', 'month', 'day' for the birthdate
df['age'] = df.apply(lambda x: calculate_age(x['year'], x['month'], x['day']), axis=1)

# Define your preprocessing steps
preprocessor = ColumnTransformer(transformers=[
    ('num', Pipeline(steps=[
        ('scaler', StandardScaler())
    ]), ['age', 'salary', 'dependents', 'creditScore']),
    ('cat', OneHotEncoder(), ['city', 'state', 'country', 'occupation', 'education'])
])

# Setup the KMeans clustering
kmeans_pipeline = Pipeline(steps=[
    ('preprocessor', preprocessor),
    ('cluster', KMeans(n_clusters=400, random_state=42))
])

# Fit the model
kmeans_pipeline.fit(df)

# Assign clusters
df['cluster'] = kmeans_pipeline.predict(df)

# Save each cluster's data to separate CSV files
output_dir = "clusters"
os.makedirs(output_dir, exist_ok=True)

for cluster_id in df['cluster'].unique():
    cluster_df = df[df['cluster'] == cluster_id]
    cluster_df.to_csv(f"{output_dir}/cluster_{cluster_id}.csv", index=False)

print("Cluster data saved successfully.")
