#!/bin/bash

MONGODB_ADMIN_USER="admin"
MONGODB_ADMIN_PASS="4dmInP4ssw0rd"
MONGODB_USER=$MONGODB_USER
MONGODB_PASS=$MONGODB_PASS
DATABASES=$(echo $CREATE_DATABASES | tr ";" "\n")

mongod --auth &
PID_MONGO=$!

CHECK=1
while [[ CHECK -ne 0 ]]; do
    echo -e "\n ##################### \n \n => AGUARDANDO SERVIÇO MONGO... \n \n ############################"
    sleep 5
    mongo admin --eval "help" >/dev/null 2>&1
    CHECK=$?
done

echo -e "\n #####################\n\n => CRIANDO USUÁRIO ADMIN \n \n############################"
mongo admin --eval "db.createUser({user: '$MONGODB_ADMIN_USER', pwd: '$MONGODB_ADMIN_PASS', roles:[{role:'root',db:'admin'}]});"
sleep 3


echo -e "\n ##################### \n \n  => CRIANDO OS BANCOS \n \n ############################"

for i in $DATABASES
do
echo -e "#####################################################################"
echo -e "Criando banco $i | User: $MONGODB_USER Pass: $MONGODB_PASS "
echo -e "#####################################################################"
mongo admin -u $MONGODB_ADMIN_USER -p $MONGODB_ADMIN_PASS << EOF
use $i;
db.createUser({user: '$MONGODB_USER', pwd: '$MONGODB_PASS', roles:[{role:'dbOwner', db:'$i'}]});
db.boot.insertOne({created: "ok"});
EOF
sleep 3
done

sleep 2
touch /data/db/.configMongo
sleep2

echo -e "\n ##################### \n \n => MONGO CONFIGURADO COM SUCESSO! \n \n ############################"

echo -e "\n\n\n\n\n\n #### Liberando conexões ##### \n\n\n"
kill -9 $PID_MONGO

mongod --auth --bind_ip_all