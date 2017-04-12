import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

/**
 * Created by harsha on 03/04/2017.
 */
public class SparkAppMain {
    public static void main(String[] args) throws IOException {
        String inputFileName = args[0];
        String inputLine = null;
        String outputFileName = args[1];

        BufferedWriter out = new BufferedWriter(new FileWriter(outputFileName));

        SparkConf sparkConf = new SparkConf()
                .setAppName("Example Spark App")
                //.setMaster("local[*]")  // Delete this line when submitting to a cluster
                ;
        JavaSparkContext sparkContext = new JavaSparkContext(sparkConf);
        JavaRDD<String> stringJavaRDD = sparkContext.textFile(inputFileName);
        inputLine = "Number of lines in file = " + stringJavaRDD.count();
        out.write(inputLine);
        out.close();
    }
}
