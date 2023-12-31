#!/bin/bash

# Ruta del archivo styles.css
css_file="css/styles.css"

# Leer el contenido del archivo en un array
mapfile -t css_content < "$css_file"

# Mostrar la lista de importaciones y sus números de línea
echo "Lista de importaciones en $css_file:"
for i in "${!css_content[@]}"; do
    line="${css_content[$i]}"
    if [[ $line == *@import* ]]; then
        echo "$i: $line"
    fi
done

while true; do
    read -p "Ingrese el número de la importación que desea comentar, 'a' para comentar todas o 'q' para salir: " choice

    case $choice in
        q)
            echo "Saliendo del script."
            exit 0
            ;;
        a)
            # Comentar todas las importaciones una por una
            for i in "${!css_content[@]}"; do
                line="${css_content[$i]}"
                if [[ $line == *@import* ]]; then
                    css_content[$i]="/* ${css_content[$i]} */"
                fi
            done
            printf "%s\n" "${css_content[@]}" > "$css_file"
            echo "Se han comentado todas las importaciones."
            ;;
        *)
            # Verificar si la opción ingresada es válida
            if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -ge "${#css_content[@]}" ]; then
                echo "Opción no válida. Por favor, ingrese un número de importación válido."
            else
                # Comentar o descomentar la importación seleccionada
                if [[ "${css_content[$choice]}" == */*@import* ]]; then
                    css_content[$choice]="${css_content[$choice]/*\//@import}"
                else
                    css_content[$choice]="/* ${css_content[$choice]} */"
                fi
                printf "%s\n" "${css_content[@]}" > "$css_file"
                echo "Se ha comentado o descomentado la importación seleccionada."
            fi
            ;;
    esac
done
