#!/bin/bash

source=hostname
File=abc.txt
user=username

for i in `cat serverlist.txt` ; do scp -p $File $user@$i:/tmp/ ; done
