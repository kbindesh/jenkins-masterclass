#!/bin/bash
amazon-linux-extras install docker
service docker start
chkconfig docker on
yum install -y git