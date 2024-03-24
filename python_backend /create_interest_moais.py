import pandas as pd

# Load the modified CSV file with interests
df = pd.read_csv('interests.csv')

# Filter the first 200 records
df = df.head(200)

# Unique list of interests
interests = df['Interest'].unique()

# Directory where you want to save the clusters. Make sure this directory exists.
save_directory = 'interests'

for interest in interests:
    # Create a cluster for each interest category
    cluster = df[df['Interest'] == interest]
    
    # Define the path for the new CSV file
    save_path = f'{save_directory}/{interest}_cluster.csv'
    
    # Save the cluster to a CSV file
    cluster.to_csv(save_path, index=False)

    print(f"Cluster for {interest} saved to {save_path}")
