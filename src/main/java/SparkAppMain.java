import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaPairRDD;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import scala.Tuple2;

import java.io.IOException;
import java.util.Arrays;

public class SparkAppMain {
    public static void main(String[] args) throws IOException {
        String inputFile = args[0];
        String outputFile = args[1];

        SparkConf sparkConf = new SparkConf().setAppName("Example Spark App");
        JavaSparkContext sparkContext = new JavaSparkContext(sparkConf);

        JavaRDD<String> stringJavaRDD = sparkContext.textFile(inputFile);

        JavaRDD<String> wordsRDD = stringJavaRDD.flatMap(line -> Arrays.asList(line.split(" ")).iterator());
        JavaPairRDD<String, Integer> counts = wordsRDD.mapToPair(word -> new Tuple2<>(word, 1));
        JavaPairRDD<String, Integer> wordCounts = counts.reduceByKey( (x, y) -> x+y);

        wordCounts.coalesce(1).saveAsTextFile(outputFile);
    }
}
