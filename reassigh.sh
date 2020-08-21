#!/bin/bash

#To describe under replicated topics
desc=$(/Homep-path/confluent/bin/kafka-topics --describe \
    --under-replicated-partitions \
    --zookeeper hostname:2181 | awk '{print $2}' ) 
echo $desc > desc.txt

#using tr to remove duplicate and unwanted spaces
tr -s [:space:] \\n < desc.txt | sort | uniq > topic.txt

#converting to json from txt file format
for file in /Home-path/reassign-test/topic.txt; do
    {
        printf '{"version":1,\n'
        printf '"topics": [\n'
                 
        while read -r line; do
            printf '{"topic":"%s"},\n' "$line"
    
        done
        printf ']\n'
        printf '}\n'
    } < "$file" > topic.json
done

#To remove last comman in json file
sed -zr 's/,([^,]*$)/\1/' topic.json > new.json


#Brokers id 
brokers=0,1,2 (remove the affected broker)

#Generate Current and proposed partiton configurations
generate=$(/Home-path/confluent/bin/kafka-reassign-partitions \
        --generate --zookeeper hostname:2181 \
        --topics-to-move-json-file new.json --broker-list $brokers )

echo $generate > part.txt

#To copy Proposed patition configuration only from above list
cat part.txt | sed 's/.*Proposed partition reassignment configuration//' > proposed.json

#execute the proposed reassignment json
execute=$(/Home-path/confluent/bin/kafka-reassign-partitions \
          --zookeeper hostname:2181 \
          --reassignment-json-file proposed.json --execute)
