import os

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
    "interests": ["Pets", "Gambling"]
}


def recommend_clusters(new_user_interests, clusters_directory):
    """
    Recommends clusters based on the new user's interests.
    
    Parameters:
    - new_user_interests: A list of interests of the new user.
    - clusters_directory: The directory containing the cluster CSV files.
    
    Returns:
    - A list of messages recommending the cluster files associated with the user's interests.
    """
    recommendations = []
    
    for interest in new_user_interests:
        # Ensure the interest is properly capitalized to match file names
        interest_formatted = interest.capitalize()
        
        # Construct the expected file name based on the interest
        expected_file_name = f"{interest_formatted}_cluster.csv"
        
        # Check if the file exists in the directory
        file_path = os.path.join(clusters_directory, expected_file_name)
        if os.path.exists(file_path):
            recommendations.append(f"Recommended moai for interest '{interest}': {file_path}")
        else:
            recommendations.append(f"No moai found for interest '{interest}'.")
    
    return recommendations
clusters_directory = 'interests'  

# Extract the interests of the new user
new_user_interests = user_data['interests']

# Get the cluster recommendations for each interest
recommendations = recommend_clusters(new_user_interests, clusters_directory)

# Print each recommendation
for recommendation in recommendations:
    print(recommendation)
