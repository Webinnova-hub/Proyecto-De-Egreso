#!/bin/bash

 mostrar_menu() {
    echo "-----------------------------------"
    echo "      MENÚ DE ADMINISTRACIÓN       "
    echo "-----------------------------------"
    echo "1. Crear un backup manual"
    echo "2. Ver logs de backups"
    echo "3. Ver tareas programadas (crontab)"
    echo "4. Reiniciar servicio cron"
    echo "5. Salir"
    echo "-----------------------------------"
    echo -n "Seleccione una opción: "
 }

 crear_backup() {
    echo "Iniciando backup manual..."
    /home/usuario/backup.sh
    echo "Backup completado."
 }

 ver_logs() {
    echo "Mostrando logs de backups recientes..."
    if [ -f /var/log/backup.log ]; then
        cat /var/log/backup.log
    else
        echo "No hay logs disponibles."
    fi
 }

 ver_crontab() {
    echo "Tareas programadas actualmente en crontab:"
    sudo crontab -l
 }
 
 reiniciar_cron() {
    echo "Reiniciando el servicio cron..."
    sudo systemctl restart crond
    echo "Servicio cron reiniciado."
 }
 
 while true; do
    mostrar_menu
    read opcion
    case $opcion in
        1) crear_backup ;;
        2) ver_logs ;;
        3) ver_crontab ;;
        4) reiniciar_cron ;;
        5) echo "Saliendo del menú..."; exit 0 ;;
        *) echo "Opción no válida, intente de nuevo." ;;
    esac
    echo ""
 done