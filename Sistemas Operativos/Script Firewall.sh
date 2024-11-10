#!/bin/bash
clear

opcion=123
while [ $opcion -ne 0 ]; do
	echo "Administración del Firewall"
	echo "1) Administrar Puertos"
	echo "2) Administrar IP's"
	echo "3) Administrar Servicios"
	echo "4) Ver Configuración"
	echo "5) Recargar Cambios"
	echo "6) Dejar Cambios como Permanente"
	echo "0) Salir"

	read -p "Ingrese una opción: " opcion
	case $opcion in
		1)
			bash ./puertos.sh
			;;
		2)
			bash ./ips.sh
			;;
		3)
			bash ./servicios.sh
			;;
		4)
			clear
			firewall-cmd --list-all
			read -p "Presione cualquier tecla para continuar: " tecla
			;;
		5)
			firewall-cmd --reload
			clear
			echo -e "Se ha recargado la configuración correctamente\n"
			read -p "Presione cualquier tecla para continuar: " tecla
			;;
		6)
			firewall-cmd --runtime-to-permanent
			clear
			echo -e "La Configuración se ha cambiado a Permanente\n"
			read -p "Presione cualquier tecla para continuar: " tecla
			;;
		*)
			;;

	esac
clear
done
