from pathlib import Path

from ament_index_python import get_package_share_directory

from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument
from launch.actions import IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import LaunchConfiguration
from launch_ros.actions import Node


def generate_launch_description():

    calibration_config_dir = Path(get_package_share_directory('severov_cam')) / "configs"
    front_camera_calibration_path = calibration_config_dir / "front_camera.yaml"
    bottom_camera_calibration_path = calibration_config_dir / "bottom_camera.yaml"
    # front camera
    front_camera_topic_arg = DeclareLaunchArgument(
        "front_camera_topic", default_value='/stingray/topics/front_camera'
    )
    front_camera_info_topic_arg = DeclareLaunchArgument(
        "front_camera_info_topic", default_value='/stingray/topics/front_camera/camera_info'
    )
    front_camera_path_arg = DeclareLaunchArgument(
        "front_camera_path", default_value='/dev/video0'
    )
    front_camera_calibration_path_arg = DeclareLaunchArgument(
        "front_camera_calibration_path", default_value="package://severov_cam/configs/front_camera.yaml"
    )
    # bottom camera
    bottom_camera_topic_arg = DeclareLaunchArgument(
        "bottom_camera_topic", default_value='/stingray/topics/bottom_camera'
    )
    bottom_camera_info_topic_arg = DeclareLaunchArgument(
        "bottom_camera_info_topic", default_value='/stingray/topics/bottom_camera/camera_info'
    )
    bottom_camera_path_arg = DeclareLaunchArgument(
        "bottom_camera_path", default_value='/dev/video2'
    )
    bottom_camera_calibration_path_arg = DeclareLaunchArgument(
        "bottom_camera_calibration_path", default_value=str(bottom_camera_calibration_path)
    )

    # load ros config
    return LaunchDescription([
        front_camera_topic_arg,
        front_camera_info_topic_arg,
        front_camera_path_arg,
        front_camera_calibration_path_arg,
        bottom_camera_topic_arg,
        bottom_camera_info_topic_arg,
        bottom_camera_path_arg,
        bottom_camera_calibration_path_arg,

        # front camera
        Node(
            package='usb_cam',
            executable='usb_cam_node_exe',
            name='front_camera_node',
            remappings=[
                ('/image_raw', LaunchConfiguration("front_camera_topic")),
                ('/camera_info', LaunchConfiguration("front_camera_info_topic")),
            ],
            parameters=[
                {'video_device': LaunchConfiguration("front_camera_path")},
                {'camera_info_url': LaunchConfiguration("front_camera_calibration_path")},
                {'camera_name': 'front_camera'},
                {'image_width': 640},
                {'image_height': 480},
            ],
            respawn=True,
            respawn_delay=1,
        ),

        # bottom camera
        # Node(
        #     package='usb_cam',
        #     executable='usb_cam_node_exe',
        #     name='bottom_camera_node',
        #     remappings=[
        #         ('/image_raw', LaunchConfiguration("bottom_camera_topic")),\
        #         ('/camera_info', LaunchConfiguration("bottom_camera_info_topic")),
        #     ],
        #     parameters=[
        #         {'video_device': LaunchConfiguration("bottom_camera_path")},
        #         {'camera_info_url': LaunchConfiguration("bottom_camera_calibration_path")},
        #         {'camera_name': 'bottom_camera'},
        #     ],
        #     respawn=True,
        #     respawn_delay=1,
        # ),
    ])
