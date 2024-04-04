#!/bin/bash

# Función para iniciar un servicio
start_service() {
    echo "Iniciando el servicio $SERVICE en $IP..."
    sshpass -p "$PASSWORD" ssh "$USER@$IP" "sudo systemctl start $SERVICE"
}

# Función para detener un servicio
stop_service() {
    echo "Deteniendo el servicio $SERVICE en $IP..."
    sshpass -p "$PASSWORD" ssh "$USER@$IP" "sudo systemctl stop $SERVICE"
}

# Función para comprobar el estado de un servicio
check_status() {
    echo "Comprobando estado del servicio $SERVICE en $IP..."
    sshpass -p "$PASSWORD" ssh "$USER@$IP" "systemctl is-active --quiet $SERVICE && echo 'Estado: Funcionando' || echo 'Estado: Detenido'"
}

# Main
main() {
    if [ "$#" -lt 5 ]; then
        echo "Uso: $0 <IP> <usuario> <contraseña> <comando> <servicio>"
        exit 1
    fi

    IP=$1
    USER=$2
    PASSWORD=$3
    COMMAND=$4
    SERVICE=$5

    case $COMMAND in
        "status")
            check_status
            ;;
        "start")
            start_service
            ;;
        "stop")
            stop_service
            ;;
        *)
            echo "Comando no válido"
            exit 1
            ;;
    esac
}

# Interfaz de usuario
echo "¡Bienvenido al gestor de servicios!"
echo "-----------------------------------"
read -p "Por favor, introduzca su IP: " IP
read -p "Por favor, introduzca su nombre de usuario: " USER
read -sp "Por favor, introduzca su contraseña: " PASSWORD
echo ""
read -p "Por favor, introduzca el nombre del servicio: " SERVICE

# Ejecutar el script principal
main "$IP" "$USER" "$PASSWORD" "$@" "$SERVICE"
