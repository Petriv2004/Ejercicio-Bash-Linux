#!/bin/bash
# PROGRAMA QUIZ - ANDRÉS FELIPE TRIVIÑO GARZÓN

echo "Bienvenido al script del quiz"
echo "Esperando que conecte la USB con la clave..."

usb_buscada="0930:6545"
while true; do
if lsusb | grep -q "$usb_buscada"; then
if [ -f /media/petriv/FELIPE/inicio.txt ]; then
codigo=$(cat /media/petriv/FELIPE/inicio.txt)
    if [ "$codigo" = "006" ]; then
        if [ -d "$HOME/A" ]; then
                rm -r "$HOME/A"
        fi
echo "USB identificada"

#CREACIÓN DE  DIRECTORIOS
mkdir -p "$HOME/A"
rutaInicial="$HOME/A"
mkdir -p "$rutaInicial/C/D/H"
mkdir -p "$rutaInicial/C/B/E"
mkdir -p "$rutaInicial/C/B/F/G"

#CREADO, LLENADO Y LECTURA POR VOZ DEL CONFIG1.TXT
touch "$rutaInicial/C/B/F/G/Config1.txt"
# Archivo de salida
output_file="$rutaInicial/C/B/F/G/Config1.txt"

# Obtener la fecha y hora actuales
current_datetime=$(date +"%Y-%m-%d a las %H:%M:%S")

# Obtener información del sistema
cpu_model=$(grep -m 1 "model name" /proc/cpuinfo | cut -d: -f2 | xargs)
ram_total=$(free -h | awk '/^Mem/ {print $2}')
disk_total=$(df -h --total | grep 'total' | awk '{print $2}')
ip_address=$(ip -o -4 addr show | awk '/scope global/ {print $4}' | head -n 1)
os_name=$(grep "^PRETTY_NAME" /etc/os-release | cut -d= -f2 | tr -d '"')

echo "Soy Felipe Triviño y mi computador tiene un procesador $cpu_model," >> $output_file
echo "una memoria RAM de $ram_total gigabytes, su disco duro tiene $disk_total de capacidad," >> $output_file
echo "y el computador tiene una IP $ip_address y el sistema operativo es $os_name." >> $output_file
echo "Esta información es dada el día $current_datetime." >> $output_file

#espeak -f $output_file -s 150 -p 70
espeak -a 400 -v es -s140 -p 50 -f  $output_file --stdout | aplay

#CREACIÓN DEL CONFIG2.HTML Y PRENDIDA DEL LED
touch "$rutaInicial/C/D/H/index.html"

#CREAR EL ENLACE SIMBOLICO
echo "Creando el árbol de directorios"
echo "Creando Enlace Simbólico"
ln -s "$rutaInicial/C/D/H/index.html" "$rutaInicial/C/B/E/EnlaceSimbolico.html"

output_html="$rutaInicial/C/D/H/index.html"
car_usb=$(lsusb | grep "0930:6545")
arbol_creado=$(tree ~/A)
disk_space=$(df -h --output=avail / | tail -n 1)
ram_size_kb=$(grep MemTotal /proc/meminfo | awk '{print $2}')
ram_size_mb=$((ram_size_kb / 1024))
variablesEntorno=$(printenv)

echo "<html>" >> $output_html
echo "<head>" >> $output_html
echo "<title>Quiz Felipe Triviño </title>" >> $output_html
echo "<meta charset='UTF-8'>" >> $output_html
echo "</head>" >> $output_html
echo "<body>" >> $output_html
echo "<h2>Nombre, Programa y Fecha</h2>" >> $output_html
echo "<p>Andrés Felipe Triviño Garzón, Ingeniería de Sistemas y Fecha: $current_datetime </p>" >> $output_html
echo "<h2>Características de Memoria USB</h2>" >> $output_html
echo "<p>$car_usb</p>" >> $output_html
echo "<h2>Árbol de directorio creado</h2>" >> $output_html
echo "<pre>$arbol_creado</pre>" >> $output_html
echo "<h2>Cantidad de disco y tamaño de la RAM</h2>" >> $output_html
echo "<p>Espacio libre en disco: $disk_space</p>" >> $output_html
echo "<p>Tamaño total de la RAM: ${ram_size_mb}MB</p>" >> $output_html
echo "<h2>Información PC y archivo Config1.html</h2>" >> $output_html
echo "<pre>$(cat "/home/felipe-trivi-o/A/C/B/F/G/Config1.txt")</pre>" >> $output_html
echo "<h3>Información Ordenada</h3>" >> $output_html
echo "<p>Procesador: $cpu_model</p>" >> $output_html
echo "<p>Disco: $disk_total</p>" >> $output_html
echo "<p>RAM: $ram_total</p>" >> $output_html
echo "<p>IP: $ip_address</p>" >> $output_html
echo "<p>Sistema Operativo: $os_name</p>" >> $output_html
echo "<h2>Variables de entorno</h2>" >> $output_html
echo "<pre>$variablesEntorno</pre>" >> $output_html
echo "</body>" >> $output_html
echo "</html>" >> $output_html

echo "Encendiendo el led de la mayúscula"
./led.sh

#ENVIAR APACHE POR SSHPASS Y ABRIR EL APACHE CON LA WEB
./pruebaSSH.sh

#ENVIAR EL CORREO ELECTRÓNICO
echo "Enviando Correo electrónico"
{
  echo "Subject: Asunto del Correo"
  echo "Cuerpo del correo"
} | msmtp -a gmail correoDeEnvío
break
else
echo "La clave es incorrecta"
break
fi
fi
fi
done
 
