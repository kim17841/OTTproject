package com.test.test1.video.service;

import java.util.List;
import java.util.Map;

import com.test.test1.board.qna.dto.Criteria;
import com.test.test1.user.dto.UserDto;
import com.test.test1.video.dto.VideoDto;
import com.test.test1.video.dto.VideoEngDto;

public interface VideoService {
	
	String create(Map<String, Object> map);
	
//	video_list 전체조회 - 02.10 장민실
	List<VideoDto> list();

//	video_detail 02.10 장민실
	VideoDto detail(int video_id);
	VideoEngDto detail_eng(int video_id);

//	vodeo_detail_actorName 02.10 장민실 
	List<VideoDto> actor(int video_id);
	List<VideoEngDto> actor_eng(int video_id);

	// 내보관함 구현 02.16 김범수
	int getid(String title);

	/***********************관리자 페이지용 - 02.19 장재호*******************/
	int adminListCount(Criteria cri);

	List<UserDto> adminList(Criteria cri) throws Exception;
	/*****************************끝*************************/



	
	

}
