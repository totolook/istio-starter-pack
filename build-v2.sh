#!/bin/bash

VER=${1:-2}
var=${2}
REG=${3:-"localhost:32000"}

echo "Build del api2 seconda versione!"
echo


askpsh () {
    read -p "Url e porta del registro in cui fare la push? (localhost:32000) " -r
    echo
    REG=${REPLY:-"localhost:32000"}


    echo "registry remoto settato! < $REG >"

}
push (){
    echo "********************Sto taggando il DOCKER del api2-v2 con <$REG> ********************"
     docker tag api2:$VER  $REG/api2:$VER

    echo "********************Sto eseguando una push su: $REG  del api2-v2 ********************"
    echo
     docker push $REG/api2:$VER
}





   echo "********************Sto creando il jar del api2-v2********************"
   echo
    mvn install -f api2-v2
echo

    echo "********************Sto creando il DOCKER del api2-v2********************"
    echo
     docker build -t api2:$VER  ./api2-v2

echo

if [ ! \( -z "$var" \) -a \( "$var" == "push" \)  ]
then
 push
else


    read -p "Vuoi fare la push sul registro di K8S [s/N] ? " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[SsYy]$ ]]
    then
        askpsh
        push
    fi

fi


echo "Completato :D "
