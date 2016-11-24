package com.usnschool.domain;

public class Criteria {
	private int page;
	private int perPageNum;
	private String genre;
	private String searchword;
	private String field;
	private int cbno;
	public Criteria() {

		this.page = 1;
		this.perPageNum = 10;
	}
	public void setPage(int page){
		if(page<=0){
			this.page=1;
			return;
		}
		this.page=page;
	}
	public void setPerPageNum(int perPageNum){
		if(perPageNum<=0 || perPageNum>100){
			this.perPageNum = 10;
			return;
		}
		this.perPageNum=perPageNum;
	}
	public int getPage(){
		return page;
	}
	public int getPageStart(){
		return (this.page -1)*perPageNum;
	}
	
	public int getPerPageNum() {
		return this.perPageNum;
	}
	@Override
	public String toString(){
		return "Criteria [page=" + page + ", "+"perPageNum=" + perPageNum + "]";		
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getSearchword() {
		return searchword;
	}
	public void setSearchword(String searchword) {
		this.searchword = searchword;
	}
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public int getCbno() {
		return cbno;
	}
	public void setCbno(int cbno) {
		this.cbno = cbno;
	}
	
}
