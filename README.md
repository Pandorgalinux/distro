# distro
Distribuição educacional Pandorga Linux. Pacotes principais. 

English version: See bellow

Os scripts e códigos-fonte aqui contidos sao usados para criar o Pandorga GNU/Linux.
Normalmente você nao precisa fazer isto em casa, uma versao diaria do Pandorga pode ser encontrada no site do Pandorga. Es scrit é usado pelos desenvolvedores do Pandorga, ou se você deseja estudar, aprimorar ou usar em seu próprio projeto.

Para usar os scripts do Pandorga e gerar a iso em seu ambiente local, siga os seguintes passos num computador com o Debian ou o próprio Pandorga instalado (os comandos devem ser usados como root):

1- Instale o Git e o Live Build (http://debian-live.alioth.debian.org/live-manual/unstable/manual/html/live-manual.en.html)
# apt-get install git live-build

2 - Clone o repositório Git do Pandorga:
# git clone https://github.com/Pandorgalinux/distro.git

3 - Acesse o diretório distro:
# cd distro

4 - Execute o script para criar a ISO do Pandorga:
# ./isoBuilder/bin/gerarLive

5 - Se deu tudo certo, a ISO foi gerada no diretório PandorgaLinux
# ls -l ./isoBuilder/PandorgaLinux/*.iso


