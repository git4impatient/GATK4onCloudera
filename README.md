# GATK4onCloudera java8 cluster
These scripts allow you to stand up a GATK environment on a Cloudera Hadoop Cluster in GoogleCloud or Amazon

For instructions on how to do this please see the wiki:
https://github.com/git4impatient/GATK4onCloudera/wiki


High level outline:
- create a cluster with Cloudera Director
- log into one of the nodes
- install GATK4 on the node
- get a BAM file
- run counts on the bam file with GATK 


NOTE: the cluster.conf file MUST end in .conf


Thanks to Adam, Louis, and Tom - this wouldn't be running without their help
