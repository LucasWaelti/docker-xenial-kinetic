# This is adapted from an auto generated Dockerfile for ros:ros-core
# generated from docker_images/create_ros_core_image.Dockerfile.em
FROM ubuntu:xenial

# install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros1-latest.list

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV ROS_DISTRO kinetic

# install core ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-kinetic-ros-core=1.3.2-0* \
    && rm -rf /var/lib/apt/lists/*

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    && rm -rf /var/lib/apt/lists/*

# bootstrap rosdep
RUN rosdep init && \
  rosdep update --rosdistro $ROS_DISTRO

# install base ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-kinetic-ros-base=1.3.2-0* \
    && rm -rf /var/lib/apt/lists/*

# install robot ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-kinetic-robot=1.3.2-0* \
    && rm -rf /var/lib/apt/lists/*

# install further tf2 dependencies 
RUN apt-get update && sudo apt-get install -y ros-kinetic-geometry2

# install rviz
RUN apt-get update && sudo apt-get install -y ros-kinetic-rviz 

# install cv-bridge 
RUN apt-get update && sudo apt-get install -y ros-kinetic-cv-bridge 

# install pcl
RUN apt-get update && sudo apt-get install -y ros-kinetic-pcl-ros 

# install image-geometry
RUN apt-get update && sudo apt-get install -y ros-kinetic-image-geometry  

# install image proc 
RUN apt-get update && sudo apt-get install -y ros-kinetic-image-proc 

# install compilers
RUN sudo apt update; sudo apt install -y gcc; sudo apt install -y g++ 
ENV GCC /usr/bin/gcc

RUN sudo apt update && sudo apt upgrade -y cmake

# protofbuf_catkin dependency 
RUN sudo apt-get update && sudo apt-get install -y libtool 

# install Voxblox dependencies 
RUN apt-get update 
RUN ["/bin/bash", "-c", "sudo apt-get install -y python-wstool python-catkin-tools ros-kinetic-cmake-modules protobuf-compiler autoconf"] 

# setup entrypoint
COPY ./ros_entrypoint.sh /
RUN chmod +x ros_entrypoint.sh
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
