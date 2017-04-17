import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.api.java.function.FlatMapFunction;
import scala.Tuple1;
import scala.Tuple2;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

/**
 * Created by harsha on 03/04/2017.
 */
public class SparkAppMain {
    public static void main(String[] args) throws IOException {
        String inputFileName = args[0];
        String inputLine = null;
        String outputFileName = args[1];

      //  BufferedWriter out = new BufferedWriter(new FileWriter(outputFileName));

        SparkConf sparkConf = new SparkConf()
                .setAppName("Example Spark App")
                ;
        JavaSparkContext sparkContext = new JavaSparkContext(sparkConf);
        JavaRDD<String> stringJavaRDD = sparkContext.textFile(inputFileName);

        JavaRDD<Long> outputRDD = sparkContext.parallelize(Arrays.asList(stringJavaRDD.count()));
        outputRDD.coalesce(1).saveAsTextFile(outputFileName);

        System.out.println("HelloWorld");
    }
}
