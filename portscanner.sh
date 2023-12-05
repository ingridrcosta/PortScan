#!/usr/bin/env bash

###########################################################################

    #Na primeira execucao chame o Script como bash e nome do script
    #Ex.: bash ScannerPort.sh

    #pode ser colocado parametros tambem como: 
    #Ex.: bash Scannerport.sh 192.168.1.1 40 80

###########################################################################


if [ ! -x "$0" ]; then
        chmod +x "$0"

        if [ $? -ne 0 ]; then
                echo "Erro ao tornar o script executavel" | awk ' {print strftime("%d/%m/%Y %H:%M"), $0 }' > "$GeradorLogsNC"
                exit 1 
        else
                echo "Script executado com sucesso." | awk '{print strftime("%d/%m/%Y %H:%M"), $0 }' > "$GeradorLogsNC"       
        fi
fi


Diretorio="$SEU DIRETORIO" 
GeradorLogsNC="$SEU DIRETORIO/log.txt"

exec 3>&1 4>&2 
exec > "$GeradorLogsNC" 2>&1 


echo "Starting script at $(date)" >&3


if [[ ! -d $Diretorio ]];then
        mkdir -p "$Diretorio"
        mkdir -p "$(dirname "$GeradorLogsNC")"
        echo "Diretorio criado: $Diretorio" | awk ' {print strftime("%d/%m/%Y %H:%M"), $0 }' >> "$GeradorLogsNC"
    else   
        echo "Diretorio Existente" "$Diretorio" | awk ' {print strftime("%d/%m/%Y %H:%M"), $0 }' >> "$GeradorLogsNC"    


fi

if ! command -v nc &>>/dev/null; then

        sudo apt install netcat-openbsd -y
        echo "NetCat instalado." | awk '{print strftime("%d/%m/%Y %H:%M"), $0 }' >> "$GeradorLogsNC"

fi
if [ $# -eq 0 ]; then
        echo " Insira Bloco IP /24 +  Range de portas validos!"| awk '{print strftime("%d/%m/%Y %H:%M"), $0 }' >> "$GeradorLogsNC"
        exit 1
fi 
BlocoDeIP="$1"
Mascara="$2"
Porta_Inicial="$3"
Porta_Final="$4"
range="$Porta_inicial-$Porta_final"


ip_saida=$(echo "$BlocoDeIP"/"$Mascara" | awk -F '[.]' '{print $1"."$2"."$3"."}')

echo "" >> "$GeradorLogsNC"

if [[ $Mascara == 24 ]]; then
for octeto in $(seq 1 255); do 
        bloco_ip="$ip_saida$octeto"
        for mascara in $(seq $Mascara 32);do
                for port in $(seq $Porta_Inicial $Porta_Final);do
                        nc -zv $bloco_ip $port 2>&1 | awk '{print strftime("%d/%m/%Y %H:%M"), $0 }' >> "$GeradorLogsNC"
                done       
        done
done

else 
if [[ $Mascara == 30 ]]; then
for octeto in $(seq 1 3); do 
        bloco_ip="$ip_saida$octeto"
        for mascara in $(seq $Mascara 32);do
                for port in $(seq $Porta_Inicial $Porta_Final);do
                        nc -zv $bloco_ip $port 2>&1 | awk '{print strftime("%d/%m/%Y %H:%M"), $0 }' >> "$GeradorLogsNC"
                done       
        done
done
fi
fi

exec 1>&3 2>&4 
