#!/bin/bash
pgrep roscore
if [[ $? == 0 ]]; then
	echo "roscore already running."
else
	echo "Starting roscore service..."
	roscore &
	wait
fi

#MAKE SURE TO CHANGE ROBOT_HOST TO YOUR ROBOT'S IP ADDRESS. THE DEFAULT WILL *NOT WORK*.
ROBOT_HOST=192.168.1.34
WORKSTATION_IP=$(hostname -I | awk '{print $1}')
PING_COUNT=4 #you can edit the ping count based on your connection speed. Higher ping counts will slow down the script, but will increase the chances of a successful connection.

if [[ -z "WORKSTATION_IP" ]]; then
	echo "Could not determine your local IP address."
	echo "Make sure you're connected to the same network as $ROBOT_HOST."
	exit 1
fi

export ROS_MASTER_URI=$ROBOT_MASTER_URI
export ROS_HOSTNAME=$WORKSTATION_IP

echo "ROS_MASTER_URI = $ROS_MASTER_URI"
echo "ROS_HOSTNAME = $ROS_HOSTNAME"
echo "Pinging robot..."
#ping -c $PING_COUNT $ROBOT_HOST >/dev/null 2>&1
while true; do
	ping -c $PING_COUNT $ROBOT_HOST && echo -e "\e[32mConnected successfully!\e[0m" && break || {
		echo -e "\e[31mCannot reach host at $ROBOT_HOST after $PING_COUNT attempts."
		echo -e "Connection may be slow or nonexistent.\e[33m Press C to continue anyway, R to retry connection, and any key to exit.\e[0m"
		read -n 1 ans
		#echo -e automatically interprets formatiing like \n
		case "$ans" in
			[cC])
				echo -e "\nProceeding..."
				break
				;;
			[rR])
				echo -e "\nRetrying..."
				;;
			*)
				echo -e "\n\e[31mProcess terminated. Exiting...\e[0m"
				exit 1
				;;
		esac
	}
done
echo "Starting RViz..."
while true; do
	ls --color=auto ~/stretch/catkin_ws/src/stretch_ros
	read -p "Type in a package to use: " package
	ls --color=auto $(rospack find $package)/rviz
	if [[ $? != 0 ]]; then
		echo -e "\e[31mPackage directory cannot be found or does not exist.\e[0m"
	else
		read -p "Choose config file (not including rviz): " config
		rviz -d $(rospack find $package)/rviz/$config.rviz || echo -e "\e[31mUnable to launch RViz. Is the service running on the robot? Is the package name correct? Is the rviz config correct?\e[0m"
		break
	fi
done
