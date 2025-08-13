# ros1-one-click-installers
A collection of shell scripts to ease the process of installing RViz and ROS1 on external Ubuntu computers.

### PREREQUISITES:
1. An **Ubuntu 20.04 LTS installation.** It _has_ to be 20.04, as that's the only OS that ROS1 runs on properly.
2. A Hello Robot Stretch robot, preferably the Stretch RE1.
3. **For using RViz:** an SSH connection to your robot. Virtual Studio Code's SSH extension pack is extremely helpful for remotely viewing the files on your robot.\
[Here is a really great place to start using RViz.](https://docs.hello-robot.com/0.2/stretch-ros/stretch_navigation/)

## INSTRUCTIONS FOR INSTALLING:

1. Download the .zip file.
2. Unzip into the folder you want RViz to be installed in. RViz will be installed wherever RVIZ_ONE_CLICK_INSTALLER.sh is located, so keep that in mind. **rviz_launch.sh is expected to be in the same folder as RVIZ_ONE_CLICK_INSTALLER.sh.** A catkin workspace will be added that contains the whole installation, so it's okay if the folder you choose is not empty.
3. **CONFIGURE THE SCRIPT IF NEEDED.** The script is configured to install ros-noetic-desktop-full for the **Stretch RE1** by default. The script _may_ work with other Stretch robots and versions of ROS, but it **has not been tested.**
   - Use `nano /path/to/RVIZ_ONE_CLICK_INSTALLER.sh` (or your preferred text editor) to edit the script.
4. In a new terminal, run `chmod +x RVIZ_ONE_CLICK_INSTALLER.sh`
5. In the terminal, run `sudo RVIZ_ONE_CLICK_INSTALLER.sh` to launch the script. **Do not forget to run the script with sudo.** The script will _not_ work properly if it doesn't have sudo permissions.
6. Edit rviz_launch.sh to set the robot's IP. Do not skip this step!
### Optional (kind of):
7. Make sure that `source opt/ros/<noetic>/setup.bash` (replace <noetic> with the name of your ROS installation) is added to your .bashrc file. The script _should_ do this automatically, but check anyway.
8. Just like step 7, check if `source /<path/to/catkin/workspace>/devel/setup.bash` is added to your .bashrc file.
9. Check ~/.bash_aliases for `alias runrviz='/<path/to>/rviz_launch.sh'`.
    - If you had to make any changes to either ~/.bashrc or ~/.bash_aliases, make sure that you **source** both before starting.

10. You're done! Use runrviz to start RViz.
