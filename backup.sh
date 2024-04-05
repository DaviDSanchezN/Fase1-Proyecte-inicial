#!/bin/bash

# Directorio donde se almacenarán los backups
read -p "Indica quins fitxers vols emmagatzemar" backup_dir

# Solicitar al usuario que ingrese la ruta del directorio a respaldar
read -p "Indica la ruta a respaldar:" directory_to_backup

# Comprobar si el directorio de backups existe, si no, crearlo
if [ ! -d "$backup_dir" ]; then
    mkdir -p "$backup_dir"
fi

# Comprobar la cantidad de archivos de backup en el directorio
num_backups=$(ls -l "$backup_dir" | grep "^-" | wc -l)

# Si hay más de 5 archivos de backup, eliminar el más antiguo
if [ "$num_backups" -ge 5 ]; then
    oldest_backup=$(ls -t "$backup_dir" | tail -1)
    rm "$backup_dir/$oldest_backup"
fi

# Crear el nombre del archivo de backup
backup_file="backup_$(date +%Y%m%d_%H%M%S).tar.gz"

# Crear el archivo de backup
tar -czf "$backup_dir/$backup_file" "$directory_to_backup"

echo "Backup completado: $backup_file"
