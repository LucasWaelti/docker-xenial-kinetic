#!/bin/bash

# Initialize a catkin worspace 
mkdir -p ./catkin_ws/src
cd ./catkin_ws
catkin init
catkin config --extend /opt/ros/melodic
catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release
catkin config --merge-devel

# Clone voxblox and its dependencies using the helper script 
cd ./src 
git clone https://gitlab.com/snippets/1975895.git
mv 1975895/voxblox_https.sh voxblox_https.sh
chmod +x ./voxblox_https.sh; ./voxblox_https.sh
rm ./voxblox_https.sh
rm -r -f 1975895/