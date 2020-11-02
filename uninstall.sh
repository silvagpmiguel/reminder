#!/bin/bash

FROM_THEMES_FOLDER=/reminder/themes/theme/Yaru-Grey-dark;
TO_THEMES_FOLDER=/usr/share/themes/Yaru-colors/;
FROM_ICONS_FOLDER=/reminder/themes/icons/Yaru-Grey;
TO_ICONS_FOLDER=/usr/share/icons/Yaru-colors/;
BIN_FOLDER=~/bin
INSTALL_FOLDER=~/bin/reminder

echo "# Beginning Reminder Installation!"
echo "## Verifying Yad Installation";
YAD_OK=$(dpkg-query -W --showformat='${Status}\n' ya);
if [ "" != "$YAD_OK" ]; 
    echo "Removing yad..."
    sudo apt-get remove;
fi

echo "## Removing Binary Files"
rm -rf $INSTALL_FOLDER

echo "## Removing Reminder Theme"
echo "Removing icons/themes folders..."
sudo rm -rf $TO_THEMES_FOLDER
sudo rm -rf $TO_ICONS_FOLDER
echo "Adding Yaru-Grey-dark theme..."
sudo rm -rf $FROM_THEMES_FOLDER $TO_THEMES_FOLDER
sudo rm -rf $FROM_ICONS_FOLDER $TO_ICONS_FOLDER

echo "## Removing Bashrc Configs & Symbolic Links"
echo "Removing Non-network local connections to access control list...";
sed -i '/^xhost local.*/d' ~/.bashrc
echo "Removing symbolic links...";
rm $BIN_FOLDER/remind
rm $BIN_FOLDER/rremind
echo "# Reminder Uninstallation Complete!";