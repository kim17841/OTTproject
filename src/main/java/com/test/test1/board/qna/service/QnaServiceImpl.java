package com.test.test1.board.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.test1.board.qna.dao.QnaDao;
import com.test.test1.board.qna.dto.Criteria;
import com.test.test1.board.qna.dto.QnaDto;

@Service
public class QnaServiceImpl implements QnaService {

	@Autowired
	QnaDao qnaDao;
	
	@Override
	public List<QnaDto> list(Criteria cri) throws Exception {
		return qnaDao.list(cri);
	}
	
	@Override
	public int listCount(Criteria cri) throws Exception {
		return qnaDao.listCount(cri);
	}
	
	@Override
	public void qCreate(QnaDto qnaDto) {
		qnaDao.qCreate(qnaDto);
	}

	@Override
	public QnaDto detail(int question_id) {
		return qnaDao.detail(question_id);
	}

	@Override
	public void modify(QnaDto qnaDto) {
		qnaDao.modify(qnaDto);
	}

	@Override
	public void delete(int question_id) {
		qnaDao.delete(question_id);
	}

	@Override
	public void deletes(List<Integer> delArr) {
		qnaDao.deletes(delArr);
	}

	@Override
	public String passCheck(int question_id) {
		return qnaDao.passCheck(question_id);
	}

	@Override
	public void answerCreate(QnaDto qnaDto) {
		qnaDao.answerCreate(qnaDto);
		
	}

	@Override
	public String answerGet(int question_id) {
		return qnaDao.answerGet(question_id);
	}



}
