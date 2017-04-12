This is a java program to count number of lines in a given file
How to build the required jar file:
   cd ~/IdeaProjects/prj-spark-getting-started$> mvn install
The above command will generate a jar file named: spark-getting-startedartfid-1.0-SNAPSHOT.jar
In the folder: ~/IdeaProjects/prj-spark-getting-started/target

This Java program exepects a command line argument, which is actually the path and the file name, contents of which are to be processed to count number of lines.
Here is how the jar file can be executed as a spark job locally:
   /usr/local/bin/spark-submit --master local[*] --class SparkAppMain target/spark-getting-startedartfid-1.0-SNAPSHOT.jar /tmp/nationalparks.csv

NOTE: Remember to create a file in the /tmp folder with above name nationalparks.csv
Containing atleast few lines of text
