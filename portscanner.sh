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
                echo "Erro ao tornar o script executavel" | awk ' {print strftime("%d/%m/%Y %H:%M"), $0 }' >> "$GeradorLogs"
                exit 1 
        else
                echo "Script executado com sucesso." | awk '{print strftime("%d/%m/%Y %H:%M"), $0 }' >> "$GeradorLogs"       
        fi
fi


Diretorio="SEU DIRETORIO" #EX.: "/home/user/Downloads"
GeradorLogs="SEU DIRETORIO/log.txt" #EX.: "/home/user/DownLoads/Log/log.txt" Nota: Alguns diretorios podem dar erro de "Diretorio nao existente", recomendado alterar o diretorio para um caminho mais curto, evite diretorios ambiguos. 

if [ ! -d "$diretorio" ];then
        mkdir -p "$Diretorio"
        mkdir -p "$(dirname "$GeradorLogs")"
fi

if ! command -v nc &>/dev/null; then

        sudo apt install netcat-openbsd -y
        echo "NetCat instalado." | awk '{print strftime("%d/%m/%Y %H:%M"), $0 }' >"$GeradorLogs"

fi

BlocoDeIP="$1"
port_inicial="$2"
port_final="$3"
range="$port_inicial-$port_final"

if [ $# -eq 0 ]; then
        echo " Insira Bloco IP /24 +  Range de portas validos!"| awk '{print strftime("%d/%m/%Y %H:%M"), $0 }' > "$GeradorLogs"
        exit 1
fi  

if [[ ! $BlocoDeIP =~ ^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.0\/24$ ]] ;
then 
        echo " Bloco IP invalido : $BlocoDeIP (exemplo: 192.168.1.0/24)"| awk '{print strftime("%d/%m/%Y %H:%M"), $0 }' > "$GeradorLogs"
        exit 1
fi

if [ -n "$BlocoDeIP" ] &&  [[ ! $range =~ ^[0-9]{1,5}-[0-9]{1,5}$ ]] ;then
        echo " Range de portas invalido / Nao especificado (Valido 1 a 65535)" | awk '{print strftime("%d/%m/%Y %H:%M"), $0 }' > "$GeradorLogs"
        exit 1

fi

ip_saida=$(echo "$BlocoDeIP" | awk -F '[.]' '{print $1"."$2"."$3"."}')

echo "" > "$GeradorLogs"

for octeto in $(seq 20 30); do 
        bloco_ip="$ip_saida$octeto"
        for port in $(seq $port_inicial $port_final);do 
                nc -zv "$bloco_ip" "$port" 2>&1 | awk '/succeeded/{print strftime("%d/%m/%Y %H:%M"),$3,$4,$5,$6}' >> "$GeradorLogs"
        done
done

