import pandas as pd
from faker import Faker

fake = Faker()

# Load your dataset
df = pd.read_csv('new_dummy_user_data.csv')  # Replace with your file path

# Generate fake names
df['firstName'] = [fake.first_name() for _ in range(len(df))]
df['lastName'] = [fake.last_name() for _ in range(len(df))]

# Save the modified DataFrame to a new CSV file
df.to_csv('people.csv', index=False)  # Replace with your desired new file path
