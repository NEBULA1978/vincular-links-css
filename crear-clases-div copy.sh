#!/bin/bash

# Función para agregar un elemento
function agregar_elemento() {
    echo "Ingrese el contenido del nuevo elemento:"
    read nuevo_contenido
    nuevo_elemento='<div class="item9">'"$nuevo_contenido"'</div>'
    sed -i '/<!-- <div class="item6">6<\/div>/a\'$'\n'"$nuevo_elemento" estilos2hijos.css
}

# Función para eliminar un elemento
function eliminar_elemento() {
    echo "Ingrese el número del elemento que desea eliminar (1-5):"
    read numero_elemento
    if [ $numero_elemento -ge 1 ] && [ $numero_elemento -le 5 ]; then
        sed -i '/<div class="item'$numero_elemento'">/d' estilos2hijos.css
    else
        echo "Número de elemento no válido. Debe estar entre 1 y 5."
    fi
}

# Menú principal
while true; do
    echo "Menú:"
    echo "1. Agregar elemento"
    echo "2. Eliminar elemento"
    echo "3. Salir"
    read opcion

    case $opcion in
        1)
            agregar_elemento
            ;;
        2)
            eliminar_elemento
            ;;
        3)
            exit 0
            ;;
        *)
            echo "Opción no válida. Por favor, seleccione una opción válida."
            ;;
    esac
done
