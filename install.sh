#!/bin/bash

INSTALL_FOLDER=~/bin/reminder
FROM_THEMES_FOLDER=$INSTALL_FOLDER/themes/theme/Yaru-Grey-dark
TO_THEMES_FOLDER=/usr/share/themes/Yaru-colors/
FROM_ICONS_FOLDER=$INSTALL_FOLDER/themes/icons/Yaru-Grey
TO_ICONS_FOLDER=/usr/share/icons/Yaru-colors/
BIN_FOLDER=~/bin

echo "# Beginning Reminder Installation!"
echo "## Verifying Yad Installation"
YAD_OK=$(dpkg-query -W --showformat='${Status}\n' yad)

if [ "" = "$YAD_OK" ]; then
    echo "No. Installing yad..."
    sudo apt-get update -y && sudo apt-get install -y yad
else
    echo "Yes"
fi

set -e

echo "## Setting up Reminder Environment"
mkdir -p $INSTALL_FOLDER
echo "Moving files to /reminder..."
mv -n remind $INSTALL_FOLDER/
mv -n awk-reminder $INSTALL_FOLDER/
mv -n uninstall.sh $INSTALL_FOLDER/
mv -n README.md $INSTALL_FOLDER/
mv -n reminder.properties $INSTALL_FOLDER/
mv -n rremind $INSTALL_FOLDER/
mv -n themes $INSTALL_FOLDER/
touch $INSTALL_FOLDER/reminders.txt
echo "Moving to install folder..."
cd $INSTALL_FOLDER
echo "Setting needed executable permissions..."
chmod +x remind awk-reminder rremind

echo "## Installing Reminder Default Theme"
echo "Creating icons/themes folders..."
sudo mkdir -p $TO_THEMES_FOLDER
sudo mkdir -p $TO_ICONS_FOLDER
echo "Adding Yaru-Grey-dark theme..."
sudo cp -r $FROM_THEMES_FOLDER $TO_THEMES_FOLDER
sudo cp -r $FROM_ICONS_FOLDER $TO_ICONS_FOLDER

echo "## Configuring Bashrc & Setting Symbolic Links"
echo "Adding Non-network local connections to access control list..."
printf "\nxhost local:$USER > /dev/null\n" >> ~/.bashrc
echo "Adding symbolic links for remind and rremind..."
ln -s $INSTALL_FOLDER/remind $BIN_FOLDER/remind
ln -s $INSTALL_FOLDER/rremind $BIN_FOLDER/rremind
echo "Refreshing bashrc..."
. ~/.bashrc
echo "# Reminder Installation Complete!"