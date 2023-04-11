package com.test.test1.board.qna.service;

import java.util.List;

import com.test.test1.board.qna.dto.Criteria;
import com.test.test1.board.qna.dto.QnaDto;

public interface QnaService {

	void qCreate(QnaDto qnaDto);

	List<QnaDto> list(Criteria cri) throws Exception;
	
	public int listCount(Criteria cri) throws Exception;

	QnaDto detail(int question_id);

	void modify(QnaDto qnaDto);

	void delete(int question_id);

	void deletes(List<Integer> delArr);

	String passCheck(int question_id);

	void answerCreate(QnaDto qnaDto);

	String answerGet(int question_id);



}
