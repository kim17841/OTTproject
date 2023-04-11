package com.test.test1.video.dto;

import java.util.Date;

public class CommentDto {
	
	private String commentary, nickname, cocom_date, img;
	private int comment_id, pid, video_id, user_id, depth, depth_lev;
	private Date create_date;

	public String getCommentary() {
		return commentary;
	}
	
	public void setCommentary(String commentary) {
		this.commentary = commentary;
	}
	
	public String getNickname() {
		return nickname;
	}
	
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	public String getCocom_date() {
		return cocom_date;
	}

	public void setCocom_date(String cocom_date) {
		this.cocom_date = cocom_date;
	}
		public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public int getComment_id() {
		return comment_id;
	}
	
	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}
	
	public int getPid() {
		return pid;
	}
	
	public void setPid(int pid) {
		this.pid = pid;
	}
	
	public int getVideo_id() {
		return video_id;
	}
	
	public void setVideo_id(int video_id) {
		this.video_id = video_id;
	}
	
	public int getUser_id() {
		return user_id;
	}
	
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	
	public int getDepth() {
		return depth;
	}
	
	public void setDepth(int depth) {
		this.depth = depth;
	}
	
	public int getDepth_lev() {
		return depth_lev;
	}
	
	public void setDepth_lev(int depth_lev) {
		this.depth_lev = depth_lev;
	}
	
	public Date getCreate_date() {
		return create_date;
	}
	
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}

	@Override
	public String toString() {
	return "CommentDto [commentary = " + commentary
			+ ", nickname = " + nickname
			+ ", cocom_date = " + cocom_date
			+ ", img = " + img
			+ ", comment_id = " + comment_id
			+ ", pid = " + pid
			+ ", video_id = " + video_id
			+ ", user_id = " + user_id
			+ ", depth = " + depth
			+ ", depth_lev = " + depth_lev
			+ ", create_date = " + create_date + "]";		
	}
	
	
	

}
