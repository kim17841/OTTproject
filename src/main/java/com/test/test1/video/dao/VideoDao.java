package com.test.test1.video.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.test1.board.qna.dto.Criteria;
import com.test.test1.user.dto.UserDto;
import com.test.test1.video.dto.VideoDto;
import com.test.test1.video.dto.VideoEngDto;

@Repository
public class VideoDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public int insert(Map<String, Object> map) {
		return this.sqlSessionTemplate.insert("video.insert", map);		  
	}
	
//	video_list 전체조회 - 02.10 장민실
	public List<VideoDto> list() {
		return sqlSessionTemplate.selectList("video.list");
	}
	
//	video_detail -  02.10 장민실
	public VideoDto detail(int video_id) {
		return sqlSessionTemplate.selectOne("video.detail", video_id);
	}
	public VideoEngDto detail_eng(int video_id) {
		return sqlSessionTemplate.selectOne("video.detail_eng", video_id);
	}

//	video_detail_actorName 02.10 장민실 
	public List<VideoDto> actor(int video_id) {
		return sqlSessionTemplate.selectList("video.actor", video_id);
	}
	public List<VideoEngDto> actor_eng(int video_id) {
		return sqlSessionTemplate.selectList("video.actor_eng", video_id);
	}	

	// 내보관함 구현 02.16 김범수
	public int getid(String title) {
		return sqlSessionTemplate.selectOne("video.getid", title);
	}

	/**************************************** 관리자용 - 02.19 장재호 *****************************/
	public int adminListCount(Criteria cri) {
		return sqlSessionTemplate.selectOne("video.adminListCount", cri);
	}

	public List<UserDto> adminList(Criteria cri) {
		return sqlSessionTemplate.selectList("video.adminList", cri);
	}
	
	/*************************************************************************************/
	
}
