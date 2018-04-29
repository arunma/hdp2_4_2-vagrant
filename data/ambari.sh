echo "EXECUTING AMBARI SCRIPT !!!"
sudo ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa
sudo cat /root/.ssh/id_rsa.pub
sudo cp /root/.ssh/* /vagrant_data
sudo cat /vagrant_data/id_rsa.pub >> /root/.ssh/authorized_keys
sudo cd /vagrant_data
#sudo wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.4.0.1/ambari.repo
sudo wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.6.0.0/ambari.repo
cp -f ambari.repo /etc/yum.repos.d/ambari.repo
sudo yum -y install ambari-server
sudo ambari-server setup -s
sudo ambari-server start
echo "DONE. PLEASE BRING UP THE OTHER VMs NOW."