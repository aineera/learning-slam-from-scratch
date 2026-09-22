# Main SLAM - Sab yahan se start hota hai
from tracking import track_features
from map import create_map

print("SLAM Started...")
features = track_features()
my_map = create_map(features)
print("Map ban gaya!")
