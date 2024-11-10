#!/bin/bash

 ORIGEN="/home/usuario/data"
 DESTINO="/home/usuario/backups/backup_$(date +\%Y\%m\%d_\%H\%M\%S).tar.gz"
 mkdir -p /home/usuario/backups
 LOG_FILE="/var/log/backup.log"
 {
    echo "-----------------------------------"
    echo "Fecha: $(date)"
    echo "Iniciando backup manual..."
    if tar -czf "$DESTINO" "$ORIGEN"; then
        echo "Backup realizado correctamente en: $DESTINO"
    else
        echo "Error durante la creación del backup."
    fi
    echo "-----------------------------------"
    echo ""
 } >> "$LOG_FILE" 2>&1