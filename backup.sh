#!/bin/bash

# Directorio donde se almacenarán los backups
backup_dir="/ruta/del/directorio/de/backups"

# Solicitar al usuario que ingrese la ruta del directorio a respaldar
echo "Indica la ruta a respaldar:"
read directory_to_backup

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
