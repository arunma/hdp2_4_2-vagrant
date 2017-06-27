# Setup Hortonworks Data Platform using Vagrant, VirtualBox and Ambari

## Objective

Deploy a 4-node HDP 2.5 cluster with Apache Ambari 2.4.1, Vagrant and VirtualBox on OS X host. 
This is helpful for development and proof of concepts.

## Scope
This approach has been tested on OS X host, but it should work on all supported Vagrant and VirtualBox environments.

## Pre-requisites
- Minimum 5 GB of RAM for the HDP 2.5 cluster

## Steps
1. Download and install Vagrant for your host OS: https://www.vagrantup.com/downloads.html
2. Download and install VirtualBox for your host OS: https://www.virtualbox.org/wiki/Downloads
3. Download and install git client for your host
4. Open a command shell and change to the folder where you plan to clone the github repository
5. Clone the Github repository:  ```git clone https://github.com/arunma/hdp2_5-vagrant.git```

### Prerequisites 

Edit the vagrantfile to point to the the network adapter that you would like to use :

```
bridge: "en0: Wi-Fi (AirPort)"

```

If you aren't sure about the exact name, use the following command : 

### Windows 
From your Virtualbox installation folder (eg : C:\Program Files\Oracle\VirtualBox) : 

```
VBoxManage.exe list bridgedifs

```

### OSX

```
vboxmanage list bridgedifs

```


# 1. Super-Easy Install

## Just one command 
Once you have configured the network adapter correctly in the Vagrantfile, all you need to execute is one single command 

`vagrant up ambari master slave1 slave2`

That's it !!  Proceed to install your Cluster using the url http://192.168.1.11:8080

##OR

# 2. Easy Install 

## Start Ambari VM

Vagrant (via Vagrantfile) is configured to use Centos 7.3 as the base box and includes the pre-requisites for installing HDP.

4 VMs will be created: 1 Ambari Server (ambari), 1 Hadoop master (master) and 2 slaves (slave1, slave2).

Let's start ambari VM and setup ambari first:

```vagrant up ambari```

If you see the following messages at the end of the logs, then the installation went fine. 

```
==> ambari: Ambari Server 'start' completed successfully.
==> ambari: DONE. PLEASE BRING UP THE OTHER VMs NOW.
```


### SSH Access and Starting the Other Three VMs

Check if id_rsa and id_rsa.pub keys of the ambari VM is available in your local /data folder.  This folder from your local machine is synced with the /vagrant folder in ambari and all other host machines.  Start the other three VMs:

```vagrant up master slave1 slave2```


### Deploy Cluster using Ambari Web UI

Open up a web browser and go to http://192.168.1.11:8080. Alternatively, make an entry into your /etc/hosts on your host machine.
Log in with username admin and password admin and follow on-screen instructions, selecting hosts created and services of interest.
