# prj-spark-getting-started
Learning spark by writing an application

A simple program to count number of lines in a given file

In the root folder of this project there is a file named bootstrap.sh (a shell script).
All you have to do is to execute the same (if this is the first time you are using this application).

pre requisites:
   1. You have required access to connect to AWS console
   2. This application assumes that you have configured the required credentials to use AWS console and be able to create resources on the same

   Do you already have an account to use AWS console? If not, create one here:
      https://aws.amazon.com/free

   Now that you have done creating an account, proceed to capture required information to be able to use AWS CLI to work with AWS console:
      1. Follow this post
         https://www.cloudberrylab.com/blog/how-to-find-your-aws-access-key-id-and-secret-access-key-and-register-with-cloudberry-s3-explorer/

Now, You are all set to execute the bootstrap.sh to create your EMR and generate the output.
What does the bootstrap.sh do?
   1. Creates a S3 bucket
   2. Copies over:
      a. Jar file (the application)
      b. Input file (the file, whose number of lines will be counted by the application)
   3. Instantiates an AWS EMR
      a. There is all the required AWS CLI required to create a particular type of (low power) EMR
      b. Execute the application
      c. Capture the output of the same on the S3 bucket (created earlier)
      d. Capture all the EMR log files on S3 for future reference
      e. Terminate EMR and related resources used for the exercise

NOTE:
   Ensure from AWS console EC2 Dashboard and Billing screen that all the resources that were instantiated for this exercise were terminated successfully (This application is designed to terminate it all, but it helps to just ensure that there were no hurdles and that the teardown was successful)
   Also, please do delete the bucket.
   Concern is that you should not get billed for resources that you will not want to use.
   Also, please remember that the billing screen reflects real stats only after few hours (this does not reflect immediately).
