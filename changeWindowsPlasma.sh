#!/bin/bash

desktop=9
current_desktop=$(xdotool get_desktop)
# Definir las clases de ventanas a buscar
classes=("brave-browser" "alacritty" "Dolphin" "Java" "systemsettings" "Discord")
# Obtener los IDs de todas las ventanas con esas clases
window_ids=()
for class in "${classes[@]}"; do
    ids=$(xdotool search --onlyvisible --desktop "$current_desktop" --class "$class")
    window_ids+=($ids)
done

# Separar los IDs de ventanas en dos arreglos según su posición en pantalla monitor1=()
posicion1X=()
posicion1Y=()
monitor1=()
posicion2X=()
posicion2Y=()

for id in "${window_ids[@]}"; do
    echo "id: $id"

    geometry=$(xdotool getwindowgeometry "$id")
    posicion_x=$(echo "$geometry" | awk '/Position:/ {print $2}' | awk -F'[x,]' '{print $1}')
    posicion_y=$(echo "$geometry" | awk '/Position:/ {print $2}' | awk -F'[x,]' '{print $2}')
    if (( $posicion_x < 1920 )); then
        monitor1+=($id)
        posicion_x=$(( $posicion_x + 1920 ))
        posicion1X+=($posicion_x)
        if [[ $posicion_y == -13 ]]; then
          posicion_y=19
        fi
        posicion1Y+=($posicion_y)
    else
        monitor2+=($id)
        posicion_x=$(( $posicion_x - 1920 ))
        posicion2X+=($posicion_x)
        if [[ $posicion_y == 19 ]]; then
          posicion_y=-13
        fi
        posicion2Y+=($posicion_y)
    fi
done

# Ordenar ambos arreglos por posición en pantalla
IFS=$'\n' monitor1=($(sort -n <<<"${monitor1[*]}"))
posicion1X=($(echo "${posicion1X[*]}" | tr ' ' '\n' | sort -n))
posicion1Y=($(echo "${posicion1Y[*]}" | tr ' ' '\n' | sort -n))
monitor2=($(sort -n <<<"${monitor2[*]}"))
posicion2X=($(echo "${posicion2X[*]}" | tr ' ' '\n' | sort -n))
posicion2Y=($(echo "${posicion2Y[*]}" | tr ' ' '\n' | sort -n))


#mandar a otro desktop cada ventana
for ((i=0; i<${#monitor1[@]}; i++)) do
    xdotool set_desktop_for_window "${monitor1[$i]}" $desktop
    # xdotool windowmove "${monitor1[$i]}" "${posicion1X[$i]}" "${posicion1Y[$i]}"
    desktop=$(( $desktop + 1))
done

for ((i=0; i<${#monitor2[@]}; i++)) do
    xdotool set_desktop_for_window "${monitor2[$i]}" $desktop
    # xdotool windowmove "${monitor2[$i]}" "${posicion2X[$i]}" "${posicion2Y[$i]}"
    desktop=$(( $desktop + 1))
done


# Mover las ventanas ordenadas
#
for ((i=0; i<${#monitor1[@]}; i++)) do
  xdotool set_desktop_for_window "${monitor1[$i]}" $current_desktop
  xdotool windowmove "${monitor1[$i]}" "${posicion1X[$i]}" "${posicion1Y[$i]}"
  # xdotool getwindowname "${monitor1[$i]}"
  # echo "y : ${posicion1Y[$i]}"
done
for ((i=0; i<${#monitor2[@]}; i++))
do
  xdotool set_desktop_for_window "${monitor2[$i]}" $current_desktop
  xdotool windowmove "${monitor2[$i]}" "${posicion2X[$i]}" "${posicion2Y[$i]}"
  # xdotool getwindowname "${monitor2[$i]}"
  # echo "y : ${posicion2Y[$i]}"
done

