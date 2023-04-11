package com.test.test1.alarm.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.test1.alarm.dto.AlarmDto;
import com.test.test1.board.qna.dto.QnaDto;
import com.test.test1.video.dto.CommentDto;

/* 02.23 장재호 */
@Repository
public class AlarmDao {
	
	@Autowired
	SqlSession ss;

	public int selectAlarmCount(String id) throws Exception{
		return ss.selectOne("alarm.alarmSelect", id);		
	}

	public void addQnaAlarm(QnaDto qnaDto) {
		if(ss.selectOne("alarm.checkUser", qnaDto) != null) {
			ss.insert("alarm.addQna", qnaDto);
		}
	}

	public List<AlarmDto> selectAlarm(String hsid) {
		return ss.selectList("alarm.select", hsid);
	}

	public void alarmDel(int idx) {
		ss.delete("alarm.delete", idx);
	}

	public void addComment(CommentDto dto) {
		ss.insert("alarm.addComment", dto);		
	}

}
/* 02.23 장재호 */