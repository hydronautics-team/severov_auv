FROM dustynv/ros:iron-ros-base-l4t-r35.4.1

RUN apt update && apt install -y --no-install-recommends git wget libboost-system-dev python3-pip software-properties-common curl
RUN add-apt-repository universe 
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
RUN apt update && apt install -y --no-install-recommends ros-dev-tools 
RUN pip3 install pyserial
RUN apt update && apt install -y --no-install-recommends ros-iron-usb-cam ros-iron-zbar-ros graphviz graphviz-dev
RUN pip install transitions[diagrams]

# install pytorch
RUN wget https://nvidia.box.com/shared/static/fjtbno0vpo676a25cgvuqc1wty0fkkg6.whl -O torch-1.10.0-cp36-cp36m-linux_aarch64.whl
RUN apt install -y python3-pip libopenblas-base libopenmpi-dev libomp-dev
RUN pip3 install Cython
RUN pip3 install numpy torch-1.10.0-cp36-cp36m-linux_aarch64.whl

# install torchvision
RUN apt install -y libjpeg-dev zlib1g-dev libpython3-dev libavcodec-dev libavformat-dev libswscale-dev
RUN git clone --branch v0.11.1 https://github.com/pytorch/vision torchvision
WORKDIR /torchvision
RUN export BUILD_VERSION=0.11.1
RUN python3 setup.py install --user

WORKDIR /additional_packages_ws/src
RUN git clone https://github.com/jinmenglei/serial.git

WORKDIR /additional_packages_ws
RUN /bin/bash -c "source /opt/ros/iron/setup.bash && cd /additional_packages_ws && colcon build"

RUN echo 'source /additional_packages_ws/install/setup.bash' >> /root/.bashrc

WORKDIR /severov_auv
CMD ["bash"]
