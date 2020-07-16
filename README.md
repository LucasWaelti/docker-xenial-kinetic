# Docker experimentation 

Create a Docker image to run Voxblox and the AprilTag detection on Ubuntu Xenial for x86_64 architecture with all required dependencies. 

Clone [this snippet](https://gitlab.com/snippets/1975895) to install voxblox and its dependencies in a self contained folder. 

## Build the image
```bash
cd ~/docker_test
docker build -t xenial-kinetic:v1.0 -f Dockerfile .
```

## Tag the image 
```bash
docker tag xenial-kinetic:v1.0 kinetic-amd
``` 

## Run the Docker image 
```bash
docker run -it --rm --privileged --net=host --name xenial-kinetic -v /home/$(whoami)/:/home/user/:rw -w /home/user/ kinetic-amd /bin/bash
```

### Useful commands
| Argument                 | Description                                                                          |
|--------------------------|--------------------------------------------------------------------------------------|
| -it                      | Interactive mode, usually used when you wish to open a bash shell inside the docker. |
| –rm                      | Automatically remove the container when it exits to prevent containers stacking up.  |
| –privileged              | Gives the docker container access to /dev/                                           |
| –net=host                | Lets network interfaces appear the same inside and outside of the docker container.  |
| –name {name}             | Give a name to the running instance so you can identify and attach to it by name.    |
| -v {outside}:{inside}:rw | Mounts a directory outside the container to a directory inside the container.        |
| -w {working_dir}         | Set the working directory inside the container.                                      |


## Update CMake from the container 
Ubuntu Xenial is limited to cmake version 3.5.1. However [apriltag](https://github.com/AprilRobotics/apriltag) and [apriltag_ros](https://github.com/AprilRobotics/apriltag_ros) needs cmake >= 3.10. 
A new cmake version therefore needs to installed from source. 
To do so, start the container and clone the [cmake source](https://github.com/Kitware/CMake) somewhere in the mounted volume to get the last cmake version: 
```bash
git clone https://github.com/Kitware/CMake.git
cd CMake
``` 
Build and install cmake according to their [documentation](https://github.com/Kitware/CMake#unixmac-osxmingwmsyscygwin):
```bash
$ ./bootstrap && make && sudo make install
```
This will build and install the new cmake version and overwrite the system's default cmake. 