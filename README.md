AWS Backup to S3 – Automation Script
This project contains a shell script (aws_backup_s3.sh) to automate backups of a local directory, compress them into a .zip file, and upload them to an AWS S3 bucket. It is designed to work with cron for periodic automated backups.

How to Use
./aws_backup_s3.sh <source_directory> <destination_directory>
Example:
./aws_backup_s3.sh ~/Projects/myapp/ ~/Projects/Awsbackup
Setup Steps
Install AWS CLI and run aws configure.

Give execute permission:
chmod +x aws_backup_s3.sh

Automate with Cron
Add this line to your cron jobs:
30 18 * * 5 /root/Projects/aws_backup_s3.sh /root/Projects/myapp/ /root/Projects/Awsbackup

What It Does
Creates a zip: backup_<timestamp>.zip
Uploads it to s3://<your-bucket-name>/

