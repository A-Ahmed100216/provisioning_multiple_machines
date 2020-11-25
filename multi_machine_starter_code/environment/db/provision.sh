#!/bin/bash
sudo apt-get update

wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20
# Open the configuration file
sudo nano /etc/mongod.conf
# Ammend the ip address to 0.0.0.0 and save changes
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
# restart mongod
sudo service mongod restart
# enable mongod
sudo systemctl enable mongod
mongo
