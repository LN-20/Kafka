#!/bin/sh


read -p "Enter topic name:"  topic


echo "Checking consumer group for the topic:$topic"
echo "*******************************************************"

for i in `/Home-path/confluent/bin/kafka-consumer-groups --list --bootstrap-server hostname:9093 --command-config ssl.properties`; do echo $i; (/home-path/confluent/bin/kafka-consumer-groups --describe --bootstrap-server hostname:9093 --command-config tsl_ssl.properties --group $i 2>&1 |grep $topic); done
