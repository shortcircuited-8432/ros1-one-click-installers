# ros1-one-click-installers
A collection of shell scripts to ease the process of installing RViz and ROS1 on external Ubuntu computers.

## INSTRUCTIONS FOR INSTALLING:

1. Download the RVIZ_ONE_CLICK_INSTALLER.sh shell script.
2. Move the installer to the folder you want RViz to be installed in. A catkin workspace will be added that contains the whole installation, so it's okay if the folder you choose is not empty.
3. **CONFIGURE THE SCRIPT IF NEEDED.** The script is configured to install ros-noetic-desktop-full for the **Stretch RE1** by default. The script _may_ work with other Stretch robots and versions of ROS, but it **has not been tested.**
   - Use `nano /path/to/RVIZ_ONE_CLICK_INSTALLER.sh` (or your preferred text editor) to edit the script.
4. In a new terminal, run `chmod +x RVIZ_ONE_CLICK_INSTALLER.sh`
5. In the terminal, run `sudo RVIZ_ONE_CLICK_INSTALLER.sh` to launch the script. **Do not forget to run the script with sudo.** The script will _not_ work properly if it doesn't have sudo permissions.
6. You're done! The script is _mostly_ hands-free, but it will prompt you to install extra packages.
