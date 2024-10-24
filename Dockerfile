# Use the official ROS 2 Humble base image
FROM ros:humble-ros-base

# Set a non-interactive shell to avoid prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    wget \
    lsb-release \
    gnupg \
    curl \
    && rm -rf /var/lib/apt/lists/*

# For pip installed packages, add the path to the PATH environment variable
ENV PATH="/root/.local/bin:$PATH" 

# Install required prerequisite packages
RUN apt-get update \ 
  && apt-get upgrade -y \
  && apt-get install -y python3 \
  && apt-get install -y python3-pip \
  && apt-get install -y curl \
  && apt-get install -y git \
  && apt-get install -y gnome-terminal \
  && apt-get install -y lsb-release \
  && apt-get install -y apt-transport-https \
  && apt-get install -y ca-certificates \
  && apt-get install -y openssh-client \
  && apt-get install -y dbus-x11 \
  && apt-get install -y libeigen3-dev \
  && apt-get install -y build-essential cmake \
  && apt-get install -y nano \
  && apt-get install -y iproute2 \
  && apt-get --reinstall install coreutils \
  && rm -rf /var/lib/apt/lists/*

# Install python packages
RUN pip install --upgrade pip

# Setup for cloning repositories from GitHub
# Create a directory to hold the repositories
WORKDIR /home
RUN mkdir -p /home/repos

# Install PX4-Autopilot




### ROS2
# Source the ROS2 setup script
# RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

# ## Setup Micro-DDS
# RUN cd /home/repos && git clone https://github.com/eProsima/Micro-XRCE-DDS-Agent.git
# RUN cd /home/repos/Micro-XRCE-DDS-Agent && mkdir build 
# RUN cd /home/repos/Micro-XRCE-DDS-Agent/build && cmake .. && make && make install && ldconfig /usr/local/lib/ 

## Build ROS2 workspace
RUN mkdir -p /home/ws_ros2/src/  

####### Install dependencies
# RUN cd /home/ws_ros2/src/ \
#  && apt-get update -y \
#  && apt-get install -y ros-humble-rviz2 \
#  && cd .. \
#  && apt-get install -y python3-rosdep \
#  && . /opt/ros/humble/setup.sh \
#  && rm /etc/ros/rosdep/sources.list.d/20-default.list \
#  && export GZ_VERSION=humble \
#  && rosdep init \
#  && rosdep update \
#  && rosdep install -i --from-path src --rosdistro humble --skip-keys=librealsense2 -y


# RUN cd /home/ws_ros2/src/drone_misc && \
#     . /opt/ros/humble/setup.sh && \
#     pip install -r requirements.txt



# Default command to run when starting the container
CMD ["bash"]