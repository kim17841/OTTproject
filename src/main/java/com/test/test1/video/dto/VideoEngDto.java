package com.test.test1.video.dto;

import java.util.Date;

public class VideoEngDto {
	
	private String title, video_url, image_url, summary, create_country, grade, actor, genre_id, create_year;
	private int video_id, recommand, category_id;
	private Date upload_date;
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getVideo_url() {
		return video_url;
	}
	
	public void setVideo_url(String video_url) {
		this.video_url = video_url;
	}
	
	public String getImage_url() {
		return image_url;
	}
	
	public void setImage_url(String image_url) {
		this.image_url = image_url;
	}
	
	public String getSummary() {
		return summary;
	}
	
	public void setSummary(String summary) {
		this.summary = summary;
	}
	
	public String getCreate_country() {
		return create_country;
	}

	public void setCreate_country(String create_country) {
		this.create_country = create_country;
	} 
	
	public String getGrade() {
		return grade;
	}
	
	public void setGrade(String grade) {
		this.grade = grade;
	}
	
	public String getGenre_id() {
		return genre_id;
	}
	
	public void setGenre_id(String genre_id) {
		this.genre_id = genre_id;
	}	
	
	public String getActor() {
		return actor;
	}
	
	public void setActor(String actor) {
		this.actor = actor;
	}	
	
	public int getVideo_id() {
		return video_id;
	}

	public void setVideo_id(int video_id) {
		this.video_id = video_id;
	}
	
	public String getCreate_year() {
		return create_year;
	}
	
	public void setCreate_year(String create_year) {
		this.create_year = create_year;
	}
	
	public int getRecommand() {
		return recommand;
	}
	
	public void setRecommand(int recommand) {
		this.recommand = recommand;
	}	
	
	public int getCategory_id() {
		return category_id;
	}
	
	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}
	
	public Date getUpload_date() {
		return upload_date;
	}

	public void setUpload_date(Date upload_date) {
		this.upload_date = upload_date;
	}

	@Override
	public String toString() {
	return "VideoDto [title = " + title
			+ ", video_url = " + video_url
			+ ", image_url = " + image_url
			+ ", summary = " + summary
			+ ", create_country = " + create_country
			+ ", grade = " + grade
			+ ", actor = " + actor
			+ ", genre_id = " + genre_id
			+ ", video_id = " + video_id
			+ ", create_year = " + create_year
			+ ", recommand = " + recommand
			+ ", category_id = " + category_id + "]";
	}

}
