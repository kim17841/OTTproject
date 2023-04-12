### 4.2. 로그인 기능 구현
<details>
<summary> <b>기능 설명</b> </summary>

- 사용자가 정보를 입력하고 로그인 버튼을 누르면 DB의 정보와 비교 후 로그인 여부를 확인함.

- 사용자가 입력한 정보와 가져온 정보와 일치하지 않으면 안내 메시지를 출력.

- 사용자가 입력한 정보와 가져온 정보가 일치하면 세션을 부여하고 메인 페이지로 주소 이동.
</details>
  
<details>
<summary> <b>JSP</b> </summary>

  
- 사용자에게 정보를 입력 받고 form태그에 담습니다.

```
<body>
(... 생략 ...)  

  
	<section>
		<div class="section_loginform">
			<span class="login"><span class="login_text">로그인</span><small>
			<a href="/user/find">비밀번호를 잊어버리셨나요?</a></small></span>
			<form method="post" action="signin_check" class="login_form">
				<div>
					<div class="input_text">
						<input type="text" name="id" placeholder="ID" autocomplete="off" 
						class="input_size">
						<span id="id" class="formSpans"></span>
					</div>
					<div class="input_text">
						<input type="password" name="password" placeholder="비밀번호" 
						autocomplete="off" class="input_size">
						<span id="password" class="formSpans"></span>

					</div>
					<button class="login_submit">로그인</button>
					<c:if test="${message == 'error' }">
            			<div class="error_text">아이디 또는 비밀번호가 일치하지 않습니다.</div>
         			</c:if>
         			<c:if test="${message == 'success' }">
            			<div class="error_text"></div>
         			</c:if>
				</div> 
			</form>
			
			<span class="division_line"> <br>다른 방법으로 로그인하기</span>
      			(... 생략 ...)   
			<div>
				<span class="signup_text"> <br>혹시 아직 회원이 아닌가요? </span>
				<br>
				<form method="get" action="/user/signup">
					<button class="signup">회원가입</button>
				</form>
			</div>
		</div>
	</section>
</body>
```
</details>
<details>
<summary> <b>Javascript</b> </summary>

- 사용자가 입력한 정보를 JS로 빈칸으로 submit하는 것을 방지합니다. 조건에 걸리지 않으면 form으로 Controller에 정보를 전달합니다.
 
```javascript
// 로그인을 빈칸으로 제출하는 것을 방지
$(function(){ 
    $(".login_submit").click(function(e){
    	e.preventDefault();
        var id=$("input[type=text]").val(); // 아이디 입력값
        var password=$("input[type=password]").val(); // 비밀번호 입력값
                   
        if(id== "" || id == null){ //아이디 빈칸 방지 
            $('#id').html("아이디를 입력해주세요");
            $("input[type=text]").focus();
            return;
        }
        else{
        	$('#id').html("");
            if(password == "" || password == null){ //비밀번호 빈칸 방지 
                $('#password').html("비밀번호를 입력해주세요");
                $("input[type=password]").focus();
                return;
            }
            else{
            	$('#password').html("");
                // signin_check 메소드로의 이동
            	$('.login_form').submit();
            }
        }
    });
});
```

</details>

  
<details>
<summary> <b>Controller</b> </summary>

- userDto에는 사용자가 입력한 정보가 담기며, str에는 해당 정보를 XML로 가져가 DB데이터와비교 후 정보가 있으면 해당 데이터를 불러옵니다. 정보가 없으면 null값을 가집니다.

- 정보가 일치할 경우 메인 페이지로 주소를 이동시키고, 세션 유지 시간을 부여 합니다.

```java 

// 로그인을 빈칸으로 제출하는 것을 방지
	@RequestMapping("signin_check")
	public ModelAndView signin_check(UserDto userDto, HttpSession session, ModelAndView mv) {
		String str = userService.login(userDto);   //str : 유저닉네임(email, pw 일치 시 존재)
		if(str != null) {                          //로그인 성공(세션에 로그인 정보 추가)
			session.setAttribute("user_id", userDto.getId());
			session.setAttribute("nickname", str);
			session.setMaxInactiveInterval(60*30); //세션 유지기간 : 30분
			mv.setViewName("redirect:/video/list"); 
		}else {                                    //로그인 실패
			mv.setViewName("user/signin");
			mv.addObject("message", "error");
		}
		return mv;
	}
  

```
</details>

<details>
<summary> <b>DTO</b> </summary>

- 테이블에 들어 있는 정보를 미리 변수로 생성하고 getter/setter를 설정한 파일입니다.
 
```java 

package com.test.test1.user.dto;

import java.util.Date;

public class UserDto {
	private int user_id, paid_m; //결제 누적 수 paid_m 추가 
	private String id, email, password, nickname, phone_num, subscribe_yn, delete_yn, img; // 유저 프로필 가져오기 위해 img 추가 
	private String create_type; //apiLogin때문에 추가
	private String chatId; // chat기능
	private Date create_date, expiration_date, delete_date; //관리자 페이지 추가 
	
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
	
	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	@Override
	public String toString() {
		return "UserDto : [id=" + id 
			+ ", email=" + email 
			+ ", passwd="+ password 
			+ ", nickname=" + nickname 
			+ ", phone_num=" + phone_num 
			+ ", create_type=" + create_type 
			+ ", paid_m=" + paid_m 
			+ ", img=" + img 
			+ "]";
	}

}
  

```
</details>

<details>
<summary> <b>Service / ServiceImpl</b> </summary>
  

- 비교할 데이터를 Dao까지 전송합니다


```java 
// Service 
String login(UserDto userDto);

// ServiceImpl
@Override
public String login(UserDto userDto) {
	return userDao.login(userDto);
}
  
```
</details>
  
<details>
<summary> <b>DAO</b> </summary>
  

- pw에 해당 아이디 일치하는 암호화된 패스워드를 불러옵니다
- 사용자가 입력한 패스워드와 pw를 비교 후 nickname값을 세션에 저장시킵니다. 일치하지 않으면 null값을 리턴 합니다.
  


```java 
// Service 
String login(UserDto userDto);

// ServiceImpl
@Override
public String login(UserDto userDto) {
	return userDao.login(userDto);
}
  
```
</details>
  
<details>
<summary> <b>XML</b> </summary>
  

- pwGet : 사용자의 정보를 DB에 조회하여 암호화된 패스워드를 불러오는 역할을 합니다.
- login : 사용자의 닉네임을 불러오는 역할을 합니다.


```xml 
<!-- 유저가 입력한 아이디를 기반으로 암호화된 패스워드를 불러옵니다. -->
<select id="pwGet" resultType="String">
		select PASSWORD
		  from USER
		 where ID=#{id}
</select>

/////////////////////////////////////////

<!-- 위에서 암호화된 패스워드와 사용자가 입력한 패스워드를 비교 후 
사용자의 nickname 값을 호출합니다 -->
<select id="login" resultType="String">
		select NICKNAME
		  from USER
		 where ID=#{id}
</select>
```
</details>
