echo "EXECUTING AMBARI SCRIPT !!!"
sudo ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa
sudo cat /root/.ssh/id_rsa.pub
sudo cp /root/.ssh/* /vagrant
sudo cat /vagrant/id_rsa.pub >> /root/.ssh/authorized_keys
sudo cd /vagrant
sudo wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.4.0.1/ambari.repo
cp -f ambari.repo /etc/yum.repos.d/ambari.repo
sudo yum -y install ambari-server
sudo ambari-server setup -s
sudo ambari-server start
echo "DONE. PLEASE BRING UP THE OTHER VMs NOW."