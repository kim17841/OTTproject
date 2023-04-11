package com.test.test1.board.qna.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.test1.board.qna.dto.Criteria;
import com.test.test1.board.qna.dto.QnaDto;

@Repository
public class QnaDao {

	@Autowired
	SqlSession ss;
	
	public List<QnaDto> list(Criteria cri) throws Exception {		
		return ss.selectList("qna.q_list", cri);
	}	

	public int listCount(Criteria cri) {
		return ss.selectOne("qna.listCount", cri);
	}
	
	public void qCreate(QnaDto qnaDto) {
		if(qnaDto.getId().equals("guest")) {
			ss.insert("qna.q_create", qnaDto);
		}
		else {
			ss.insert("qna.q_create2",qnaDto);
		}

	}

	public QnaDto detail(int question_id) {		
		return ss.selectOne("qna.detail", question_id);
	}

	public void modify(QnaDto qnaDto) {
		ss.update("qna.modify", qnaDto);
	}

	public void delete(int question_id) {
		ss.delete("qna.delete", question_id);		
	}


	public void deletes(List<Integer> delArr) {
		ss.delete("qna.deletes", delArr);
	}

	
	public String passCheck(int question_id) {
		return ss.selectOne("qna.passCheck", question_id);
	}


	public void answerCreate(QnaDto qnaDto) {
		ss.update("qna.answerCreate", qnaDto);
	}


	public String answerGet(int question_id) {
		return ss.selectOne("qna.answerGet", question_id);
	}

	
}
