package com.test.test1.video.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.test1.video.dao.CommentDao;
import com.test.test1.video.dto.CommentDto;

@Service
public class CommentServiceImpl implements CommentService {
	
	@Autowired
	CommentDao commentDao;

//	원댓글등록 02.20 장민실
	@Override
	public void insert(CommentDto dto) {
		commentDao.insert(dto);
	}
	
//	원댓글 등록할때 pid값 자동증가를 위해 DB의 마지막 pid값 가져오기
	@Override
	public int get_pid(CommentDto c_dto) {
		return commentDao.get_pid(c_dto);
	}
	
//	대댓글 작성 02.28 장민실
	@Override
	public void cocomInsert(CommentDto dto) {
		commentDao.cocomInsert(dto);
	}

//	원댓글목록 불러오기 02.21 장민실
	@Override
	public List<CommentDto> replyList(int video_id) {
		return commentDao.replyList(video_id);
	}
	
//	대댓글 목록 불러오기 02.23 장민실
	@Override
	public List<CommentDto> cocomList(CommentDto dto) {
		return commentDao.cocomList(dto);
	}
	
//	댓글 수정 02.27 장민실
	@Override
	public void edit(CommentDto dto) {
		commentDao.edit(dto);
	}

//	댓글,대댓글 삭제 02.23 장민실
	@Override
	public void delete(int comment_id) {
		commentDao.delete(comment_id);
	}

	

	







	

	

}
