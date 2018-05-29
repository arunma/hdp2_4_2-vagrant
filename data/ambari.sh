echo "EXECUTING AMBARI SCRIPT !!!"
sudo ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa
sudo cat /root/.ssh/id_rsa.pub
sudo cp /root/.ssh/* /vagrant_data
sudo cat /vagrant_data/id_rsa.pub >> /root/.ssh/authorized_keys
sudo cd /vagrant_data
#sudo cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
sudo wget -nv http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.6.1.5/ambari.repo
cp -f ambari.repo /etc/yum.repos.d/ambari.repo
sudo yum -y install ambari-server
sudo ambari-server setup -s
sudo ambari-server start
sudo wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
sudo rpm -ivh mysql-community-release-el7-5.noarch.rpm
sudo yum update
sudo yum install -y mysql-connector-java
sudo ambari-server setup --jdbc-db=mysql --jdbc-driver=/usr/share/java/mysql-connector-java.jar 
sudo systemctl start mysqld.service
echo "DONE. PLEASE BRING UP THE OTHER VMs NOW."
