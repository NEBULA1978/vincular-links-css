#!/bin/bash

# Ruta del archivo styles.css
css_file="css/styles.css"

# Leer el contenido del archivo en un array
mapfile -t css_content < "$css_file"

# Mostrar la lista de importaciones y sus números de línea
echo "Lista de importaciones en $css_file:"
for i in "${!css_content[@]}"; do
    line="${css_content[$i]}"
    if [[ $line == *"@import"* ]]; then
        echo "$i: $line"
    fi
done

# Preguntar al usuario cuál importación desean descomentar
read -p "Ingrese el número de la importación que desea descomentar (o 'q' para salir): " choice

# Verificar si el usuario desea salir
if [[ "$choice" == "q" ]]; then
    echo "Saliendo del script."
    exit 0
fi

# Verificar si la opción ingresada es válida
if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -ge "${#css_content[@]}" ]; then
    echo "Opción no válida. Por favor, ingrese un número de importación válido."
    exit 1
fi

# Descomentar la importación seleccionada
selected_line="${css_content[$choice]}"
if [[ "$selected_line" == "/*"*"*/" ]]; then
    css_content[$choice]="${selected_line:2:-2}" # Eliminar los caracteres /* y */
fi

# Guardar el contenido modificado en el archivo
printf "%s\n" "${css_content[@]}" > "$css_file"

echo "Se ha descomentado la importación seleccionada."
