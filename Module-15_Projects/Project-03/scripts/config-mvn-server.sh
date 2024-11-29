#!/bin/bash
yum install -y java-17-amazon-corretto.x86_64
yum install -y git
cd /opt
wget https://dlcdn.apache.org/maven/maven-3/3.9.8/binaries/apache-maven-3.9.8-bin.tar.gz
tar -xvzf apache-maven-3.9.8-bin.tar.gz