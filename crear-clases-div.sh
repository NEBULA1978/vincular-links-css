#!/bin/bash

# Pregunta al usuario cuántos elementos desea agregar (empezando desde 1)
read -p "¿Cuántos elementos deseas agregar (empezando desde 1)? " num_elements

# Verifica que el número sea válido
if [ $num_elements -ge 0 ]; then
  # Abre el archivo HTML para agregar elementos
  echo "<!-- Elementos agregados automáticamente -->" > temp.html
  for ((i = 1; i <= num_elements; i++)); do
    echo "    <div class=\"grid-container\">" >> temp.html
    echo "        <div class=\"item$i\">$i</div>" >> temp.html
    echo "    </div>" >> temp.html
  done

  # Combina el archivo temporal con el archivo original y guarda la salida en "grid-container-hijos-modificado.html"
  cat grid-container-hijos.html temp.html > grid-container-hijos-modificado.html

  # Limpia el archivo temporal
  rm temp.html

  echo "Se han agregado $num_elements elementos al archivo 'grid-container-hijos-modificado.html'."
else
  echo "Número inválido. Debes agregar al menos un elemento."
fi
