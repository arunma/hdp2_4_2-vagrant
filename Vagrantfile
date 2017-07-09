# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "bento/centos-7.3"


 $script = <<SCRIPT
  echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null
  sudo yum -y install ntp ntpdate ntp-doc
  sudo chkconfig ntpd on
  sudo ntpdate pool.ntp.org
  sudo systemctl start ntpd
  sudo setenforce 0
  sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
  sudo sed -i 's/SELINUX=permissive/SELINUX=disabled/g' /etc/selinux/config
  sudo sh -c 'echo "* soft nofile 10000" >> /etc/security/limits.conf'
  sudo sh -c 'echo "* hard nofile 10000" >> /etc/security/limits.conf'
  sudo cp /vagrant_data/hosts /etc/hosts
SCRIPT

$ambari_script = <<SCRIPT
  cd /vagrant_data
  sudo chmod 755 ambari.sh
  sudo sh ./ambari.sh
SCRIPT

$keycopy_script = <<SCRIPT
  sudo mkdir -p /root/.ssh
  #chmod 600 /root/.ssh
  sudo cat /vagrant_data/id_rsa.pub >> /root/.ssh/authorized_keys
  sudo cat /root/.ssh/authorized_keys
  echo "DONE!"
SCRIPT

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "data", "/vagrant_data", type: "virtualbox"
  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL

  config.vm.provision "shell", inline: $script
 
  # Ambari1
  config.vm.define :ambari do |a1|
    a1.vm.hostname = "ambari.vgcluster"
    a1.vm.network :private_network, ip: "192.168.1.11", bridge: "Realtek PCIe GBE Family Controller"
    a1.vm.provider :virtualbox do |vb|
      vb.memory = "4096"
      vb.cpus = 2
    end

    a1.vm.provision "shell", inline: $ambari_script
    a1.vm.network "forwarded_port", guest: 8080, host: 8080
    a1.vm.network "forwarded_port", guest: 80, host: 8081
  end

  # Master1
  config.vm.define :master do |m1|
    m1.vm.hostname = "master.vgcluster"
    m1.vm.network :private_network, ip: "192.168.1.12", bridge: "Realtek PCIe GBE Family Controller"
    m1.vm.provider :virtualbox do |vb|
      vb.memory = "4096"
      vb.cpus = 2
    end
    m1.vm.provision "shell", inline: $keycopy_script
  end

  # Slave1
  config.vm.define :slave1 do |s1|
    s1.vm.hostname = "slave1.vgcluster"
    s1.vm.network :private_network, ip: "192.168.1.21", bridge: "Realtek PCIe GBE Family Controller"
    s1.vm.provider :virtualbox do |vb|
      vb.memory = "3072"
      vb.cpus = 2
    end
    s1.vm.provision "shell", inline: $keycopy_script
  end

  # Slave2
  config.vm.define :slave2 do |s2|
    s2.vm.hostname = "slave2.vgcluster"
    s2.vm.network :private_network, ip: "192.168.1.22", bridge: "Realtek PCIe GBE Family Controller"
    s2.vm.provider :virtualbox do |vb|
      vb.memory = "3072"
      vb.cpus = 2
    end
    s2.vm.provision "shell", inline: $keycopy_script
  end
end
