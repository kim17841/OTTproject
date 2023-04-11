package com.test.test1.video.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.test1.board.qna.dto.Criteria;
import com.test.test1.user.dto.UserDto;
import com.test.test1.video.dao.VideoDao;
import com.test.test1.video.dto.VideoDto;
import com.test.test1.video.dto.VideoEngDto;

@Service
public class VideoServiceImpl implements VideoService {
	
	@Autowired
	VideoDao videoDao;
	
	@Override
	public String create(Map<String, Object> map) {
		int cnt = this.videoDao.insert(map);
		if (cnt == 1) {
			return map.get("VIDEO_ID").toString();
		}
		return null;
	}
	
//	video_list 전체조회 - 02.10 장민실
	@Override
	public List<VideoDto> list() {
		return videoDao.list();
	}
	
//	video_detail 02.10 장민실
	@Override
	public VideoDto detail(int video_id) {
		return videoDao.detail(video_id);
	}
	@Override
	public VideoEngDto detail_eng(int video_id) {
		return videoDao.detail_eng(video_id);
	}

//	video_detail_actorName 02.10 장민실 
	@Override
	public List<VideoDto> actor(int video_id) {
		return videoDao.actor(video_id);
	}
	@Override
	public List<VideoEngDto> actor_eng(int video_id) {
		return videoDao.actor_eng(video_id);
	}

// 내보관함 구현 02.16 김범수
	@Override
	public int getid(String title) {
		return videoDao.getid(title);
	}

	
	/***********************관리자 페이지용 - 02.19 장재호*******************/
	@Override
	public int adminListCount(Criteria cri) {
		return videoDao.adminListCount(cri);
	}

	@Override
	public List<UserDto> adminList(Criteria cri) throws Exception {
		return videoDao.adminList(cri);		
	}
	/************************************끝**********************************/


}
