package com.usnschool.domain;

public class BoardFileVO {
	private int bfno;
	private int bno;
	private String path;
	private long capacity;
	private String filename;
	private int point;
	
	public int getBfno() {
		return bfno;
	}
	public void setBfno(int bfno) {
		this.bfno = bfno;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public long getCapacity() {
		return capacity;
	}
	public void setCapacity(long capacity) {
		this.capacity = capacity;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	
	
}
