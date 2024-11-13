#!/bin/bash

clear 
opc=10
while [ $opc -ne 0 ]; do
	clear
	echo "Administracion de Puertos"
	echo "1) Abrir Puerto"
	echo "2) Cerrar Puerto"
	echo "0) Salir"
	read -p "Elija una opcion: " opc
	case $opc in
		1)
			read -p "Ingrese el nombre del puerto a abrir: " ap
			firewall-cmd --add-port=$ap/tcp
			clear 
			echo "El puerto $ap a sido abierto"
			read -p "Ingrese un boton para continuar: " boton
			;;
		2) 
			read -p "Ingrese el nombre del puerto a cerrar: " cp 
			firewall-cmd --remove-port=$cp/tcp
			clear 
			echo "El puerto $cp ha sido cerrado"
			read -p "Ingrese un boton para continuar: " boton
			;;
		*)
			;;

	esac
done
