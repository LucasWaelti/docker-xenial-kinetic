# Docker image creation  

Create a Docker image to run Voxblox and the AprilTag detection on Ubuntu Xenial for x86_64 architecture with all required dependencies. 

## Download the source code 
Update the git submodules: 
```bash
git submodule update --init --recursive     # the first time this repo is cloned
git submodule update --recursive --remote   # to simply update 
``` 
Download Voxblox and its dependencies: 
```bash
./pull_source.sh 
```

## Build the image
```bash
cd ~/path/to/docker-xenial-kinetic 
docker build -t xenial-kinetic:v1.0 -f Dockerfile .
```

## Tag the image 
```bash
docker tag xenial-kinetic:v1.0 kinetic-amd
``` 

## Run the Docker image 
```bash
docker run -it --rm --privileged --net=host --name xenial-kinetic -v /home/$(whoami)/docker-xenial-kinetic/:/home/user/:rw -w /home/user/ kinetic-amd /bin/bash
```
The following table briefly explains the arguments, as presented [here](https://docs.modalai.com/docker-on-voxl/):
| Argument                 | Description                                                                          |
|--------------------------|--------------------------------------------------------------------------------------|
| -it                      | Interactive mode, usually used when you wish to open a bash shell inside the docker. |
| –rm                      | Automatically remove the container when it exits to prevent containers stacking up.  |
| –privileged              | Gives the docker container access to /dev/                                           |
| –net=host                | Lets network interfaces appear the same inside and outside of the docker container.  |
| –name {name}             | Give a name to the running instance so you can identify and attach to it by name.    |
| -v {outside}:{inside}:rw | Mounts a directory outside the container to a directory inside the container.        |
| -w {working_dir}         | Set the working directory inside the container.                                      |

### Initialize the workspace 
Initialize the workspace and download Voxblox: 
```bash
./init_workspace.sh 
```

### Build the packages
```bash
cd ./catkin_ws
catkin build
```

## Update CMake from the container 
> *WARNING*: Only perform these steps if a problem occurs during the compilation of the apriltag packages! Support for cmake 3.0.5+ was recently added, which satisfies the system's cmake version 3.5.1 of the Docker image. 

Ubuntu Xenial is limited to cmake version 3.5.1. However **older** versions of [apriltag](https://github.com/AprilRobotics/apriltag) and [apriltag_ros](https://github.com/AprilRobotics/apriltag_ros) need cmake >= 3.10. 
A new cmake version therefore needs to be installed from source. 
To do so, start the container and clone the [cmake source](https://github.com/Kitware/CMake) somewhere in the mounted volume to get the last cmake version: 
```bash
cd ./catkin_ws/ 
git clone https://github.com/Kitware/CMake.git
cd CMake
``` 
Build and install cmake according to their [documentation](https://github.com/Kitware/CMake#unixmac-osxmingwmsyscygwin) **from the container**:
```bash
$ ./bootstrap && make && sudo make install
```
This will build and install the new cmake version and overwrite the system's default cmake in the container. 