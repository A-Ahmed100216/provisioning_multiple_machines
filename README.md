# Multi Machine Vagrant

## Introduction

The sample application has the ability to connect to a database. We need to provision our development environment with a vm for the database and one for the database.

Vagrant is capable of running two or more virtual machines at once with different configurations.

## Pre-Requisites
1. GitHub
2. Vagrantfile
3. Virtual Box

## Tasks
* Research how to create a multi machine vagrant environment
* Add a second virtual machine called "db" to your Vagrant file
* Configure the db machine with a different IP from the app
* Provision the db machine with a MongoDB database
* You can test your database is working correctly by running the test suite in the test folder. There are two sets of tests. One for the app VM and one for the db VM. Make them all pass.


## Acceptance Criteria

* Uses vagrant file
* Create 2 VM APP and Mongod
* Localhost set to development.local
* App works on Port 3000 (development.local:3000)
* Work with only command "vagrant up" &/or minimum commands
* All tests passing
* works on /posts
* works on /fibonacci/30
* Documentation exists as README.md file
* Documentation includes: Intro (purpose of repo), Pre Requisites  and Instructions
* Instructions have a clear step by step
* Repo exists on GitHub

# Instructions
1. Add a second machine configuration to the Vagrantfile.
```
config.vm.define "db" do |db|
  db.vm.box = "ubuntu/bionic64"
  db.vm.network "private_network", ip: "192.168.10.2"
  db.vm.synced_folder "app", "/home/ubuntu/app"
  db.vm.provision "shell", path: "environment/db/provision.sh", privileged: false
end
```
2. Create a provision file for the db
```
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
```
3. Add the following line to the app.js file
`process.env.DB_HOST='192.168.10.2'`

4. Run `vagrant up app` and `vagrant up db`

5. SSH into the virtual machine for the app and run the following commands.
```
cd /home/ubuntu/app/
npm install
npm start
```
6. Run tests
```
cd test
rake spec
```
7. Check the app deployment:
* 192.168.10.100:3000
* 192.168.10.100:3000/fibonacci/3
* 192.168.10.100:3000/posts
