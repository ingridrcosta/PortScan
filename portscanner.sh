#!/usr/bin/env bash

###########################################################################

    #Na primeira execução chame o Script como bash e nome do script
    #Ex.: bash ScannerPort.sh

    #pode ser colocado parametros também como: 
    #Ex.: bash Scannerport.sh 192.168.1.1 80 443

###########################################################################


if [ ! -x "$0" ]; then
    chmod +x "$0"

    if [ $? -ne 0 ]; then
          echo "Erro ao tornar o script executável" | awk ' {print strftime("%d/%m/%Y %H:%M"), $0 }' >> "$GeradorLogs"
          exit 1 
        else
            echo "Script executado com sucesso." | awk '{print strftime("%d/%m/%Y %H:%M"), $0 }' >> "$GeradorLogs"       
    fi
    
    #exec "$0" "$@"
fi


Diretorio="$HOME/ScannerPort/Logs"
GeradorLogs="$HOME/ScannerPort/Logs/log.txt"

if [[ ! -d $Diretorio ]];
    then 

        mkdir -p "$Diretorio" 
        mkdir -p "$(dirname "$GeradorLogs")"

        echo "Diretorio criado: $Diretorio" | awk ' {print strftime("%d/%m/%Y %H:%M"), $0 }' >> "$GeradorLogs"
    else
        echo "Diretorio Existente" "$Diretorio" | awk ' {print strftime("%d/%m/%Y %H:%M"), $0 }' >> "$GeradorLogs"    
    fi

    if ! command -v nc &>/dev/null; then

            sudo apt install netcat-openbsd -y
            echo "NetCat instalado." | awk '{print strftime("%d/%m/%Y %H:%M"), $0 }' >>"$GeradorLogs"
        else    
            echo "NetCat não foi instalado, o programa já exite." | awk '{print strftime("%d/%m/%Y %H:%M"), $0 }' >>"$GeradorLogs"
    
fi

 if [ $# -ne 3 ]; then
    #echo "Uso: $0 <"$BlocoDeIP"> <"$Porta_Inicial"> <"$Porta_Final">"
    exit 1
 fi  


 BlocoDeIP="$1"
 Porta_Inicial="$2"
 Porta_Final="$3"

if [[ ! $BlocoDeIP =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}(/24)?$ ]];
        then 
            echo "IP inválido, verifique a digitação: $BlocoDeIP" | awk '{print strftime("%d/%m/%Y %H:%M"), $0 }' >> "$GeradorLogs"
            exit 1
fi


if [[ ! $Porta_Inicial =~ ^[0-9]+$ || ! $Porta_Final =~ ^[0-9]+$ || \
      $Porta_Inicial -lt 1 || $Porta_Final -gt 65535 || \
      $Porta_Inicial -gt $Porta_Final ]]; then
    exit 1
fi

for ((Porta = Porta_Inicial; Porta <= Porta_Final; Porta++)); do
    nc -zv "$BlocoDeIP" "$Porta" 2>&1 | awk '{print strftime("%d/%m/%Y %H:%M"), $0 }' >> "$GeradorLogs"
done






















###########################################################################

        #Estou trabalhando para avaliar um bloco de IPs inteiro
        #sendo ele de qualquer máscara
        #Mas como o NetCat é lento talvez esta parte não entre no código
        #Em fases de testes o for está em um loop no qual não lê outros IPs
        #Isso será corrigido futuramente se necessário

###########################################################################

        #LeituraNc01=$(echo "$BlocoDeIP" | cut -d '/' -f 1)   
        #LeituraNc02=$(echo "$BlocoDeIP" | cut -d '/' -f 2) 

    #for ((i=0; i <= 255; i++));
       #do 
        #Endereco_IP="$LeituraNc01.$i/$LeituraNc02"         

        #for ((avalie= "$Porta_Inicial"; avalie <= "$Porta_Final"; avalie++));
        #    do
        #    if [[ $avalie =~ ^[0-9]+$ && $avalie =~ ^[0-9]+$ && $avalie -ge 1 && $avalie -le 65535 ]];
        #     then    
        #        nc -z -v "$BlocoDeIP" "$avalie" "$avalie" >> "$GeradorLogs" 2>&1 | awk ' {print strftime("%d/%m/%Y %H:%M"), $0 }' #>> "$GeradorLogs"
        #        else
        #            echo "Portas inválidas: $avalie"
        #    fi 
        #done
    #done


###########################################################################
