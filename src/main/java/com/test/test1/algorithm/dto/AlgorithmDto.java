package com.test.test1.algorithm.dto;

import java.util.Date;

public class AlgorithmDto {

	private int user_id, video_id, hit, amount, number;
	private Date last_update_date, paid_date, visit_date;
	private String category_name, genre_name;	
	
	public int getAmount() {
		return amount;
	}
	
	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	public Date getPaid_date() {
		return paid_date;
	}
	
	public void setPaid_date(Date paid_date) {
		this.paid_date = paid_date;
	}
	
	public Date getVisit_date() {
		return visit_date;
	}
	
	public void setVisit_date(Date visit_date) {
		this.visit_date = visit_date;
	}
	
	public int getUser_id() {
		return user_id;
	}
	
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	
	public int getVideo_id() {
		return video_id;
	}
	
	public void setVideo_id(int video_id) {
		this.video_id = video_id;
	}
	
	public int getHit() {
		return hit;
	}
	
	public void setHit(int hit) {
		this.hit = hit;
	}
	
	public Date getLast_update_date() {
		return last_update_date;
	}
	
	public void setLast_update_date(Date last_update_date) {
		this.last_update_date = last_update_date;
	}
	
	public String getCategory_name() {
		return category_name;
	}
	
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	
	public String getGenre_name() {
		return genre_name;
	}
	
	public void setGenre_name(String genre_name) {
		this.genre_name = genre_name;
	}
	
	public int getNumber() {
		return number;
	}
	
	public void setNumber(int number) {
		this.number = number;
	}
	
	@Override
	public String toString() {
		return "{user_id : " + user_id + ", video_id : " + video_id + ", hit : " + hit + ", category_name : "
				+ category_name + ", genre_name : " + genre_name + ", last_update_date : " + last_update_date + ", paid_date : " + paid_date +
				", amount : " + amount + ", visit_date : " + visit_date + ", number : " + number + ", }";
	}
	
}
