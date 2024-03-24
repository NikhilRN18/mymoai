# Import the modules
import numpy as np
import matplotlib.pyplot as plt

# Define the hex codes as a list
hex_codes = ["#ffd1dc", "#ff1493", "#d3d3d3", "#f5f5f5", "#a52a2a", "#ff7f50", "#d2b48c"]

# Convert the hex codes to RGB values
rgb_values = [tuple(int(hex_code[i:i+2], 16) / 255 for i in (1, 3, 5)) for hex_code in hex_codes]

# Create a numpy array of the RGB values
rgb_array = np.array(rgb_values)

# Create a figure and a subplot
fig, ax = plt.subplots()

# Plot the array as a horizontal bar with a width of 1 and a height of 0.2
ax.imshow(rgb_array.reshape((1, 7, 3)), extent=[0, 7, 0, 0.2], aspect="auto")

# Hide the x and y axes
ax.axis("off")

# Show the plot
plt.show()
