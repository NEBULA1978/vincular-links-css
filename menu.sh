#!/bin/bash

while true; do
    echo "Menú de opciones:"
    echo "1. Ejecutar toggle_css.sh (comentar)"
    echo "2. Ejecutar toggle_css2.sh (descomentar)"
    echo "3. Salir"

    read -p "Seleccione una opción: " choice

    case $choice in
        1)
            ./toggle_css.sh
            ;;
        2)
            ./toggle_css2.sh
            ;;
        3)
            echo "Saliendo del menú."
            exit 0
            ;;
        *)
            echo "Opción no válida. Por favor, seleccione una opción válida."
            ;;
    esac
done
