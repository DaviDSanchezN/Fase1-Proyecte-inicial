#!/bin/bash

# Función para crear un usuario con el nombre en formato "usuario + número" y la contraseña "super3"
crear_usuario_local() {
    local base_username="$1"
    local user_numbers=("$@")

    # Crear cada usuario localmente
    for number in "${user_numbers[@]}"; do
        local username="$base_username$number"

        # Verificar si el usuario ya existe localmente
        if id "$username" &>/dev/null; then
            echo "El usuario \"$username\" ya existe localmente. Saltando..."
        else
            # Crear el usuario localmente con contraseña "super3"
            sudo useradd -m -s /bin/bash -p super3 "$username"
            echo "Usuario \"$username\" creado con éxito localmente. Contraseña: super3"
        fi
    done
}

# Obtener el nombre base de usuario
read -p "Por favor, introduzca el nombre base de usuario: " base_username

# Obtener el número máximo de usuario
read -p "Por favor, introduzca el número máximo de usuario: " max_user_number

# Crear cada usuario localmente
user_numbers=($(seq -w 1 "$max_user_number"))
crear_usuario_local "$base_username" "${user_numbers[@]}"

echo "Creación masiva de usuarios local completada."
