#!/bin/bash

##########################################################################################################################################
MONGODB_ADMIN_USER="admin"
MONGODB_ADMIN_PASS="4dmInP4ssw0rd"
MONGODB_USER=$MONGODB_USER
MONGO_PASS=$MONGODB_USER
DATABASES=$(echo $CREATE_DATABASES | tr ";" "\n")


##########################################################################################################################################
CHECK=1
while [[ CHECK -ne 0 ]]; do
    echo -e "\n ##################### \n \n => AGUARDANDO SERVIÇO MONGO... \n \n ############################"
    sleep 5
    mongo admin --eval "help" >/dev/null 2>&1
    CHECK=$?
done

##########################################################################################################################################
echo -e "\n #####################\n\n => CRIANDO USUÁRIO ADMIN \n \n############################"
mongo admin --eval "db.createUser({user: '$MONGODB_ADMIN_USER', pwd: '$MONGODB_ADMIN_PASS', roles:[{role:'root',db:'admin'}]});"
sleep 3

##########################################################################################################################################
echo -e "\n ##################### \n \n  => CRIANDO OS BANCOS COM O USUÁRIO $MONGODB_USER \n \n ############################"

for i in $DATABASES
do
echo -e "#####################################################################"
echo -e "Criando banco $i!"
echo -e "#####################################################################"
mongo admin -u $MONGODB_ADMIN_USER -p $MONGODB_ADMIN_PASS << EOF
use $i
db.createCollection("boot")
db.createUser({user: '$MONGODB_USER', pwd: '$MONGO_PASS', roles:[{role:'dbOwner', db:'$i'}]})
show dbs
EOF
echo -e "############  Fim $i ############"
sleep 3
done




sleep 3

touch /data/db/.configMongo

echo -e "\n ##################### \n \n => MONGO CONFIGURADO COM SUCESSO! \n \n ############################"