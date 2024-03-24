import pandas as pd
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.base import BaseEstimator, TransformerMixin
from datetime import datetime
import numpy as np

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

# Custom transformer to duplicate one-hot encoded columns based on weight
class CategoricalFeatureWeighter(BaseEstimator, TransformerMixin):
    def __init__(self, weights):
        self.weights = weights

    def fit(self, X, y=None):
        return self

    def transform(self, X):
        # Ensure input is a DataFrame
        if not isinstance(X, pd.DataFrame):
            X = pd.DataFrame(X)
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

numerical_preprocessor = Pipeline([
    ('weighter', FeatureWeighter(weights=numerical_weights)),
    ('scaler', StandardScaler())
])


categorical_preprocessor = Pipeline(steps=[
    ('encoder', OneHotEncoder(sparse_output=False)),
    ('to_df', ArrayToDataFrame()),  # Ensure the output is a DataFrame
    ('weighter', CategoricalFeatureWeighter(weights=categorical_weights))
])

preprocessor = ColumnTransformer(
    transformers=[
        ('num', numerical_preprocessor, numerical_features),
        ('cat', categorical_preprocessor, categorical_features)
    ], remainder='passthrough')

# The K-Means clustering model with preprocessing pipeline
kmeans = Pipeline(steps=[('preprocessor', preprocessor),
                         ('cluster', KMeans(n_clusters=800 , random_state=42))])

# Load the dummy data and train the model
df = pd.read_csv("people.csv")
df['age'] = df.apply(calculate_age, axis=1)
df.drop(['month', 'day', 'year', 'firstName', 'lastName', 'email', 'phoneNumber'], axis=1, inplace=True)

# Fit the model
kmeans.fit(df)

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



def describe_cluster(cluster_id, model):
    # Extracting the numerical and categorical transformers
    scaler = model.named_steps['preprocessor'].named_transformers_['num'].named_steps['scaler']
    onehot = model.named_steps['preprocessor'].named_transformers_['cat'].named_steps['encoder']

    # Getting the cluster's centroid
    centroid = model.named_steps['cluster'].cluster_centers_[cluster_id]

    # Splitting the centroid into numerical and categorical parts
    num_centroid = centroid[:len(numerical_features)]
    cat_centroid = centroid[len(numerical_features):]

    # Inverse transforming the numerical part of the centroid
    num_centroid_inv = scaler.inverse_transform([num_centroid])[0]

    # Preparing the description dictionary with numerical features
    descriptions = {numerical_features[i]: num_centroid_inv[i] for i in range(len(numerical_features))}

    # Handling categorical features (finding the max value index for one-hot encoded vectors)
    start_idx = 0
    for feature in categorical_features:
        end_idx = start_idx + onehot.categories_[categorical_features.index(feature)].shape[0]
        cat_value_index = np.argmax(cat_centroid[start_idx:end_idx])
        descriptions[feature] = onehot.categories_[categorical_features.index(feature)][cat_value_index]
        start_idx = end_idx

    return descriptions

# Get feature names for interpretation (note: adjustment may be needed for one-hot encoded features)
feature_names = numerical_features + [cat for feature in categorical_features for cat in feature]


recommended_moai = assign_to_moai(user_data, kmeans)
print(f"Recommended Moai Group: {recommended_moai}")

# Example usage
cluster_id = recommended_moai  # Assuming recommended_moai is obtained from assign_to_moai
cluster_description = describe_cluster(cluster_id, kmeans)
print(f"Defining parameters of Moai Group {cluster_id}: {cluster_description}")