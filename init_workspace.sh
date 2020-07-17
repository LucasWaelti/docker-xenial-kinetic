#!/bin/bash

# Initialize a catkin worspace 
mkdir -p ./catkin_ws/src
cd ./catkin_ws
catkin init
catkin config --extend /opt/ros/melodic
catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release
catkin config --merge-devel
