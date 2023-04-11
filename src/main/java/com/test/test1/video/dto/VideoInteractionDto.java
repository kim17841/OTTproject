package com.test.test1.video.dto;

public class VideoInteractionDto {
	
	int v_idx, user_id, video_id, like, unlike;
	
	public int getV_idx() {
		return v_idx;
	}

	public void setV_idx(int v_idx) {
		this.v_idx = v_idx;
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

	public int getLike() {
		return like;
	}

	public void setLike(int like) {
		this.like = like;
	}

	public int getUnlike() {
		return unlike;
	}

	public void setUnlike(int unlike) {
		this.unlike = unlike;
	}
	
	@Override
	public String toString() {
	return "VideoInteractionDto [v_idx = " + v_idx
			+ ", user_id = " + user_id
			+ ", video_id = " + video_id
			+ ", like = " + like
			+ ", unlike = " + unlike + "]";
	}
	
	

}
