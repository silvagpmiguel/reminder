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

if [ "" != "$YAD_OK" ]; then
    echo "Removing yad and dependencies..."
    sudo apt-get remove -y yad && sudo apt-get autoremove -y
fi

echo "## Removing Binary Files"
rm -rf $INSTALL_FOLDER

echo "## Removing Reminder Theme"
sudo rm -rf $TO_THEMES_FOLDER
sudo rm -rf $TO_ICONS_FOLDER

echo "## Removing Bashrc Configs & Symbolic Links"
echo "Removing Non-network local connections to access control list..."
sed -i '/^xhost local.*/d' ~/.bashrc
echo "Removing symbolic links..."
rm $BIN_FOLDER/remind
rm $BIN_FOLDER/rremind
echo "# Reminder Uninstallation Complete!"