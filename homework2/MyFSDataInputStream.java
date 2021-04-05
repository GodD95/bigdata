import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.*;

public class MyFSDataInputStream extends FSDataInputStream{
	
	public MyFSDataInputStream(InputStream input) {
		super(input);
	}
	
	public static String readline(Configuration con,String filepath) {
		try (FileSystem fs = FileSystem.get(con)){
			Path fpath = new Path(filepath);
			FSDataInputStream input = fs.open(fpath);
			BufferedReader reader = new BufferedReader(new InputStreamReader(input));
			String line = null;
			while ((line = reader.readLine()) != null) {
				System.out.print(line);
			}
			reader.close();
			input.close();
			return null;
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
	}
    public static void main(String[] args){
    	Configuration con = new Configuration();
    	con.set("fs.default.name","hdfs://localhost:9000");
    	String filepath = "merge.txt";
    	try {
    		MyFSDataInputStream.readline(con, filepath);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    }
}
