#!/bin/bash

# ========================-----=========================
# Purpose of this script is to be able to maven build
#	After the snapshot jar is made
#	Copy over the jar to s3 bucket
#
# Note, there are a few environment variables that this
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
echo --end of verification
echo ------------------------------------------------------

echo ========================-----=========================
echo	About to execute Maven build
echo ========================-----=========================
	mvn install

echo ========================-----=========================
echo	Copy generated snapshot Jar file from target folder to s3 bucket
echo ========================-----=========================
	aws s3 cp target/$JARNAME s3://$S3_BKT_NAME/jars/$JARNAME

echo ========================-----=========================
echo	Finished script execution
echo ========================-----=========================

