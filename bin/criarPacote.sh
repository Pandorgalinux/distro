#!/bin/bash

function display_help {
    echo "Usage: $0 [options...] package-name" >&2
    echo
    echo "   -g | --git <repositorio>	 Clona repositório Git <repositorio> e prepara para enviar os arquivos, mas nao envia"
    echo "   --base-dir	              	 Diretório de trabalho"
    echo "   --package-version        	 Versao do Pacote a ser criado. Caso seja omitido, será 1.0 "
    echo "   --debian-version        	 Versao do Debian, por padrao stable "
    echo "   -h | --help              	 Mostra esta ajuda "
    echo
    # echo some stuff here for the -a or --add-options 
    exit 1
}

PACKAGE_VERSION="1.0"
BASE_DIR="/opt/pandorga/packages"
DEBIAN_VERSION="stable"
export HOMEPAGE="http://pandorgalinux.com.br/"
export EMAIL="dev@pandorgalinux.com.br"
export DEBFULLNAME="Pandorga GNU/Linux Development Team"

while true; do
  case "$1" in
      -h | --help)
  	  display_help; shift;
      ;;
      -g | --git)
  	  GIT="$2"; shift 2;
      ;;
      --base-dir)
  	  BASE_DIR="$2"; shift 2;
      ;;
      --package-version)
  	  PACKAGE_VERSION="$2"; shift 2;
      ;;
      --debian-version)
  	  DEBIAN_VERSION="$2"; shift 2;
      ;;
      -- ) shift; break ;;
      * ) break ;;
  esac
done

PACKAGE_NAME="$1"
if [ -z "$PACKAGE_NAME" ]; then
	display_help
fi

echo "Por favor confirme os dados para criar o pacote Debian:"
echo "   - Diretório de trabalho: $BASE_DIR"
echo "   - Nome do Pacote: $PACKAGE_NAME"
echo "   - Versao: $PACKAGE_VERSION"
if [ -n "$GIT" ]; then
	echo "   - Repositório GIT: $GIT"
fi

read -r -p "Você têm certeza? [s/N] " response
case "$response" in
    [yYsSjJ]) ;;
    *) echo "Abortando..."; exit 1;;
esac

if [ -d "$BASE_DIR/$PACKAGE_NAME-$PACKAGE_VERSION" ]; then
	echo "Diretório $BASE_DIR/$PACKAGE_NAME-$PACKAGE_VERSION existe, abortando!"
	exit 1;
fi

if [ -d "$BASE_DIR/$PACKAGE_NAME" ]; then
	echo "Diretório $BASE_DIR/$PACKAGE_NAME existe, abortando!"
	exit 1;
fi


mkdir -pv "$BASE_DIR/$PACKAGE_NAME-$PACKAGE_VERSION"

if [ -n "$GIT" ]; then
	cd "$BASE_DIR/$PACKAGE_NAME"
	echo "Obtendo Git de $GIT em $BASE_DIR/$PACKAGE_NAME"
	git clone $GIT || { exit 1; }
fi


cd "$BASE_DIR/$PACKAGE_NAME-$PACKAGE_VERSION"
dh_make --native -s

#Remove versao do nome do diretório:
cp -a "$BASE_DIR/$PACKAGE_NAME-$PACKAGE_VERSION/debian" "$BASE_DIR/$PACKAGE_NAME"
rm -Rf "$BASE_DIR/$PACKAGE_NAME-$PACKAGE_VERSION"

#Troca a versao do Debian para evitar erros na geracao do pacote
sed -i -- "s/unstable/$DEBIAN_VERSION/g" "$BASE_DIR/$PACKAGE_NAME/debian/changelog"

#Troca as configuracoes do control
sed -i -- "s/unknown/misc/g" "$BASE_DIR/$PACKAGE_NAME/debian/control"
sed -i -- "s/<insert the upstream URL, if relevant>/$HOMEPAGE/g" "$BASE_DIR/$PACKAGE_NAME/debian/control"
if [ -n "$GIT" ]; then
	sed -i -- "8s/.*/Vcs-Git:$GIT/g" "$BASE_DIR/$PACKAGE_NAME/debian/control"
fi

if [ -n "$GIT" ]; then
	cd "$BASE_DIR/$PACKAGE_NAME"
	git add *
	git commit -m "Criado pacote $PACKAGE_NAME"
fi
