{: lang="en"}
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

{: lang="en"}
# Shortcuts para KDE Plasma Tiling Manager

Este repositorio contiene scripts para crear atajos de teclado para KDE Plasma con el objetivo de tener una especie de gestor de ventanas en mosaico en 2 pantallas en KDE Plasma, con los monitores configurados en modo de pantalla extendida.

## Instalación

Se recomienda copiar esta carpeta en su directorio `$home/scriptsUtils/` y luego importar el archivo `shortcuts tilling plasma.kksrc`.

Nota: este script está configurado para funcionar con monitores de 1920x1200. Si tiene otras resoluciones, modifique los scripts en consecuencia.

## Scripts

### changeWindowsPlasma

Este script intercambia ventanas entre los dos monitores.

### moveMouse.sh

Este script mueve el ratón a la siguiente ventana.

### Carpeta VirtualDesktops

Esta carpeta contiene scripts para manejar cada escritorio virtual de forma que sean individuales para cada pantalla (Nota: esta es la primera versión y puede haber errores). El uso es sencillo: si el mouse está en el monitor 1 y se encuentra en el escritorio virtual 1 y desea ir al escritorio virtual 2, envíe las ventanas abiertas en el monitor 2 al escritorio virtual al que se dirige, en este caso, el escritorio virtual 2, de manera que simula que las ventanas del monitor 2 no se mueven, solo se navega al escritorio donde se encuentra el ratón.


### Conclusion

Esta es una solución sencilla para aquellos que desean usar monitores dobles con KDE Plasma y disfrutar de una experiencia de tiling manager. Siéntete libre de modificar y mejorar los scripts según tus necesidades.
