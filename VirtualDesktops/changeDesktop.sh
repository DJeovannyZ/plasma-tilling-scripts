#!/bin/bash
current_desktop=$(xdotool get_desktop)
# Definir las clases de ventanas a buscar classes=("brave-browser" "alacritty" "Dolphin" "Java" "systemsettings" "Discord")

# Obtener los IDs de todas las ventanas con esas clases y almacenarlos en los arrays globales
function getWindows {
    echo ""
    echo "Obteniendo ventanas escritorio: $1"
    window_ids=() monitor1=()
    monitor2=()
    classes=(brave-browser alacritty Dolphin Java systemsettings Discord)
    for class in "${classes[@]}"; do
        ids=$(xdotool search --onlyvisible --desktop $1 --class "$class")
        window_ids+=($ids)
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
            else
                monitor2+=("$id")
                posicion2X+=("$posicion_x")
                posicion2Y+=("$posicion_y")
            fi
        done
    else
        echo "no hay ventanas en $1"
    fi

}

function mv1Current {
    for ((i=0; i<${#current_monitor1[@]}; i++)) do
        xdotool set_desktop_for_window "${current_monitor1[$i]}" $1
        # xdotool windowmove "${current_monitor1[$i]}" "${posicion1X[$i]}" "${posicion1Y[$i]}"
        name=$(xdotool getwindowname "${current_monitor1[$i]}")
        echo "moviendo: $name a escritorio $1"
    done
}
function mv2Current {
    for ((i=0; i<${#current_monitor2[@]}; i++)) do
        xdotool set_desktop_for_window "${current_monitor2[$i]}" $1
        # xdotool windowmove "${current_monitor2[$i]}" "${posicion2X[$i]}" "${posicion2Y[$i]}"
        name=$(xdotool getwindowname "${current_monitor2[$i]}")
        echo "moviendo: $name a escritorio $1"
    done
}

function mv1New {
    for ((i=0; i<${#new_monitor1[@]}; i++)) do
        xdotool set_desktop_for_window "${new_monitor1[$i]}" $1
        # xdotool windowmove "${new_monitor1[$i]}" "${posicion1X[$i]}" "${posicion1Y[$i]}"
        name=$(xdotool getwindowname "${new_monitor1[$i]}")
        echo "moviendo: $name a escritorio $1"
    done
}
function mv2New {
    for ((i=0; i<${#new_monitor2[@]}; i++)) do
        name=$(xdotool getwindowname "${new_monitor2[$i]}")
        xdotool set_desktop_for_window "${new_monitor2[$i]}" $1
        # xdotool windowmove "${new_monitor2[$i]}" "${posicion2X[$i]}" "${posicion2Y[$i]}"
        echo "moviendo: $name a escritorio $1"
    done
}

function mainChange () {
    desktop=$1
    mouse_location=$(xdotool getmouselocation)
    mouse_x=$(echo $mouse_location | cut -d ' ' -f 1 | cut -d ':' -f 2)
    if [ "$current_desktop" -ne $desktop ]; then
        getWindows "$current_desktop"
        current_monitor1=("${monitor1[@]}")
        current_monitor2=("${monitor2[@]}")
        getWindows $desktop
        new_monitor1=("${monitor1[@]}")
        new_monitor2=("${monitor2[@]}")
        if (( $mouse_x < 1920 )); then
            if [ ! ${#current_monitor2[@]} -eq 0 ] && [ ! ${#new_monitor2[@]} -eq 0 ]; then
                mv2New 9
                mv2Current $desktop
                xdotool set_desktop $desktop
                getWindows 9
                new_monitor1=("${monitor1[@]}")
                new_monitor2=("${monitor2[@]}")
                mv2New $current_desktop
            elif [ ! ${#current_monitor2[@]} -eq 0 ] && [ ${#new_monitor2[@]} -eq 0 ]; then
                mv2Current $desktop
                xdotool set_desktop $desktop
            elif [ ${#current_monitor2[@]} -eq 0 ] && [ ! ${#new_monitor2[@]} -eq 0 ]; then
                mv2New $current_desktop
                xdotool set_desktop $desktop
            elif [ ${#current_monitor2[@]} -eq 0 ] && [ ${#new_monitor2[@]} -eq 0 ]; then
                xdotool set_desktop $desktop
            fi
        else
            if [ ! ${#current_monitor1[@]} -eq 0 ] && [ ! ${#new_monitor1[@]} -eq 0 ]; then
                mv1New 9
                mv1Current $desktop
                xdotool set_desktop $desktop
                getWindows 9
                new_monitor1=("${monitor1[@]}")
                new_monitor2=("${monitor2[@]}")
                mv1New $current_desktop
            elif [ ! ${#current_monitor1[@]} -eq 0 ] && [ ${#new_monitor1[@]} -eq 0 ]; then
                mv1Current $desktop
                xdotool set_desktop $desktop
            elif [ ${#current_monitor1[@]} -eq 0 ] && [ ! ${#new_monitor1[@]} -eq 0 ]; then
                mv1New $current_desktop
                xdotool set_desktop $desktop
            elif [ ${#current_monitor1[@]} -eq 0 ] && [ ${#new_monitor1[@]} -eq 0 ]; then
                xdotool set_desktop $desktop
            fi
        fi
    else        echo "current_desktop es igual a cero"
    fi
}

