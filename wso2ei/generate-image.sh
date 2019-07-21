#!/bin/bash

VER=${1:-1}
var=${2}
REG=${3:-"localhost:32000"}

echo "Build della demo di WSO2 ESB!"
echo


askpsh () {
    read -p "Url e porta del registro in cui fare la push? (localhost:32000) " -r
    echo
    REG=${REPLY:-"localhost:32000"}


    echo "registry remoto settato! < $REG >"

}
push (){
    echo "********************Sto taggando il DOCKER del demo-esb con <$REG> ********************"
     docker tag demo-esb:$VER  $REG/demo-esb:$VER

    echo "********************Sto eseguando una push su: $REG  del demo-esb ********************"
    echo
     docker push $REG/demo-esb:$VER
}





  
    echo "********************Sto creando il DOCKER del demo-esb********************"
    echo
     docker build -t demo-esb:$VER  ./dockerfiles

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

