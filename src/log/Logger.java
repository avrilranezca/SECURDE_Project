package log;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class Logger {
	
	private static String FILENAME = "C:\\log.txt";

	public static void write(String id, String ip, String action) {
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		String timestamp = dateFormat.format(cal.getTime());

		File file = new File(FILENAME);
		FileWriter fw = null;
		BufferedWriter bw = null;
		PrintWriter out = null;

		try {
			if (!file.exists()) {
				file.createNewFile();
			}

			fw = new FileWriter(file.getAbsoluteFile(), true);
			bw = new BufferedWriter(fw);
			out = new PrintWriter(bw);

			out.println(id + " " + timestamp + " " + ip + " " + action);

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
		    if(out != null)
			    out.close();
		    try {
		        if(bw != null)
		            bw.close();
		    } catch (IOException e) {
		    }
		    try {
		        if(fw != null)
		            fw.close();
		    } catch (IOException e) {
		    }
		}
		System.out.println("Logged to " + file.getAbsolutePath());
	}
	
	public static void main(String[] args) {
		Logger.write("1", "192.168.0.10", "incorrect password");
	}
}
