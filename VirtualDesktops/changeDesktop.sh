#!/bin/bash
current_desktop=$(xdotool get_desktop)
# Definir las clases de ventanas a buscar classes=("brave-browser" "alacritty" "Dolphin" "Java" "systemsettings" "Discord")

# Obtener los IDs de todas las ventanas con esas clases y almacenarlos en los arrays globales
function getWindows {
    echo ""
    echo "Obteniendo ventanas escritorio: $1"
    window_ids=()
    monitor1=()
    monitor2=()
    posicion1X=()
    posicion1Y=()
    posicion2X=()
    posicion2Y=()
    classes=(brave-browser alacritty Dolphin Java systemsettings Discord)
    for class in "${classes[@]}"; do
        ids=$(xdotool search --onlyvisible --desktop $1 --class "$class")
        window_ids+=($ids)
        echo "$ids"
    done
    if [ ! ${#window_ids[@]} -eq 0 ]; then
        for id in "${window_ids[@]}"; do
            geometry=$(xdotool getwindowgeometry "$id")
            posicion_x=$(echo "$geometry" | awk '/Position:/ {print $2}' | awk -F'[x,]' '{print $1}')
            posicion_y=$(echo "$geometry" | awk '/Position:/ {print $2}' | awk -F'[x,]' '{print $2}')
            if (( $posicion_x < 1920 )); then
                monitor1+=("$id")
                posicion1X+=("$posicion_x")
                posicion1Y+=("$posicion_y")
                name=$(xdotool getwindowname $id)
                echo "M1 - $name $id $posicion_x $posicion_y"
            else
                monitor2+=("$id")
                posicion2X+=("$posicion_x")
                posicion2Y+=("$posicion_y")
                echo "M2 - $name $id $posicion_x $posicion_y"
            fi
        done
    else
        echo "no hay ventanas en $1"
    fi

}
function mv1 {
    for ((i=0; i<${#monitor1[@]}; i++)) do
        xdotool set_desktop_for_window "${monitor1[$i]}" $1
        # xdotool windowmove "${monitor1[$i]}" "${posicion1X[$i]}" "${posicion1Y[$i]}"
        echo "moviendo: M1"
        xdotool getwindowname "${monitor1[$i]}"
        echo " a escritorio $1"
    done
}
function mv2 {
    for ((i=0; i<${#monitor2[@]}; i++)) do
        xdotool set_desktop_for_window "${monitor2[$i]}" $1
        # xdotool windowmove "${monitor2[$i]}" "${posicion2X[$i]}" "${posicion2Y[$i]}"
        echo "moviendo: M2"
        xdotool getwindowname "${monitor2[$i]}"
        echo " a escritorio $1"
    done
}

function mainChange () {
    desktop=$1
    mouse_location=$(xdotool getmouselocation)
    mouse_x=$(echo $mouse_location | cut -d ' ' -f 1 | cut -d ':' -f 2)
    echo "mouse $mouse_x"

    if [ "$current_desktop" -ne $desktop ]; then
        getWindows "$current_desktop"
        if (( $mouse_x < 1920 )); then
                mv2 9
            getWindows $desktop
                mv2 "$current_desktop"
            getWindows 9
                mv2 $desktop
        else
                mv1 9
            getWindows $desktop
                mv1 "$current_desktop"
            getWindows 9
                mv1 $desktop
        fi
        xdotool set_desktop $desktop
    else
        echo "current_desktop es igual a cero"
    fi
}

main "$@"
