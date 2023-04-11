package com.test.test1.video.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.test1.video.dao.InteractionDao;
import com.test.test1.video.dto.VideoInteractionDto;

@Service
public class InteractionServiceImpl implements InteractionService {
	
	@Autowired
	InteractionDao interactionDao;
	
//	비디오 좋아요 누른값 없을때 - 03.06 장민실
	@Override
	public void video_like(VideoInteractionDto vi_dto) {
		interactionDao.video_like(vi_dto);
		interactionDao.update_video_like(vi_dto);
		interactionDao.update_video_recommand(vi_dto);
	}

//	비디오 싫어요 누른값 없을때 - 03.07 장민실
	@Override
	public void video_unlike(VideoInteractionDto vi_dto) {
		interactionDao.video_unlike(vi_dto);
		interactionDao.update_video_unlike(vi_dto);
		interactionDao.update_video_recommand(vi_dto);
	}

//	video_idx,like,unlike 값 받아오기 - 03.06 장민실
	@Override
	public List<VideoInteractionDto> get_v_inter_info(VideoInteractionDto vi_dto) {
		return interactionDao.get_v_inter_info(vi_dto);
	}
	
//	비디오 좋아요,싫어요 누른값 있을때 - 03.06 장민실
	@Override
	public void v_delete(VideoInteractionDto vi_dto) {
		interactionDao.v_delete(vi_dto);
		interactionDao.update_video_like(vi_dto);
		interactionDao.update_video_unlike(vi_dto);
		interactionDao.update_video_recommand(vi_dto);
	}
	



	
	
	

}
