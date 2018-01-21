package kr.co.habitmaker.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.sun.org.apache.bcel.internal.generic.GETFIELD;

public class test {

	public static void main(String[] args) {
		/*
		Calendar cal = Calendar.getInstance();
		
		//System.out.println(cal.get(Calendar.YEAR) +"-"+cal.get(Calendar.MONTH)+"-"+cal.get(Calendar.DATE));
		cal.add(Calendar.DATE, 66);
		//System.out.println(cal.get(Calendar.YEAR) +"-"+cal.get(Calendar.MONTH)+1+"-"+cal.get(Calendar.DATE));
		Date date = cal.getTime();
		try {
			String temp = new SimpleDateFormat("yyyy-MM-dd").format(date);
			System.out.println(temp);
			date = new SimpleDateFormat("yyyy-MM-dd").parse(temp);
			System.out.println(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		
		
		System.out.println(getFilenameExtensions("main.jsp"));
		
	}
	
	public static String getFilenameExtensions(String fileName){
		String fe = "";
		int dot = fileName.lastIndexOf(".");
		fe = fileName.substring(dot);
		return fe;
	}
	
}
