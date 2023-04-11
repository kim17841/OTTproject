package com.test.test1.video.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.test1.video.dto.VideoInteractionDto;

@Repository
public class InteractionDao {
	
	@Autowired
	SqlSession sqlSession;
	
//	=====================================  비디오영역  =====================================
	
//	비디오 좋아요 누른값 없을때 - 03.06 장민실
	public void video_like(VideoInteractionDto vi_dto) {
		sqlSession.insert("interaction.video_like", vi_dto);
	}

//	비디오 싫어요 누른값 없을때 - 03.07 장민실
	public void video_unlike(VideoInteractionDto vi_dto) {
		sqlSession.insert("interaction.video_unlike", vi_dto);
	}
	
//	video_idx,like,unlike 값 받아오기 - 03.06 장민실
	public List<VideoInteractionDto> get_v_inter_info(VideoInteractionDto vi_dto) {
		return sqlSession.selectList("interaction.get_v_inter_info", vi_dto);
	}
	
//	video_user_like 테이블의 like값을 참조하여 video테이블의 like 값 변경하기
	public void update_video_like(VideoInteractionDto vi_dto) {
		sqlSession.update("interaction.update_video_like", vi_dto);
	}
	
//	video_user_like 테이블의 unlike값을 참조하여 video테이블의 unlike 값 변경하기
	public void update_video_unlike(VideoInteractionDto vi_dto) {
		sqlSession.update("interaction.update_video_unlike", vi_dto);
	}
	
//	비디오 좋아요,싫어요 누를때 video테이블 recommand 컬럼 업데이트 하기 03.07 장민실
	public void update_video_recommand(VideoInteractionDto vi_dto) {
		sqlSession.update("interaction.update_video_recommand", vi_dto);
	}
	
//	비디오 좋아요,싫어요 누른값 있을때 - 03.06 장민실
	public void v_delete(VideoInteractionDto vi_dto) {
		sqlSession.delete("interaction.v_delete", vi_dto);
	}
	
//	=====================================  비디오영역  =====================================
	




}
