FROM dustynv/ros:iron-pytorch-l4t-r35.3.1

RUN apt update && apt install -y --no-install-recommends git wget libboost-system-dev python3-pip software-properties-common curl graphviz graphviz-dev
RUN pip3 install pyserial transitions[diagrams]

RUN mkdir -p /ws/additional_packages_ws/src
WORKDIR /ws/additional_packages_ws/src
RUN git clone https://github.com/jinmenglei/serial.git
RUN git clone -b iron https://github.com/ros-perception/vision_opencv.git
RUN git clone -b iron https://github.com/ros-perception/image_common.git
RUN git clone -b ros2 https://github.com/ros-drivers/usb_cam.git
RUN git clone -b iron https://github.com/ros-perception/image_pipeline.git
RUN mv image_pipeline/image_view/ .
RUN rm -r image_pipeline/

RUN apt-get install -y libzbar-dev
RUN git clone -b ros2 https://github.com/ros-drivers/zbar_ros.git

RUN pip3 install tqdm
RUN pip3 install pandas==1.1.0
RUN apt-get install -y python3-requests build-essential libatlas-base-dev gfortran libfreetype6-dev
RUN pip3 install scipy
RUN pip3 uninstall -y pillow
RUN pip3 install "pillow<7"
RUN pip3 install seaborn
RUN pip3 install "matplotlib>=3.2.2,<4"

# deep sort dependencies
RUN pip3 install filterpy==1.4.5
RUN pip3 install scikit-image==0.17.2
RUN pip3 install lap==0.4.0

RUN /bin/bash -c "source /opt/ros/iron/setup.bash && cd /additional_packages_ws && colcon build"

RUN echo 'source /additional_packages_ws/install/setup.bash' >> /root/.bashrc

WORKDIR /severov_auv
CMD ["bash"]
