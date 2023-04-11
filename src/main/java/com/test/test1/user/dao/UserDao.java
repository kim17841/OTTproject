package com.test.test1.user.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import com.test.test1.board.qna.dto.Criteria;
import com.test.test1.mypage.dto.ImgDto;
import com.test.test1.user.dto.UserDto;

@Repository
public class UserDao {
	
	@Autowired
	BCryptPasswordEncoder encoder;	
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	//id 중복확인 버튼 기능 - 01.31 장재호
	public String idCheck(String id) {
		String check = null; //check : id 중복 값이 있다면 담김
		check = this.sqlSessionTemplate.selectOne("user.id_check", id);
		return check;
	}
	
	//회원 가입 - 01.31 장재호
	public void create(UserDto userDto) {
		sqlSessionTemplate.insert("user.insert", userDto);
		
	}
	
	//로그인 - 01.31 장재호
	public String login(UserDto userDto) {
		String pw = sqlSessionTemplate.selectOne("user.pwGet", userDto);// pw : DB에 암호화 된 userPW
		
		if(encoder.matches(userDto.getPassword(), pw)) {                 //비밀번호 일치 시
			return sqlSessionTemplate.selectOne("user.login", userDto);  //nickname값 세션 저장을 위해 return
		}
		else return null;
	}
	
	//전체 조회 - 01.31 장재호
	//관리자 페이징 추가 - 02.18 장재호
	public List<UserDto> list(Criteria cri) throws Exception {
		return sqlSessionTemplate.selectList("user.list", cri);
		
	}

	//아이디 찾기 - 02.10 김범수
	public String findid(String email) {
		return sqlSessionTemplate.selectOne("user.findid", email);
	}

	//비밀번호 찾기 - 02.10 김범수
	public String findpw(UserDto dto) {
		return sqlSessionTemplate.selectOne("user.findpw", dto);
	}

	public String emailCheck(String email) {
		String check1 = null; //check : email 중복 값이 있다면 담김
		check1 = this.sqlSessionTemplate.selectOne("user.email_check", email);
		return check1;
	}
	
	//비밀번호 변경 - 02.12 김범수
	public void changepw(UserDto dto) {
		sqlSessionTemplate.selectOne("user.changepw", dto);
	}

	//결제 처리 - 02.15 장재호
	public void paid(Map<String, Object> map) {
		sqlSessionTemplate.update("user.paid", map);
	}
	
	// 개인정보상세조회  02/16 김지혜 
	public UserDto detail(String user_id) {
		return sqlSessionTemplate.selectOne("user.detail", user_id);
	}

	//개인정보수정 23/02/20 김지혜  
	public void infoModify(UserDto dto) {
		// 이메일 중복거르기		
		sqlSessionTemplate.update("user.infoModify", dto);		
	}
	
	//기 결제확인 - 02.18 장재호
	public String paidCheck(String ID) {
		return sqlSessionTemplate.selectOne("user.paidCheck", ID);
	}

	//재결제 시 - 02.18 장재호
	public void rePaid(Map<String, Object> map) {
		sqlSessionTemplate.update("user.rePaid", map);		
	}
	
	//페이징 추가 - 02.18 장재호
	public int listCount(Criteria cri) {
		return sqlSessionTemplate.selectOne("user.listCount", cri);
	}

	//관리자 페이지 일 결제 추가 - 02.19 장재호
	public void paidUpdate(int months) {
		//1. 오늘 첫 결제일 경우
		if(sqlSessionTemplate.selectOne("user.todayPaidCheck") == null) {
			sqlSessionTemplate.insert("user.todayFirstPaid", months);
		}
		//2. 아닐경우 +
		else sqlSessionTemplate.update("user.todayAddPaid", months);
	}

	//방문자수 - 02.19 장재호
	public void addVisit() {
		//1. 일별로 방문 1번째일 때
		if(sqlSessionTemplate.selectOne("user.todayVisitCheck") == null){
			sqlSessionTemplate.insert("user.todayFirstVisit");
		}
		else sqlSessionTemplate.update("user.todayAddVisit");
	}
	
//	video detail 내 댓글등록 위해 유저정보 받아오기 02.20 장민실
	public int getid(String user_id) {
		return sqlSessionTemplate.selectOne("user.getid", user_id);
	}

	public void img_update(ImgDto dto) {
		sqlSessionTemplate.selectOne("user.img_update" , dto);
	}

	public String navbarImg(String id) {
		return sqlSessionTemplate.selectOne("user.navbarImg" , id);
	}
	
}
