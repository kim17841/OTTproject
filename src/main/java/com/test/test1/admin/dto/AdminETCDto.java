package com.test.test1.admin.dto;

import java.util.Date;
import java.util.List;

/**************************** 02.18 장재호 ************************/
public class AdminETCDto {

	private String title, summary, video_url, image_url, create_country, create_year, grade, category_name, genre_name, actor_name;
	private int recommand, video_id;
	private List<String> actor;
	private List<Integer> videoidx;
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
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

	public String getCreate_country() {
		return create_country;
	}

	public void setCreate_country(String create_country) {
		this.create_country = create_country;
	}

	public String getCreate_year() {
		return create_year;
	}

	public void setCreate_year(String create_year) {
		this.create_year = create_year;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public int getRecommand() {
		return recommand;
	}

	public void setRecommand(int recommand) {
		this.recommand = recommand;
	}

	public Date getUpload_date() {
		return upload_date;
	}

	public void setUpload_date(Date upload_date) {
		this.upload_date = upload_date;
	}

	private Date upload_date;

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

	public String getActor_name() {
		return actor_name;
	}

	public void setActor_name(String actor_name) {
		this.actor_name = actor_name;
	}
	
	@Override
	public String toString() {
		return "AdminECTDto=[title="+title+", actor_name="+actor_name+"]";
	}

	public int getVideo_id() {
		return video_id;
	}

	public void setVideo_id(int video_id) {
		this.video_id = video_id;
	}

	public List<String> getActor() {
		return actor;
	}

	public void setActor(List<String> actor) {
		this.actor = actor;
	}

	public List<Integer> getVideoidx() {
		return videoidx;
	}

	public void setVideoidx(List<Integer> videoidx) {
		this.videoidx = videoidx;
	}
	
}
/**************************** ******* ************************/