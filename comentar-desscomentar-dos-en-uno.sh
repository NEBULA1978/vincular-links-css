#!/bin/bash

# Ruta del archivo styles.css
css_file="css/styles.css"

# Leer el contenido del archivo en un array
mapfile -t css_content < "$css_file"

while true; do
    # Mostrar el menú de opciones
    echo "Menú:"
    echo "1. Comentar una importación"
    echo "2. Descomentar una importación"
    echo "3. Comentar todas las importaciones"
    echo "4. Descomentar todas las importaciones"
    echo "5. Salir"

    # Leer la elección del usuario
    read -p "Seleccione una opción (1/2/3/4/5): " choice

    case $choice in
        1)
            # Mostrar la lista de importaciones y sus números de línea
            echo "Lista de importaciones en $css_file:"
            for i in "${!css_content[@]}"; do
                line="${css_content[$i]}"
                if [[ $line == *@import* ]]; then
                    echo "$i: $line"
                fi
            done

            # Leer la elección del usuario para comentar
            read -p "Ingrese el número de la importación que desea comentar (o 'q' para salir al menú principal): " comment_choice

            if [[ "$comment_choice" == "q" ]]; then
                continue
            fi

            # Verificar si la opción ingresada es válida
            if ! [[ "$comment_choice" =~ ^[0-9]+$ ]] || [ "$comment_choice" -ge "${#css_content[@]}" ]; then
                echo "Opción no válida. Por favor, ingrese un número de importación válido."
            else
                # Comentar la importación seleccionada
                css_content[$comment_choice]="/* ${css_content[$comment_choice]} */"
                printf "%s\n" "${css_content[@]}" > "$css_file"
                echo "Se ha comentado la importación seleccionada."
            fi
            ;;
        2)
            # Mostrar la lista de importaciones y sus números de línea
            echo "Lista de importaciones en $css_file:"
            for i in "${!css_content[@]}"; do
                line="${css_content[$i]}"
                if [[ $line == "/*"*"*/" ]]; then
                    echo "$i: $line"
                fi
            done

            # Leer la elección del usuario para descomentar
            read -p "Ingrese el número de la importación que desea descomentar (o 'q' para salir al menú principal): " uncomment_choice

            if [[ "$uncomment_choice" == "q" ]]; then
                continue
            fi

            # Verificar si la opción ingresada es válida
            if ! [[ "$uncomment_choice" =~ ^[0-9]+$ ]] || [ "$uncomment_choice" -ge "${#css_content[@]}" ]; then
                echo "Opción no válida. Por favor, ingrese un número de importación válido."
            else
                # Descomentar la importación seleccionada
                selected_line="${css_content[$uncomment_choice]}"
                if [[ "$selected_line" == "/*"*"*/" ]]; then
                    css_content[$uncomment_choice]="$(echo "$selected_line" | sed 's/\/\* //;s/ \*\/$//')" # Eliminar los caracteres /* y */
                    printf "%s\n" "${css_content[@]}" > "$css_file"
                    echo "Se ha descomentado la importación seleccionada."
                else
                    echo "La importación seleccionada no está comentada."
                fi
            fi
            ;;
        3)
            # Comentar todas las importaciones de golpe
            for i in "${!css_content[@]}"; do
                if [[ "${css_content[$i]}" != "/*"*"*/" ]]; then
                    css_content[$i]="/* ${css_content[$i]} */"
                fi
            done
            printf "%s\n" "${css_content[@]}" > "$css_file"
            echo "Se han comentado todas las importaciones."
            ;;
        4)
            # Descomentar todas las importaciones de golpe
            for i in "${!css_content[@]}"; do
                if [[ "${css_content[$i]}" == "/*"*"*/" ]]; then
                    css_content[$i]="$(echo "${css_content[$i]}" | sed 's/\/\* //;s/ \*\/$//')" # Eliminar los caracteres /* y */
                fi
            done
            printf "%s\n" "${css_content[@]}" > "$css_file"
            echo "Se han descomentado todas las importaciones."
            ;;
        5)
            echo "Saliendo del script."
            exit 0
            ;;
        *)
            echo "Opción no válida. Por favor, seleccione una opción válida (1/2/3/4/5)."
            ;;
    esac
done
