# ========================-----=========================
#
# Execute this script to initiate launching of an AWS EMR
#	Do familiarize yourself with the different config arrangements made
#
# ========================-----=========================


# ========================-----=========================
# Since environment variables are used in the bootstrap.sh in the parent folder
#   Of this project, I have chosen to create the .env file in the parent folder
#   Which reason I am referring to the file using ../../../ linux file notation
	source ../../../.env

echo ------------------------------------------------------
echo --Verify the value in the env variables
	echo $S3_BKT_NAME
	echo $AWS_KEY_PAIR
echo --end of verification
echo ------------------------------------------------------

# ========================-----=========================
# Following lines are to find replace text in the step.json file so as to
#   use use values from the environment variables defined in ../../../.env file
	cat step_template.json | sed "s/S3_BKT_NAME/$S3_BKT_NAME/g" > temp.json
	cat temp.json > step.json
	cat step.json | sed "s/JARNAME/$JARNAME/g" > temp.json
	cat temp.json > step.json
	cat step.json | sed "s/INPUTFILE/$INPUTFILE/g" > temp.json
	cat temp.json > step.json
	cat step.json | sed "s/OUTPUTFILE/$OUTPUTFILE/g" > temp.json
	cat temp.json > step.json
	rm temp.json
# ========================-----=========================

aws emr create-cluster \
	--name 'Test afresh' \
	--applications Name=Hadoop Name=Spark \
	--ec2-attributes KeyName=$AWS_KEY_PAIR,InstanceProfile=EMR_EC2_DefaultRole,AvailabilityZone=$AWS_AVAIL_ZONE \
	--service-role EMR_DefaultRole \
	--enable-debugging \
	--release-label emr-5.4.0 \
	--log-uri 's3n://'"$S3_BKT_NAME"'/aws-emr-logs/' \
	--steps file://step.json \
	--instance-groups InstanceCount=1,InstanceGroupType=MASTER,InstanceType=m3.xlarge,Name=MASTER  \
	--auto-terminate \
	--region $AWS_REGION

