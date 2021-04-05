import java.io.IOException;
import java.net.URL;

import org.apache.hadoop.fs.FsUrlStreamHandlerFactory;
import org.apache.hadoop.io.IOUtils;
import org.omg.CORBA.portable.InputStream;

public class ShowContent {
	static {
		URL.setURLStreamHandlerFactory(new FsUrlStreamHandlerFactory());
	}
	public static void show(String FilePath) {
		try (java.io.InputStream input = new URL("hdfs", "localhost", 9000, FilePath).openStream()){
			IOUtils.copyBytes(input, System.out, 4096, false);
			IOUtils.closeStream(input);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public static void main(String[] args){
    	String FilePath = "/user/hadoop/merge.txt";
    	try {
    		ShowContent.show(FilePath);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    }
}
