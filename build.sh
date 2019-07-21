#!/bin/bash

VER=${1:-latest}
var=${2}
REG=${3:-"localhost:32000"}

askpsh () {
    read -p "Url e porta del registro in cui fare la push? (localhost:32000) " -r
    echo
    REG=${REPLY:-"localhost:32000"}


    echo "registry remoto settato! < $REG >"

}
push (){
    for((i=0;i<3;i++))
do
    echo "********************Sto taggando il DOCKER del api$((i + 1)) con <$REG> ********************"
     docker tag api$((i + 1)):$VER  $REG/api$((i + 1)):$VER  
done

for((i=0;i<3;i++))
do
    echo "********************Sto eseguando una push su: $REG  del api$((i + 1)) ********************"
    echo
     docker push $REG/api$((i + 1)):$VER  
done

}




for((i=0;i<3;i++))
do
   echo "********************Sto creando il jar del api$((i + 1))********************"	
   echo
    mvn install -f api$((i + 1))
done

echo

for((i=0;i<3;i++))
do
    echo "********************Sto creando il DOCKER del api$((i + 1))********************"
    echo
     docker build -t api$((i + 1)):$VER  ./api$((i + 1)) 
done

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