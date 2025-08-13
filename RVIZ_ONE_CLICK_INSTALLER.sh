#!/bin/bash

username=$(whoami)
apt update

#Change repo to the name of the ros depository you want to install
repo="ros-noetic-desktop-full"
name="noetic"

apt list $repo | grep installed

if [[ $? != 0 ]]; then
	echo -e "\e[36mPackage $repo not installed. Setting up sources.list...\e[0m"
	sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
	echo -e "\e[36mSetting up keys and installing curl...\e[0m"
	apt install -y curl
	curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
	echo -e "\e[36mInstalling $repo...\e[0m"
	apt install -y $repo
	echo -e "\e[36mDone\e[0m"
fi

grep "source /opt/ros/$name/setup.bash" ~/.bashrc >/dev/null || echo "source /opt/ros/$name/setup.bash" >> ~/.bashrc
source ~/.bashrc

echo -e "\e[36mWould you like to install extra dependencies for creating and managing your own ROS workspaces? [Y/N] \e[0m"
read -n 1 ans
case "$ans" in
	[yY])
		echo -e "Installing extra packages..."
		apt install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential 
                ;;
        *)
                echo -e "\nSkipping extra package install. Installing only rosdep."
                apt install -y python3-rosdep
                ;;
esac

echo -e "\e[36mInstalling and updating rosdep...\e[0m"
rosdep init
sudo -u $username rosdep update

echo -e "\n\e[1;33mINITIAL SETUP COMPLETE. INSTALLING RVIZ...\e[0m"
mkdir -p ./catkin_ws/src
cd ./catkin_ws/src

#-The following will ALMOST CERTAINLY need to be changed to suit needs that differ from the default.-----------------------------
git clone https://github.com/hello-robot/stretch_ros.git
cd .. #cd to ./catkin_ws
apt list ros-$name-navigation | grep installed

if [[ $? != 0 ]]; then
        echo -e "\e[36mPackage ros-$name-navigation not installed. Installing...\e[0m"
        apt update
        apt install -y ros-$name-navigation
        echo -e "\e[36mDone\e[0m"
fi

sudo -u $username catkin_make

#currently in ./catkin_ws

grep "source $PWD/devel/setup.bash" ~/.bashrc || echo "source $PWD/devel/setup.bash" >> ~/.bashrc

#add aliases to ~/.bash_aliases
cd ..
grep "alias runrviz='$PWD/rviz_launch.sh'" ~/.bash_aliases || echo "alias runrviz='$PWD/rviz_launch.sh'" >> ~/.bash_aliases

source ~/.bashrc
echo -e "\n\e[1;33mAll tasks completed. Use runrviz to run RViz.\e[0m"
