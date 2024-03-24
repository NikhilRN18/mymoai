import pandas as pd

def load_dataset(filepath):
    """Load the dataset from the CSV file."""
    return pd.read_csv(filepath)

def get_moais(user_data):
    """Extract Moais from a user record. Directly return the list if already in the correct format."""
    return set(user_data['Moais'])  # Assuming 'Moais' is already a list

def find_mutual_connections(df, user_moais):
    """Find other people in the dataset who share at least one Moai with the user."""
    # Convert Moais list to string for comparison, if your dataset stores them as strings
    mutuals = df[df['Moais'].apply(lambda moais: any(moai in (moais.split(', ') if isinstance(moais, str) else []) for moai in user_moais))]
    return mutuals

def recommend_new_moais(df, user_data, mutual_connections):
    """Recommend new Moais based on what mutual connections are in."""
    user_moais = get_moais(user_data)
    mutuals_moais = set.union(*mutual_connections['Moais'].apply(lambda x: set(x.split(', '))))
    recommended_moais = mutuals_moais - user_moais  # Moais in which mutuals are but the user isn't
    return recommended_moais

# Load the dataset
filepath = 'alldata.csv'  # Update with the path to your CSV
df = load_dataset(filepath)

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
    "creditScore": 800,
    "interests": ["Pets", "Gambling"],
    "Moais": ["330", "460", "7"]
}

# Find mutual connections in the dataset
user_moais = get_moais(user_data)
mutual_connections = find_mutual_connections(df, user_moais)

# Recommend new Moais for the user based on mutual connections
recommended_moais = recommend_new_moais(df, user_data, mutual_connections)

print(f"Recommended Moais for {user_data['firstName']} {user_data['lastName']}: {recommended_moais}")
