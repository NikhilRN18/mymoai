import pandas as pd
import numpy as np

# Load your CSV file
df = pd.read_csv('people.csv')

# Define your interests
interests = ["Pets", "Gambling", "Travel", "Car", "Parties", "Rentals"]

# Randomly assign an interest to each person in the dataset
np.random.seed(42) 
df['Interest'] = np.random.choice(interests, size=len(df))

# Save the modified DataFrame to a new CSV file
df.to_csv('interests.csv', index=False)
