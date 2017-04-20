#!/bin/bash

# ========================-----=========================
#
# This script helps do the prep work required to work with AWS EMR
#
# Pre-requisite:
#	1) Remember to execute $> aws configure on your laptop
#	Before you try this code, because for you to work with S3 buckets
#	Configuring certain credentials before hand is a must
#
#	2) Also, you will have to create a key pair on AWS console
#
# Note: There are a few environment variables that this
# bash file depends on, so you have to use the .env
# file available in the same folder to set the env variables
# else the script would fail.
#
# ========================-----=========================

source .env
echo ------------------------------------------------------
echo --Verify the value in the env variables
	echo $JARNAME
	echo $S3_BKT_NAME
	echo $AWS_REGION
	echo $AWS_EMR_LOG_FOLDER
echo --end of verification
echo ------------------------------------------------------

echo ========================-----=========================
echo	Create the required S3 bucket
echo ========================-----=========================
	aws s3api create-bucket --bucket $S3_BKT_NAME --region ap-southeast-1 --create-bucket-configuration LocationConstraint=$AWS_REGION

echo ========================-----=========================
echo	Copy files over to s3 bucket, which are later referenced whiel working on EMR
echo ========================-----=========================
	# I wonder I might not need to copy the Jar file from s3 bucket to EMR Master node anymore, because I have
	# got working code which refers to the S3 bucket for the JAR file
		# aws s3 cp src/main/scripts/cp_jar_fromS3_toMasterNode.sh s3://$S3_BKT_NAME/cp_jar_fromS3_toMasterNode.sh

	# This is the input file which will have some content for the spark code to be count the number of lines or words etc
		aws s3 cp src/main/scripts/nationalparks.csv s3://$S3_BKT_NAME/nationalparks.csv

echo ========================-----=========================
echo	Delete aws s3 sub-folder which is chosen to host EMR log files
echo ========================-----=========================
	# Delete this folder just in case it is already present so that we don't have stale files to read from
		aws s3 rm s3://$S3_BKT_NAME/$AWS_EMR_LOG_FOLDER --recursive

echo ========================-----=========================
echo	About to execute Maven build
echo ========================-----=========================
	# I am commenting this line, because I have already uploaded the required Jar file to github
	# If there is a change made to the spark application, only then this step is required
	#mvn install

echo ========================-----=========================
echo	Copy generated snapshot Jar file from target folder to s3 bucket
echo ========================-----=========================
	aws s3 cp target/$JARNAME s3://$S3_BKT_NAME/jars/$JARNAME

echo ========================-----=========================
echo	Initiate emr cluster creation and task execution
echo ========================-----=========================
	aws emr create-default-roles
	cd src/main/scripts
	./aws_spark_execute.sh

echo ========================-----=========================
echo	Finished script execution
echo ========================-----=========================

