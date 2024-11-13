#!/bin/bash
clear
opc=10
while [ $opc -ne 0 ]; do
	clear
	echo "Configurar IP's"
	echo "[1] Permitir IP"
	echo "[2] Rechazar IP"
	echo "[0] Salir"

	read -p "Elija una opcion" opc
	clear
	case $opc  in
	
		1)
		read -p "Ingrese la IP a permitir" ai
		firewall-cmd --remove-rich-rule="rule family='ipv4' source address='$ai' reject"
		
		clear 
		echo  "La IP $ai ha sido permitida"
		read -p "Ingrese un  boton para continuar: " boton
		;;
		
		2)
		read -p "Ingrese la IP a rechazar: " ri
		firewall-cmd --add-rich-rule="rule family='ipv4' source address='$ri' reject"
		
		clear
		echo "La IP $ri ha sido rechazada"
		read -p "Ingrse un boton para continuar: " boton
		;;

		*)
			;;

	esac
done 
