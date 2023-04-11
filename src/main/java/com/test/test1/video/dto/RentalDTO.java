package com.test.test1.video.dto;

import java.util.Date;

public class RentalDTO {
	
	private String id;
	private int video_id;
	private Date rental_date;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getVideo_id() {
		return video_id;
	}

	public void setVideo_id(int video_id) {
		this.video_id = video_id;
	}
	
	public Date getRental_date() {
		return rental_date;
	}

	public void setRental_date(Date rental_date) {
		this.rental_date = rental_date;
	}
	
	@Override
	public String toString() {
		return "rentalDTO[id = " + id + ", video_id = " + video_id + ", rental_date = " + rental_date + "]";
	}
}
