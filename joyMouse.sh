#! /bin/bash
#joyMouse.sh
#author: unknown (found it online)
#description: Use joystick as a mouse

#first you must install the following
# sudo apt-get install xserver-xorg-input-joystick
if [ "$1" == "d" ]; then
	echo Disabling gamepad as mouse device.
	xinput --set-prop "9" "Device Enabled" 0
elif [ "$1" == "l" ]; then
	xinput list
else
	echo Enabling gamepad as mouse device.
	xinput --set-prop "9" "Device Enabled" 1
fi
