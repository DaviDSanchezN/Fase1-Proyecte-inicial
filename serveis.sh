#!/bin/bash
# Función para iniciar un servicio
start_service() {
    echo "Iniciando el servicio $SERVICE en $IP..."
    ssh -t "$USER@$IP" "sudo systemctl start $SERVICE"
}

# Función para detener un servicio
stop_service() {
    echo "Deteniendo el servicio $SERVICE en $IP..."
    ssh -t "$USER@$IP" "sudo systemctl stop $SERVICE"
}

# Función para comprobar el estado de un servicio
check_status() {
    echo "Comprobando estado del servicio $SERVICE en $IP..."
    ssh -t "$USER@$IP" sudo systemctl status $SERVICE
}

# Interfaz de usuario
echo "¡Bienvenido al gestor de servicios!"
echo "-----------------------------------"
read -p "Por favor, introduzca su IP: " IP
read -p "Por favor, introduzca su nombre de usuario: " USER
read -p "Por favor, introduzca el nombre del servicio: " SERVICE
read -p "Por favor, introduzca el comando que desea ejecutar (status/start/stop): " COMMAND

# Ejecutar el script principal
main() {
    if [ "$#" -lt 4 ]; then
        echo "Uso: $0 <IP> <usuario> <contraseña> <comando> <servicio>"
        exit 1
    fi

    IP=$1
    USER=$2
    COMMAND=$3
    SERVICE=$4

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

main "$IP" "$USER" "$PASSWORD" "$COMMAND" "$SERVICE"

