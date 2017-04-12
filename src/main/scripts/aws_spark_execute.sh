aws emr create-cluster \
    --name "Sample Spark Cluster with a single Job" \
    --ec2-attributes \
      KeyName=aws_online_first_key_pair \
    --enable-debugging \
    --log-uri s3://spark-getting-started-bkt \
    --instance-type m3.xlarge \
    --release-label emr-4.1.0 \
    --instance-count 1 \
    --use-default-roles \
    --applications Name=Spark \
    --steps file://step.json \
    --configurations file://./aws_spark_yarn_logging.json \
    --termination-protected

