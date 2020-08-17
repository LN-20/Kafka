#!/bin/bash
run=$(/Home-path-/confluent/bin/kafka-topics --describe \
    --under-replicated-partitions \
    --zookeeper hostname:2181 | wc -l )
echo "UR is $run"
if [ "$run" = "0" ];
then
	echo "we dont have under replicated partitions"       
else
	echo "we  have under replicated partitions"
        mail -s "$run URP in env, please login and check ISR" 123@gmail.com  < /dev/null
fi
