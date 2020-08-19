#!/bin/sh

read -p "Enter topic name:" topic
read -p "Enter partiton count:" part
read -p "Enter replication factor:" rep
read -p "Enter the retention period:" retention
echo "creating a topic with name: $topic "
echo "++++++++++++++++++++++++++++++++++++++"
create=$(/home-to-path/confluent/bin/kafka-topics --create --zookeeper hostname:2181 --partitions $part --replication-factor $rep --config retention.ms=$retention --topic $topic )
echo "$topic has been created"
echo "To describe created topic"
desc=$(/home-to-path/confluent/bin/kafka-topics --describe --zookeeper hostname:2181 --topic $topic)
echo $desc
