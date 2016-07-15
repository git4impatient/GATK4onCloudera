# GATK4onCloudera 
These scripts allow you to stand up a Cloudera Hadoop Cluster in GoogleCloud or Amazon
If you have a Linux box you can install Cloudera Director locally and use it to create your cloud cluster
see: http://www.cloudera.com/documentation/director/latest/topics/director_install_client_task.html

High level outline:
- create a cluster with Cloudera Director
- log into one of the nodes
- upgrade to Java8
- install GATK4 on the node
- get a BAM file
- run counts on the bam file with GATK 


If you don't have a local linux box create a single node in the cloud of your choice and then run your clusters from there
see: http://www.cloudera.com/documentation/director/latest/topics/director_get_started.html

NOTE: the cluster.conf file MUST end in .conf

Once you have director installed you can bootstrap a cluster with the conf file, for example:
cloudera-director bootstrap /home/marty/cluster.conf

Google Cloud and AWS conf files are provided here.

After your cluster is up and running see the working session script to get GATK installed and running.  Note that much of the effort is to upgrade the cluster to Java8

Thanks to Adam, Louis, and Tom - this wouldn't be running without their help
