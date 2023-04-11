package com.test.test1.user.dto;

import java.util.Date;

public class UserDto {
	private int user_id, paid_m; //결제 누적 수 paid_m 추가 - 02.18 장재호
	private String id, email, password, nickname, phone_num, subscribe_yn, delete_yn, img; // 유저 프로필 가져오기 위해 img 추가 - 02.24 김범수
	private String create_type; //apiLogin때문에 추가 - 02.10 장재호
	private String chatId; // chat기능 - 02.11 장재호
	private String paid;
	private Date create_date, expiration_date, delete_date; //관리자 페이지 추가 - 02.18 장재호
	
			
	public Date getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}

	public Date getExpiration_date() {
		return expiration_date;
	}

	public void setExpiration_date(Date expiration_date) {
		this.expiration_date = expiration_date;
	}

	public Date getDelete_date() {
		return delete_date;
	}

	public void setDelete_date(Date delete_date) {
		this.delete_date = delete_date;
	}

	public String getCreate_type() {
		return create_type;
	}

	public void setCreate_type(String create_type) {
		this.create_type = create_type;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getPhone_num() {
		return phone_num;
	}

	public void setPhone_num(String phone_num) {
		this.phone_num = phone_num;
	}

	public String getSubscribe_yn() {
		return subscribe_yn;
	}

	public void setSubscribe_yn(String subscribe_yn) {
		this.subscribe_yn = subscribe_yn;
	}

	public String getDelete_yn() {
		return delete_yn;
	}

	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}

	public String getChatId() {
		return chatId;
	}

	public void setChatId(String chatId) {
		this.chatId = chatId;
	}

	public int getPaid_m() {
		return paid_m;
	}

	public void setPaid_m(int paid_m) {
		this.paid_m = paid_m;
	}
	// 02.26 김범수 추가
	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	@Override
	public String toString() {
		return "UserDto : [id=" + id + ", email=" + email + ", passwd="+ password+ ", nickname=" + nickname + ", phone_num=" + phone_num +
				", create_type=" + create_type + ", paid_m=" + paid_m + ", img=" + img + ", paid=" + paid + "]";
	}

	public String getPaid() {
		return paid;
	}

	public void setPaid(String paid) {
		this.paid = paid;
	}

	
}

