# PortScan_NetCat
Olá, tudo bem? 
Me chamo Ingrid, e junto com meus amigos (Bruno, João, Jaqueline, Maykon, Leandro) do curso de Redes de Computadores da faculdade PUC Virtual,
desenvolvemos o Port Scanner, com a versão NMAP e NetCat (disponível no PortScan_NetCat).

O intuito desta ferramenta é realizar o escaneamento(farejamento) das portas abertas em um range de IPs.
A instalação é simples, será necessário apenas: 
  -Terminal Linux ou extensão para ler bash no Vs Code (Windows);
  -.Net Framework versão 8 (pode ser utilizado versões anteriores);
  -Nmap e/ou NetCat instalado, caso não possua o script vai instalar automaticamente;
  -Live Server, extensão para parte visual (caso não deseje o script funciona em terminal);
  -Para MAC é importante ter o gawk instalado e/ou atualizado (caso não possua o script fará a instalação);

# Como funciona o script: 
  ## Para ativar o ScannerPort02.sh
Inicialmente escolha qual script será utilizado, neste exemplo mencionarei sobre o NetCat.
  -No terminal digite por: bash ./portscanner.sh e o IP com máscara 24 e o range das portas, exemplo: 
    **bash ./portscanner.sh 192.168.0.1/24 80 443**
O comando bash vai ativar o script para que ele se torne executável (podendo ser ativado com **chmod**).
Na primeira tentativa vai apresentar uma mensagem de erro solicitando que o script seja compilado em 
**modo root**. 
No terminal digite por sudo su e digite a senha de Administrador para compilar, ou digite **sudo ./portscanner.sh e o IP mascara 24 e o range de portas**.
  
 ## Para funcionar o Servidor.
Após ativado o ScannerPort02.sh, digite no terminal **sudo dotnet run** ou **sudo su para entrar em root e Dotnet run**
será gerado esta saida: 
info: Microsoft.Hosting.Lifetime[14]
      **Now listening on: http://localhost:5154** <--- clique neste link de localhost
info: Microsoft.Hosting.Lifetime[0]
      Application started. Press Ctrl+C to shut down.
info: Microsoft.Hosting.Lifetime[0]
      Hosting environment: Development
info: Microsoft.Hosting.Lifetime[0]
      Content root path: /seudiretorio/PortScan

Após esta mensagem o servidor estará disponível para uso. **Não é necessário realizar este processo para usar apenas o script.**

## Para usar a parte visual no Navegador.

-Abra o código no Vs Code;
-Funcione o Servidor;
-Clique em Go Live no canto direito do Vs Code para abrir o Live Server;
-Informe o IP e o último octeto a ser pesquisado. 



* *Nota do Desenvolvedor* *
Ainda estamos trablhando para implementar o união das ferramentas NetCat e Nmap, por causa disso a função
NetCat ainda não está habiltada.


Att.: Ingrid Ruth.
      
