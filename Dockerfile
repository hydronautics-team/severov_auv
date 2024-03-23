FROM dustynv/ros:iron-pytorch-l4t-r35.3.1

RUN apt update && apt install -y --no-install-recommends git wget libboost-system-dev python3-pip software-properties-common curl graphviz graphviz-dev
RUN pip3 install pyserial transitions[diagrams]
RUN apt-get install -y libzbar-dev

RUN pip3 install tqdm
RUN pip3 install pandas
RUN apt-get install -y python3-requests build-essential libatlas-base-dev gfortran libfreetype6-dev
RUN pip3 install scipy
# RUN pip3 uninstall -y pillow
# RUN pip3 install "pillow<7"
RUN pip3 install seaborn
RUN pip3 install matplotlib
# RUN pip3 install "matplotlib>=3.2.2,<4"

# deep sort dependencies
RUN pip3 install filterpy
RUN pip3 install scikit-image
RUN pip3 install lap

RUN apt-get install -y 	v4l-utils

RUN mkdir -p /ws/additional_packages_ws/src
WORKDIR /ws/additional_packages_ws/src
RUN git clone https://github.com/jinmenglei/serial.git
RUN git clone -b iron https://github.com/ros-perception/vision_opencv.git
RUN mv vision_opencv/cv_bridge/ .
RUN rm -r vision_opencv/
RUN /bin/bash -c "source /opt/ros/iron/install/setup.bash && cd /ws/additional_packages_ws && colcon build"
RUN git clone -b ros2 https://github.com/ros-drivers/zbar_ros.git
RUN /bin/bash -c "source /ws/additional_packages_ws/install/setup.bash && cd /ws/additional_packages_ws && colcon build"
RUN apt-get install -y 	ffmpeg libyaml-cpp-dev
RUN git clone -b iron https://github.com/ros-perception/image_common.git
RUN apt-get install -y 	libogg-dev libtheora-dev
RUN /bin/bash -c "source /opt/ros/iron/install/setup.bash && cd /ws/additional_packages_ws && colcon build"
RUN git clone -b iron https://github.com/ros-perception/image_transport_plugins.git
RUN /bin/bash -c "source /opt/ros/iron/install/setup.bash && cd /ws/additional_packages_ws && colcon build"
RUN git clone -b ros2 https://github.com/ros-drivers/usb_cam.git
# RUN mv image_common/camera_info_manager/ .
# RUN mv image_common/image_transport/ .
# RUN mv image_common/camera_calibration_parsers/ .
# RUN rm -r image_common/
# RUN rosdep init
RUN rosdep update
RUN source /ws/additional_packages_ws/install/setup.bash &&  rosdep install --from-paths usb_cam --ignore-src -y
RUN /bin/bash -c "source /opt/ros/iron/install/setup.bash && cd /ws/additional_packages_ws && colcon build"

RUN pip3 install ipython

RUN echo 'source /ws/additional_packages_ws/install/setup.bash' >> /root/.bashrc

WORKDIR /severov_auv
CMD ["bash"]
