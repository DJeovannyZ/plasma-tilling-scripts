# Shortcuts for KDE Plasma Tiling Manager

This repository contains scripts for creating keyboard shortcuts for KDE Plasma in an attempt to have a kind of tiling manager on 2 screens in KDE Plasma, with the monitors set up in extended screen mode.

## Installation

I recommend copying this folder to your `$home/scriptsUtils/` directory, and then importing the `shortcuts tilling plasma.kksrc` file.

Note: This script is configured to work with 1920x1200 monitors. If you have other resolutions, modify the scripts accordingly.

## Scripts

### changeWindowsPlasma

This script swaps windows between the two monitors.

### moveMouse.sh

This script moves the mouse to the next window.

### VirtualDesktops Folder

This folder contains scripts to handle each virtual desktop so that they are individual for each screen. (Note: this is the first version and there may be errors). Usage is simple: if the mouse is on monitor 1 and you are located on virtual desktop 1 and want to go to virtual desktop 2, you send the open windows on monitor 2 to the desktop to which you are going, in this case virtual desktop 2, so that it simulates that the windows on monitor 2 do not move, you only navigate to the desktop where the mouse is located.

### Conclusion

This is a simple solution for those who want to use dual monitors with KDE Plasma and enjoy a tiling manager experience. Feel free to modify and improve the scripts according to your needs.

