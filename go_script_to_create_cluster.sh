# (C) copyright 2016 Martin Lurie - sample code not supported
# create single node in gc
# 
# 
#
yum install -y wget
yum install -y git
yum remove *openjdk*
cd /tmp
wget http://archive.cloudera.com/director/redhat/7/x86_64/director/2.1.0/RPMS/x86_64/oracle-j2sdk1.8-1.8.0+update60-1.x86_64.rpm
rpm -ivh /tmp/oracle-j2sdk1.8-1.8.0+update60-1.x86_64.rpm

 
# install cloudera director
cd /etc/yum.repos.d/
sudo wget "http://archive.cloudera.com/director/redhat/6/x86_64/director/cloudera-director.repo"
sudo yum -y install cloudera-director-client
# upload cluster.conf and private ssh key
# run director bootstrap
sudo  cloudera-director bootstrap /home/REPLACEWITHPATHTOYOURCONFFILE/cluster.conf
