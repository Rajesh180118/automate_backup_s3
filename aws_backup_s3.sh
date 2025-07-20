#!/bin/bash

###################################################

# Check aws cli is installed or not !
AWS=/usr/local/bin/aws #This is added as we gonna use crontab for automating

if ! command -v  $AWS > /dev/null; 
then
	echo "Install aws cli"
	exit 1
fi

#Check aws is configured or not!
if [ ! -d ~/.aws ]; then
	echo "Configure aws"
	exit 1
fi

#Usage of script
if [ ${#} -ne 2 ]
then
	echo "Usage: ./aws_backup_s3.sh source dest "
	exit 1
else
	echo "${#}"
fi

#Create a backup directory if not present!
if [ ! -d ~/Projects/Awsbackup ]; then 
	echo " creating a new directory"
	mkdir Awsbackup
fi

dest=$2
source=$1
timestamp=$(date +%Y-%m-%d-%H-%M-%S)
ZIP=/usr/bin/zip  #This is added as we gonna use crontab for automating
backup() {
	echo "Starting backup"
        $ZIP -r ${dest}/backup_${timestamp}.zip ${source} > /dev/null
	if [ $? -eq 0 ]; then 
		echo " backup done successfully"
	fi

}

s3() {
	echo "find your s3 bucket"
	s3=$(aws s3 ls | awk '{print $3}')
        echo $s3
	echo "Uploading to S3"
	$AWS s3 cp ${dest}/backup_${timestamp}.zip  s3://$s3
}
backup
s3
