#!/bin/bash

cat topic.txt | while read line
do
/home-to-path/confluent/bin/kafka-topics --create --zookeeper hostname:2181 --partitions 3 --replication-factor 3 --config retention.ms=1000 --topic $line
done
