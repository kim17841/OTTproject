package com.test.test1.board.qna.dto;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;


/* 게시판 암호화 기능 및 비회원도 사용 가능하게 하기 위해 islogined, password 추가 - 02.17 장재호 */
/* 비화원도 QNA게시판 이용 가능 -> user_id(PK)에서 String id값으로 변경 - 02.18 장재호 */
public class QnaDto {
	private int question_id, islogined;
	private String q_subject, q_content, answer, password, id;
	
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd hh:mm:ss", timezone = "Asia/Seoul")
	private Date q_create_date, a_create_date;
	

	public int getIslogined() {
		return islogined;
	}
	
	public void setIslogined(int islogined) {
		this.islogined = islogined;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public int getQuestion_id() {
		return question_id;
	}
	
	public void setQuestion_id(int question_id) {
		this.question_id = question_id;
	}
	
	public String getQ_subject() {
		return q_subject;
	}
	
	public void setQ_subject(String q_subject) {
		this.q_subject = q_subject;
	}
	
	public String getQ_content() {
		return q_content;
	}
	
	public void setQ_content(String q_content) {
		this.q_content = q_content;
	}
	
	public Date getQ_create_date() {
		return q_create_date;
	}
	
	public void setQ_create_date(Date q_create_date) {
		this.q_create_date = q_create_date;
	}
	
	public String getAnswer() {
		return answer;
	}
	
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	
	public Date getA_create_date() {
		return a_create_date;
	}
	
	public void setA_create_date(Date a_create_date) {
		this.a_create_date = a_create_date;
	}
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}	
	
	@Override
	public String toString() {
		return "QnaDto : [question_id=" + question_id + ", id=" + id + ", q_subject=" + q_subject + ", q_content=" + q_content + 
				", q_create_date=" + q_create_date + ", answer=" + answer + ", a_create_date=" + a_create_date + ", password=" + password + ", islogined=" + islogined + "]";
	}

}
