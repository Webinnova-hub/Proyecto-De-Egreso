#!/bin/bash 
 
archivo="alumnos.txt" 
opcion=123 
while test $opcion -ne 0 
do 
    echo "" 
    echo "-----Menu-----" 
    echo "1) Agregar Alumno" 
    echo "2) Modificar Alumno" 
    echo "3) Borrar Alumno" 
    echo "0) Salir" 
    echo "" 
    read opcion 
    case $opcion in 
        1) 
            while true; do 
                echo -n "Ingrese el nombre del alumno: " 
                read nombre 
                if [[ "$nombre" =~ ^[a-zA-Z]+$ ]]; then 
                    break 
                else 
                    echo "Error: El nombre solo puede contener letras." 
                fi 
            done 
            while true; do 
                echo -n "Ingrese el apellido del alumno: " 
                read apellido 
                if [[ "$apellido" =~ ^[a-zA-Z]+$ ]]; then 
                    break 
                else 
                    echo "Error: El apellido solo puede contener letras." 
                fi 
            done 
            while true; do 
                echo -n "Ingrese la cédula del alumno (8 dígitos): " 
                read cedula 
                if [[ "$cedula" =~ ^[0-9]{8}$ ]]; then 
                    if grep -q ":$cedula$" $archivo; then 
                        echo "Error: La cédula ya existe." 
                    else 
                        break 
                    fi 
                else 
                    echo "Error: La cédula debe contener solo 8 dígitos." 
                fi 
            done 
            while true; do 
                echo -n "Ingrese el ID del alumno: " 
                read id 
                if [[ "$id" =~ ^[0-9]+$ ]]; then 
                    if grep -q "^$id:" $archivo; then 
                        echo "Error: El ID ya existe." 
                    else 
                        break 
                    fi 
                else 
                    echo "Error: El ID solo puede contener números." 
                fi 
            done 
            echo "$id:$nombre:$apellido:$cedula" >> $archivo 
            echo "Alumno agregado correctamente." 
            username="${nombre,,}.${apellido,,}" 
            sudo useradd -m -s /bin/bash -d /home/$username -c "$nombre $apellido" $username 
            echo "Usuario del sistema creado: $username" 
            ;; 
        2) 
            echo -n "Ingrese el ID del alumno a modificar: " 
            read id 
            if grep -q "^$id:" $archivo; then 
                linea=$(grep "^$id:" $archivo) 
                echo "Datos actuales del alumno: $linea" 
                while true; do 
                    echo -n "Ingrese el nuevo nombre del alumno: " 
                    read nombre 
                    if [[ "$nombre" =~ ^[a-zA-Z]+$ ]]; then 
                        break 
                    else 
                        echo "Error: El nombre solo puede contener letras." 
                    fi 
                done 
                while true; do 
                    echo -n "Ingrese el nuevo apellido del alumno: " 
                    read apellido 
                    if [[ "$apellido" =~ ^[a-zA-Z]+$ ]]; then 
                        break 
                    else 
                        echo "Error: El apellido solo puede contener letras." 
                    fi 
                done 
                while true; do 
                    echo -n "Ingrese la nueva cédula del alumno (8 dígitos): " 
                    read cedula 
                    if [[ "$cedula" =~ ^[0-9]{8}$ ]]; then 
                        if grep -q ":$cedula$" $archivo; then 
                            if [[ "$cedula" == "$(echo $linea | cut -d: -f4)" ]]; then 
                                break 
                            else 
                                echo "Error: La cédula ya existe." 
                            fi 
                        else 
                            break 
                        fi 
                    else 
                        echo "Error: La cédula debe contener solo 8 dígitos." 
                    fi 
                done 
                sed -i "/^$id:/d" $archivo 
                echo "$id:$nombre:$apellido:$cedula" >> $archivo 
                echo "Alumno modificado correctamente." 
                username="${nombre,,}.${apellido,,}" 
                sudo usermod -l $username -d /home/$username -m -c "$nombre $apellido" $(grep "^$id:" 
$archivo | cut -d: -f5) 
                echo "Usuario del sistema modificado: $username" 
            else 
                echo "Error: ID no encontrado." 
            fi 
            ;; 
        3) 
            echo -n "Ingrese el ID del alumno a borrar: " 
            read id 
            if grep -q "^$id:" $archivo; then 
                username=$(grep "^$id:" $archivo | cut -d: -f5) 
                sudo userdel -r $username 
                echo "Usuario del sistema eliminado: $username" 
 
                sed -i "/^$id:/d" $archivo 
                echo "Alumno borrado correctamente." 
            else 
                echo "Error: ID no encontrado." 
            fi 
            ;; 
        0) 
            echo "Saliendo..." 
            ;; 
        *) 
            echo "Opción inválida. Intente de nuevo." 
            ;; 
    esac 
done