package com.usnschool.Util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.Calendar;


public class FileUploadUtil {
	public static void makeFile(String upLoadPath, String filename, InputStream is){
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		try {
			
			bis = new BufferedInputStream(is);
			
			bos = new BufferedOutputStream(new FileOutputStream(upLoadPath+File.separator+filename));
			
			byte[] buffer = new byte[1024];
			int size = 0;
			while((size=bis.read(buffer)) > 0){
				bos.write(buffer);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(bos != null){
				try {
					bos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
	}
	
	 public static String calcPath(String upLoadPath){
		    
		    Calendar cal = Calendar.getInstance();
		    
		    String yearPath = "/"+cal.get(Calendar.YEAR);
		    
		    String monthPath = yearPath + 
		        "/" + 
		        new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);

		    String datePath = monthPath + 
		        "/" + 
		        new DecimalFormat("00").format(cal.get(Calendar.DATE));
		    
		    makeDir(upLoadPath, yearPath,monthPath,datePath);
		    
		    return upLoadPath+datePath;
	}
	
	
	public static void makeDir(String upLoadPath, String... paths){
		for(String path : paths){
			File dirPath = new File(upLoadPath + path);
			if(! dirPath.exists()){
				dirPath.mkdir();
			}
		}
	}
}
