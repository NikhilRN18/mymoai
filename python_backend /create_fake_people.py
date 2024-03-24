import pandas as pd
from faker import Faker

fake = Faker()

# Load your dataset
df = pd.read_csv('new_dummy_user_data.csv')  

# Generate fake names
df['firstName'] = [fake.first_name() for _ in range(len(df))]
df['lastName'] = [fake.last_name() for _ in range(len(df))]

df.to_csv('people.csv', index=False)  
