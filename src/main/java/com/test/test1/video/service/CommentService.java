package com.test.test1.video.service;

import java.util.List;

import com.test.test1.video.dto.CommentDto;

public interface CommentService {

//	원댓글등록 02.20 장민실
	void insert(CommentDto dto);
	
//	원댓글 등록할때 pid값 자동증가를 위해 DB의 마지막 pid값 가져오기
	int get_pid(CommentDto c_dto);
	
//	대댓글 작성 02.28 장민실
	void cocomInsert(CommentDto dto);

//	원댓글목록 불러오기 02.21 장민실
	List<CommentDto> replyList(int video_id);
	
//	대댓글 목록 불러오기 02.23 장민실
	List<CommentDto> cocomList(CommentDto dto);
	
//	댓글,대댓글 수정 02.27 장민실
	void edit(CommentDto dto);

//	댓글 삭제 02.23 장민실
	void delete(int comment_id);

	

	





;
}
