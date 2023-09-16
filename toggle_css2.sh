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
    read -p "Ingrese el número de la importación que desea descomentar, 'a' para descomentar todas o 'q' para salir: " choice

    case $choice in
        q)
            echo "Saliendo del script."
            exit 0
            ;;
        a)
            # Descomentar todas las importaciones de golpe
            for i in "${!css_content[@]}"; do
                if [[ "${css_content[$i]}" == "/*"*"*/" ]]; then
                    css_content[$i]="$(echo "${css_content[$i]}" | sed 's/\/\* //;s/ \*\/$//')" # Eliminar los caracteres /* y */
                fi
            done
            printf "%s\n" "${css_content[@]}" > "$css_file"
            echo "Se han descomentado todas las importaciones."
            ;;
        *)
            # Verificar si la opción ingresada es válida
            if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -ge "${#css_content[@]}" ]; then
                echo "Opción no válida. Por favor, ingrese un número de importación válido."
            else
                # Descomentar la importación seleccionada
                selected_line="${css_content[$choice]}"
                if [[ "$selected_line" == "/*"*"*/" ]]; then
                    css_content[$choice]="$(echo "$selected_line" | sed 's/\/\* //;s/ \*\/$//')" # Eliminar los caracteres /* y */
                fi
                printf "%s\n" "${css_content[@]}" > "$css_file"
                echo "Se ha descomentado la importación seleccionada."
            fi
            ;;
    esac
done
