#SUCCESSFUL WORKING SESSION - GATK4 ran in google cloud

# (c) copyright 2016 Martin Lurie 7/7/2016  sample code not supported

#==============
#notes on port forwarding to get to CM web UI
#[marty@cloudera-director-46afe32b-54a1-496c-89fe-71378db5450f gatk]$ echo use this:  ssh -i martygooglecloud.key -g -L 9090:10.142.0.3:7180 104.196.10.156
#use this: ssh -i martygooglecloud.key -g -L 9090:10.142.0.3:7180 104.196.10.156
#[marty@cloudera-director-46afe32b-54a1-496c-89fe-71378db5450f gatk]$ echo 10.x.x.x is target host we want to reach - in this case the cm host
#10.x.x.x is target host we want to reach - in this case the cm host
#[marty@cloudera-director-46afe32b-54a1-496c-89fe-71378db5450f gatk]$ echo 104.x.x.x is the gatewayhost which could be the same as the cm host
#104.x.x.x is the gatewayhost which could be the same as the cm host
#[marty@cloudera-director-46afe32b-54a1-496c-89fe-71378db5450f gatk]$ 
#===========

#start google cloud cluster with Cloudera Director 

# log into a data node on the cluster

sudo yum install -y curl unzip gcc python-setuptools git automake gcc-c++
wget https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.zip     && unzip google-cloud-sdk.zip     && rm google-cloud-sdk.zip
sudo google-cloud-sdk/install.sh --usage-reporting=true --path-update=true --bash-completion=true --rc-path=/.bashrc --disable-installation-options
mkdir /home/$USER/gatk
cd /home/$USER/gatk
wget https://github.com/broadinstitute/cromwell/releases/download/0.19.3/cromwell-0.19.3.jar
pwd
wget https://github.com/broadinstitute/wdltool/releases/download/0.1/wdltool0.1.jar
git clone git://github.com/broadinstitute/gatk
cd gatk
 echo rebuild gatk
 ./gradlew clean
 ./gradlew installAll
# 
# set up a directory for this user

export NN=$(hdfs getconf -namenodes)
sudo su - hdfs -c "hadoop fs -mkdir /user/$USER"
hadoop fs -ls hdfs://$NN:8020/user/$USER
# 
#
# Verification test - get a file and run a CountReadsSpark
echo get genomic file
hadoop fs -ls
wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase3/data/NA12878/alignment/NA12878.chrom11.ILLUMINA.bwa.CEU.low_coverage.20121211.bam

hadoop fs -put NA12878.chrom11.ILLUMINA.bwa.CEU.low_coverage.20121211.bam NA12878.chrom11.ILLUMINA.bwa.CEU.low_coverage.20121211.bam

# export NN="cloudera-director-16c6f850-e688-40a9-a165-258ac6e68f7a.c.mydirector-1280.internal"

# make sure job doesn't fail due to existing directory
hadoop fs -rm -r hdfs://$NN:8020/user/$USER/counted.out

 ./gatk-launch  CountReadsSpark --input hdfs://$NN:8020/user/$USER/NA12878.chrom11.ILLUMINA.bwa.CEU.low_coverage.20121211.bam --output hdfs://$NN:8020/user/$USER/counted.out --sparkRunner SPARK --sparkMaster yarn-client -- --num-executors 4 --executor-cores 2 --executor-memory 1g --driver-memory=1g --conf spark.yarn.executor.memoryOverhead=450    --conf spark.yarn.am.memoryOverhead=450

 
 hadoop fs -ls counted.out
 hadoop fs -cat counted.out
