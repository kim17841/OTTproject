# 💡 OTT 플랫폼 서비스



## 1. 제작 기간 & 참여 인원
- 2023년 2월 1일 ~ 3월 7일
- 5명



## 2. 사용 기술
#### `Back-end`
- Spring-framework(MVC) 5.2.18 RELEASE
- Mybatis 3.5.4
- Java 1.8.0

#### `Front-end`
- HTML5 
- CSS3 
- javaScript ES6
- J-Query 3.6.0
- JSP 
#### `Server`
- Apache-Tomcat 9.0.71 
#### `Database`
- My-SQL 8.0.28   


## 3. 내 역할과 업무성과
- 로그인 기능 구현
- 아이디/비밀번호 찾기 기능 구현 
- 내보관함 리스트 기능 구현 
- 사용자 프로필 업로드 기능 구현 

## 4. 구현 기능 코드 
<details>
<summary><b>구현 기능 설명 펼치기</b></summary>
<div markdown="1">

### 4.1. 전체 흐름

![mvc](https://github.com/kim17841/OTTproject/blob/main/Portfolio/MVC%ED%8C%A8%ED%84%B4.jpg?raw=true)

### 4.2. 로그인 기능 구현

![mvc](https://github.com/kim17841/OTTproject/blob/main/Portfolio/login.jpg?raw=true)

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

### 4.3. 아이디/비밀번호 찾기 기능 구현

![mvc](https://github.com/kim17841/OTTproject/blob/main/Portfolio/id%26pw.jpg?raw=true)
![mvc](https://github.com/kim17841/OTTproject/blob/main/Portfolio/changePw.jpg?raw=true)

<details>
<summary> <b>기능 설명</b> </summary>

  - 사용자가 이메일 인증을 거친 후 아이디 / 비밀번호 찾기를 진행하면 DB의 정보 확인 후 계정 정보를 제공 또는 비밀번호 강제 변경을 진행.

  - 사용자가 입력한 이메일로 인증하면 이메일을 DB에 조회해 일치하는 정보가 있으면 해당 아이디를 제공.

  - 사용자가 입력한 정보와 가져온 정보가 일치하면 세션을 부여하고 메인 페이지로 주소 이동.
</details>
  
<details>
<summary> <b>JSP</b> </summary>

  
- 사용자에게 정보를 입력 받고 form을 통해 Controller 정보를 전달합니다.

```
<body>

(... 생략 ...)
	
	<section>
	<!-- 아이디 찾기 -->
		<div class="section_loginform">
			<span class="login">아이디 찾기</span>         
			<form>
				<div>
					<!-- 사용자의 이메일을 입력받음 -->
					<div class="input_text">
						<input type="email" name="email" placeholder="Email" autocomplete="off" 
						class="input_size" id="input_email1">
					</div>
					<div>
						<button class="email_checkbtn" id="emailchk1">이메일 인증</button>
	
						<!-- 이메일 인증 상태 메세지 -->
						<span id="email_text1" class="formSpans"></span> 
						<br>

						<input type="text" placeholder="인증번호 입력" autocomplete="off" 
						class="authorkey" id="author1" maxlength="6">

						<button class="key_submit" id="author_submit1">확인</button>
					</div>
					<input type="button" value="아이디 찾기" class="login_submit_id">
					<br>
					<!-- 아이디 찾기 상태 메세지  -->
					<span id="submit_id_text" class="formSpans"></span>                    
				</div> 
			</form>
			<!-- 구분선  -->
			<span class="division_line"></span> 

			<!-- 비밀번호 찾기 -->
			<span class="login">비밀번호 찾기</span> 
			<form>
				<div>
					<!-- 아이디 입력 창  -->
					<div class="input_text">
						<input type="text" name="id" placeholder="ID" autocomplete="off" 
						class="input_size" id="id">
					</div>
					<br>
					<!-- 이메일 입력창  -->
					<div class="input_text">
						<input type="email" name="email" placeholder="Email" autocomplete="off" 
						class="input_size" id="input_email2">
					</div>
					<div>
						<button class="email_checkbtn" id="emailchk2">이메일 인증</button>

						<!-- 이메일 인증 상태 확인 메세지 -->
						<span id="email_text2" class="formSpans"></span> 
						<br>
						<input type="text" placeholder="인증번호 입력" autocomplete="off" 
						class="authorkey" id="author2" maxlength="6">

						<button class="key_submit" id="author_submit2">확인</button>
					</div>
					<input type="button" value="비밀번호 찾기" class="login_submit_pw" 
					id="pw_submit">
					<br>
					<!-- 비밀번호 찾기 상태 확인 메세지 -->
					<span id="submit_pw_text" class="formSpans"></span>       
				</div> 
			</form>
		</div>

	<!-- 비밀번호 변경  -->
	(... 생략 ...)
	<!-- 비밀번호 입력 -->
	<div class="pw_input_text">
		<input type="password" name="password" placeholder="비밀번호" autocomplete="off" class="input_size" id="pw">
		<!-- 비밀번호 입력 상태 확인 메세지 - 정규표현식에 위배되면 출력됨 -->
		<span id="input_regex" class="formSpans"></span>
        </div>
      	<!-- 비밀번호 확인 입력 - 비밀번호 입력에서 정규표현식에 맞게 입력되면 입력가능-->
	<div class="pw_input_text">
		<input type="password" name="password_confirm" placeholder="비밀번호 확인" autocomplete="off" class="input_size" id="pw_confirm" disabled="disabled">
        </div>
        <button id="pw_checkbtn">확인</button>     
        <span id="check_result" class="formSpans"></span>
        <input type="button" value="비밀번호 변경" class="login_submit_pw" 
				id="change_pw" disabled="disabled">
	(... 생략 ...)
	</section>

(... 생략 ...)

</body>
```
</details>

<details>
<summary> <b>Javascript</b> </summary>

- 사용자가 입력한 정보의 유효성을 확인한 다음 form의 submit을 제어하고, 아이디 값을 다시    반환하거나 비밀번호 변경을 진행합니다. 
  <details>
  <summary> <b>아이디 찾기 구현 코드</b> </summary>
   
  - 이메일 형식을 먼저 확인 후 이메일 인증을 진행합니다. (AJAX로 이메일로 인증번호 전송)<br>
  - 인증번호는 빈칸/정보가 일치하지 않을 시에 안내 메시지를 출력합니다.<br>
  - 인증이 완료된 후 AJAX를 통하여 Controller에 사용자가 입력한 이메일 정보를 보냅니다.<br>
  - DB에 일치하는 정보가 있으면 리턴 받은 ID값을 alert을 통해 사용자에게 보여줍니다.

  ```javascript
    var code1 = ""; // 아이디 이메일 전송 인증번호 저장할 공간
  var code2 = ""; // 비밀번호 이메일 전송 인증번호 저장할 공간
  var email1= ""; // 아이디 이메일 인증 - 이메일이 들어갈 변수 지정 
  var email2= ""; // 비밀번호 이메일 인증 - 이메일이 들어갈 변수 지정 
  var id = ""; // id가 들어갈 변수 지정
  var inputCode = ""; //사용자가 입력한 인증번호

  /////////////// 아이디찾기 이메일 인증 ///////////
  $(function(){
      $('#emailchk1').click(function(e) {
          // 시스템 자체의 submit을 막음
          e.preventDefault();

          // 사용자가 입력한 이메일
          email1 = $("#input_email1").val();

          var inputResult = $('#email_text1'); // 인증 상태 메세지

          if(email1 == null || email1 == ""){ // 이메일 값이 없는 것을 방지
              inputResult.html('이메일을 입력해주세요');
              $("#input_email1").focus(); 
              return;
          }
          else if(!email1.match('@')){ // 입력받은 이메일에 @없는 걸 방지
              inputResult.text("올바른 이메일 형태를 입력해주세요");
              $("#input_email1").focus();
              return;
          }
          else{ // 위 조건에 걸리지 않으면 상태메세지 없앰
              inputResult.text("");
          }
          inputResult.html('인증번호 전송이 완료되었습니다');
          // ajax로 통해 컨트롤러(mailCheck메소드)로 email의 정보를 넘김 
          // -> 넘기는게 성공하면 인증번호 데이터를 code에 담음
          $.ajax({
              type : "GET",
              url : "mailCheck?email=" + email1, // 해당 메소드에 email값을 보냄
              success:function(data1){
                  code1 = data1; // 인증 번호가 담기는 구역
              } 
          }); // ajax end
      }); //event function end

      // 인증번호 확인 버튼 클릭시 이벤트
      $('#author_submit1').click(function(e){
          e.preventDefault(); // 키에 대한 submit을 막아놓음

          var inputCode = $('#author1').val(); 
          //사용자가 인증번호를 입력하는 input의 value
          var inputResult = $('#email_text1'); // 인증 상태 메세지

          if(inputCode === null || inputCode === ""){ // 사용자가 입력하지 않은경우
              inputResult.html("인증번호를 입력해주세요.");
              return;
          }
          else if(inputCode == code1){ 
          // 사용자가 입력한 인증번호와 발급한 인증번호가 맞을 경우
              inputResult.html("인증번호가 일치합니다.");

          }else{ // 사용자가 입력한 인증번호와 발급한 인증번호가 일치하지 않을 경우
              inputResult.html("인증번호를 다시 확인 해주세요.");
              return;
          }
      }); // event function end

      //////////// 아이디 찾기 //////////
      $('.login_submit_id').click(function(){
          inputCode = $('#author1').val();
          var inputResult = $('#email_text1');
          email1 = $("#input_email1").val();
          if(email1 == "" || email1 == null || !email1.match('@')){ 
          // 이메일 값이 없거나 올바른 이메일 형식이 아닌 경우
              $('#submit_id_text').html('이메일 인증을 먼저 해주세요');
              $("#input_email1").focus();
              return;
          }
          else if(inputCode == "" || inputCode == null || inputCode != code1){
              $('#submit_id_text').html('인증번호를 입력해주세요');
              $('#author1').focus();
              return;
          }
          else{
              if(email1 != null){ // 위의 ajax에서 이메일을 제대로 받아온 경우
                  $.ajax({
                      url : 'findid', 
                      dataType : 'text',
                      data : {"email" : email1},
                      type : 'post',
                      success:function(id) {		
                          if(id == null || id == ""){ // 빽단에서 받아온 id값이 없는 경우 
                              $('#submit_id_text').html('등록된 정보가 없습니다');
                              return;
                          }
                          else{ // 빽단에서 받아온 id값이 있어 제대로 출력된 경우 
                              alert('아이디는'+id+'입니다');
                              $('#submit_id_text').html('');
                          }
                      },
                      error : function() { $('#submit_id_text').html('등록된 정보가 없습니다'); return; }		
                  }); // ajax end
              }

              else{	//이메일을 입력하지 않을 경우
                  $('#submit_id_text').html('이메일 인증을 먼저해주세요'); 
                  inputResult.html('인증번호를 입력해주세요');
                  return;
              }
          }
      }); // event function end
  }); // function end

  ```

  </details>
  <details>
  <summary> <b>비밀번호 찾기 구현 코드</b> </summary>
    
  - 이메일 형식 확인과 인증번호 인증은 아이디 찾기와 동일합니다.<br>
  - 인증이 완료된 후 AJAX를 통하여 Controller에 사용자의 입력 아이디와 이메일을 보냅니다.<br>
  - DB에서 일치하는 정보가 있으면 메시지를 반환 받아 ok면 비밀번호 변경 창을 띄웁니다.

  ```javascript
   /////////////// 비밀번호 찾기 이메일 인증  ///////////
  $(function(){
      $('#emailchk2').click(function(e) {
          e.preventDefault();

          email2 = $("#input_email2").val();	// 사용자가 입력한 이메일

          var inputResult = $('#email_text2'); // 인증 상태 메세지

          if(email2 == null || email2 == ""){ // 이메일 값이 없는 것을 방지
              inputResult.html('이메일을 입력해주세요');
              $("#input_email2").focus(); 
              return;
          }
          else if(!email2.match('@')){ // 입력받은 이메일에 @없는 걸 방지
              inputResult.text("올바른 이메일 형태를 입력해주세요");
              $("#input_email2").focus();
              return;
          }
          else{ // 올바른 이메일 형식을 입력받은 경우
              inputResult.text("");
          }
          inputResult.html('인증번호 전송이 완료되었습니다');

          $.ajax({ 
          // ajax로 통해 컨트롤러(mailCheck메소드)로 email의 정보를 넘김 
          // -> 넘기는게 성공하면 인증번호 데이터를 code에 담음
              type : "GET",
              url : "mailCheck?email=" + email2, // 해당 메소드에 email값을 보냄
              success:function(data2){
                  code2 = data2; // 인증 번호가 담기는 구역
              } // success end
          }); // ajax end
      }); //event function end

      $('#author_submit2').click(function(e){ 	// 인증번호 확인 버튼 클릭시
          e.preventDefault(); // 키에 대한 submit을 막아놓음

          inputCode = $('#author2').val(); //사용자가 인증번호를 입력한 값
          var inputResult = $('#email_text2'); // 인증 상태 메세지

          if(inputCode === null || inputCode === ""){ // 사용자가 입력하지 않은경우
              inputResult.html("인증번호를 입력해주세요.");
              return;
          }
          else if(inputCode == code2){	
          // 사용자가 입력한 인증번호와 발급한 인증번호가 맞을 경우
              inputResult.html("인증번호가 일치합니다.");

          }else{ // 사용자가 입력한 인증번호와 발급한 인증번호가 일치하지 않을 경우
              inputResult.html("인증번호를 다시 확인 해주세요.");
              return;
          }
      }); //event function end

      //////////비밀번호 찾기  ////////
      $("#pw_submit").click(function(){
          id = $('#id').val();
          email2 = $("#input_email2").val();
          inputCode = $('#author2').val();
          var allData = {'email' : email2, 'id' : id}

          if(id == null || id == ""){ // 아이디를 입력하지 않은 경우
              $('#submit_pw_text').html('아이디를 입력해주세요');
              $('#id').focus();
              return;
          }
          else{ // 아이디를 입력한 경우
              if(email2 == null || email2 == ""){ // 입력한 이메일 없는 경우
                  $('#submit_pw_text').html('이메일 인증을 먼저해주세요');
                  $("#input_email2").focus();
                  return;
              }
              else if(inputCode == null || inputCode == ""){ // 입력한 이메일 없는 경우
                  $('#submit_pw_text').html('인증번호를 입력해주세요');
                  $('#author2').focus();
                  return;
              }
              else{
                  $('#submit_pw_text').html('');
                  if(inputCode == "" || inputCode == null || inputCode != code2){
                      $('#submit_pw_text').html('이메일 인증을 먼저해주세요');
                      return;
                  }
                  else{
                      $('#submit_pw_text').html('');
                      $.ajax({
                          url : 'findpw',
                          data : allData,
                          type : 'post',
                          success : function(nick) {
                              if(nick == 'ok'){ 
                                          //일치하는 정보가 있는 경우 - 리턴값이 ok이면 팝업창을 띄움
                                  $('.popup').css('display', 'block');
                              }
                              else if(nick == 'no'){ //일치하는 정보가 없을 경우
                                  $('#submit_pw_text').html('해당 정보와 일치하는 정보가 없습니다.');
                                  return;
                              }
                              else{ // 잘못된 접근 방지
                                  $('#submit_pw_text').html('잘못된 접근입니다.');
                                  return;
                              }
                          } // success end
                      }); // ajax end
                  }
              }
          }	
      }); //event function end
  }); // function end

  ```

  </details>
   <details>
  <summary> <b>비밀번호 변경 구현 코드</b> </summary>
     
  - 비밀번호 입력란에서 정규표현식으로 유효성 검사를 진행합니다.<br>
  - 정규표현식에 위배되지 않으면 비밀번호 확인란 disabled를 해제해 입력이 가능해집니다.<br>
  - 비밀번호와 비밀번호 확인란이 동일한 상태로 변경을 누르면 해당 정보를 Controller로 전송하고 모달창을 해제합니다.

  ```javascript
  /////////////// 비밀번호 정규표현식, 변경 연결 ///////////
  $(function() {
      //////// 비밀번호 변경 확인  ////////
      $('#pw_checkbtn').click(function(){
          var pw = $('#pw').val(); // 비밀번호 입력값
          var pw_confirm = $('#pw_confirm').val(); // 비밀번호 확인 입력값

          if(pw != null && pw != "" && pw_confirm != null && pw_confirm != ""){ 
          // 비밀번호/비밀번호 확인란에 값이 있는 경우
              if(pw == pw_confirm){ // 비밀번호/비밀번호 확인란의 값이 같은 경우
                  $('#check_result').html('비밀번호가 일치합니다');
                  $('#change_pw').attr('disabled', false);
              }
              else{ // 비밀번호/비밀번호 확인란의 값이 다른 경우
                  $('#check_result').html('비밀번호가 일치하지 않습니다');
                  return;
              }
          }
          else if(pw == null || pw == "" || pw_confirm == null || pw_confirm == ""){ 
          // 비밀번호/비밀번호 확인란에 값이 없는 경우
              $('#check_result').html('비밀번호를 입력해주세요');
              return;
          }
          else{ // 비밀번호/비밀번호 확인란의 값이 다른 경우
              $('#check_result').html('비밀번호가 일치하지 않습니다');
              return;
          }
      }); //event function end

      ///// 비밀번호 변경 창에서의 정규 표현식 - 02.12 김범수 ///////
      $('#pw').blur(function() {
          var pw = $('#pw').val();
          var num = pw.search(/[0-9]/g); // 숫자 정규식
          var eng = pw.search(/[a-z]/ig); // 문자 정규식
          var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi); // 특수문자 정규식

          if(pw.length < 8 || pw.length > 20){ 
              $('#input_regex').html("8자리 ~ 20자리 이내로 입력해주세요.");
              $('#pw_confirm').attr('disabled', true);
              $('#pw').focus();
              return ;
           }else if(pw.search(/\s/) != -1){ 
              $('#input_regex').html("비밀번호는 공백 없이 입력해주세요.");
              $('#pw_confirm').attr('disabled', true);
              $('#pw').focus();
              return ;
           }else if(num < 0 || eng < 0 || spe < 0 ){
              $('#input_regex').html("영문,숫자, 특수문자를 혼합하여 입력해주세요.");
              $('#pw_confirm').attr('disabled', true);
              $('#pw').focus();
              return;
           }else{
               $('#input_regex').html("");
               $('#pw_confirm').attr('disabled', false); // 비밀번호 확인란 disable 해제
           }
      }); //event function end

      /////// 닫기 버튼 클릭 이벤트
      $('.closebtn').click(function() { 
          $('.popup').css('display', 'none');
      }) //event function end

      //////// 비밀번호 찾기 -> 비밀번호 변경 후 DB로 연결  /////
      $('#change_pw').click(function() {
          // 비밀번호 변경한 값을 ajax로 전송 -> 변경 확인 메세지
          var pw = $('#pw').val();
          var pw_confirm = $('#pw_confirm').val();
          var pw_data = {'password' : pw, 'id' : id}
          if(pw != null && pw_confirm != null && pw == pw_confirm){ 
          // 비밀번호 값/비밀번호 확인 값이 null아니고 
          //비밀번호와 비밀번호확인 값이 맞는 경우
              $.ajax({
                  url : 'changepw',
                  type : 'post',
                  data : pw_data,
                  success : function() {
                      alert('비밀번호가 변경되었습니다')
                      $('.popup').css('display', 'none');
                      location.href = 'signin';
                  }
              }); // ajax end
          }
          else{
              alert('비밀번호 변경 실패 : 비밀번호를 확인해주세요');
              return;
          }

      }); // event function end
  }); // function end

  ```

  </details>
  
</details>
	   
<details>
<summary> <b>Controller</b> </summary>

- 이메일 전송 / 아이디 찾기 / 비밀번호 찾기 / 비밀번호 변경으로 나눠져 있습니다

  <details>
  <summary> <b>이메일 전송</b> </summary>

  - 이메일 기능은 smtp 서버를 bean으로 설정하여 JavaMailSender를 호출하여 사용합니다.<br>
  - JS를 통해 사용자의 이메일 정보를 받으면 6자리의 인증번호를 생성합니다.<br>
  - 이메일 양식을 MimeMessageHelper 객체에 담은 후 JavaMailSender 객체를 이용하여 해당 이메일로 메시지를 전송합니.<br>
  - 인증번호는 사용자가 입력한 데이터를 비교하기 위해 JS로 리턴해줍니다.<br>

  ```java
  // 이메일 인증
	@RequestMapping(value="/mailCheck", method = RequestMethod.GET)
	@ResponseBody
	public String mailCheckGET(String email) throws Exception{
		//인증번호 생성(난수)
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111; 
		// checkNum에 랜덤한 인증번호가 담김

		// 이메일 보내기 양식
		String setFrom = "GoottFlex";
		String toMail = email;
		String title = "GoottFlex 이메일 인증 메일 전송입니다.";
		String content = 
			"홈페이지를 방문해주셔서 감사합니다." +
			"<br><br>" + 
			"인증 번호는 " + checkNum + "입니다." + 
			"<br>" + 
			"해당 인증번호를 인증번호 확인란에 기입하여 주세요.";

	  //        setForm : root-context.xml에 삽입한 자신의 이메일 계정의 이메일 주소 
	  //        toMail : 수신받을 이메일 - 뷰로부터 받은 이메일 주소인 변수 email을 사용.
	  //        title : 자신이 보낼 이메일 제목.
	  //        content : 자신이 보낼 이메일 내용.

		try {
			// MimeMessage : 자바 API, 객체를 직접 생성해 메일을 발송하는 것이 가능
			 MimeMessage message = mailSender.createMimeMessage();
		    // MimeMessageHelper : MimeMessage 객체를 활용하여 
							// 멀티파트 메세지를 보내는 것도 가능, 문자 형식 지정 가능
		   MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8"); 
		   // 보낼 내용을 지정하는 MimeMessageHelper의 메소드들
		   helper.setFrom(setFrom);
		   helper.setTo(toMail);
		   helper.setSubject(title);
		   helper.setText(content,true);
		   // 메일 발송
		   mailSender.send(message); 

		}catch(Exception e) {
		    e.printStackTrace();
		}

		// 인증번호를 String 타입으로 변경해서 리턴
		String num = Integer.toString(checkNum); 
			return num;
		}

  ```
    
   ```java
	    <bean id="mailSender" 
					class="org.springframework.mail.javamail.JavaMailSenderImpl">
	      <property name="host" value="smtp.gmail.com" />
	      <property name="port" value="587" />
	      <property name="username" value="rlaqjatn98@gmail.com" />
	      <property name="password" value="xrwdgtlrdjpxfamm" />
	      <property name="javaMailProperties">
					<props>
						<prop key="mail.transport.protocol">smtp</prop>
						<prop key="mail.smtp.auth">true</prop>
						<!-- gmail의 경우 보안문제 업데이트로 인해 SSLSocketFactory를 
						추가해야 smtp 사용 가능. -->
						<prop key="mail.smtp.socketFactory.class">
						javax.net.ssl.SSLSocketFactory</prop>
						<prop key="mail.smtp.starttls.enable">true</prop>
						<prop key="mail.debug">true</prop>
						<prop key="mail.smtp.ssl.trust">smtp.gmail.com</prop>
						<prop key="mail.smtp.ssl.protocols">TLSv1.2</prop>
					</props>
	      </property>
	</bean>
  ```
  </details>
	<details>
	<summary> <b>아이디 찾기</b> </summary>

	- JS에서 가져온 이메일 정보를 통해 해당 사용자의 아이디가 존재하면 리턴해줍니다.<br>
	- 일치하는 정보가 없으면 공백(””)을 리턴합니다.

	```java

		@RequestMapping(value = "findid", method = RequestMethod.POST)
		@ResponseBody
		// email - view단에서 입력된 email을 가져옴
		public String findid(String email, ModelAndView mv) {
			// email을 이용해 해당 email정보를 가진 id값을 가져옴
			String id = userService.findid(email);
			if(id == null) {
				return "";
			}
			else {
				return id;
			}
		}
	```

	</details>
	<details>
	<summary> <b>비밀번호 찾기</b> </summary>
	
	- JS에서 사용자가 입력한 아이디와 이메일 정보를 받아와 dto에 담습니다.  <br>
	- dto에 담긴 아이디와 이메일 정보를 통해 해당 유저의 닉네임을 가져옵니다.<br>
	- 닉네임이 존재하면 ok라는 메세지를 view에 리턴하고, 존재하지 않으면 no를 리턴합니다.

	 ```java
	 @RequestMapping(value = "findpw", method = RequestMethod.POST)
	 @ResponseBody
	 public String findpw(UserDto dto) { // dto에 id와 email 값을 뷰단에서 받아옴
		if(dto.getId() != null && dto.getEmail() != null) {
			String nick = userService.findpw(dto); 
			// dto에 담긴 정보를 토대로 닉네임을 불러옴
			if(nick != null) {
				return "ok"; // ok일시 비밀번호를 바꾸게 할 예정
			}
			else {
				return "no"; // no일시 해당하는 정보가 없다고 메세지 띄움
			}
		}
			return "error";
		}
	```
	</details>
	
  <details>
  <summary> <b>비밀번호 변경</b> </summary>
    
  - 비밀번호 입력란에서 정규표현식으로 유효성 검사를 진행합니다. <br>
  - 정규표현식에 위배되지 않으면 비밀번호 확인란 disabled를 해제해 입력이 가능해집니다. <br>
  - 비밀번호와 비밀번호 확인란이 동일한 상태로 변경을 누르면 해당 정보를 Controller로 전송하고 모달창을 해제합니다.

   ```java
    @RequestMapping(value ="changepw", method = RequestMethod.POST)
    public String changepw(UserDto dto, BCryptPasswordEncoder encoder) {
        dto.setPassword(encoder.encode(dto.getPassword())); // 비밀번호 암호화
        userService.changepw(dto); // 비밀번호 변경
        return "redirect:/user/signin"; // 비밀번호 변경이 끝나면 로그인페이지로 이동시킴
    }	
  ```
    
  </details>

</details>
	   
<details>
<summary> <b>DTO</b> </summary>

- 테이블에 들어 있는 정보를 미리 변수로 생성하고 getter/setter를 설정한 파일입니다.
 
```java 

package com.test.test1.user.dto;

import java.util.Date;

public class UserDto {
	private int user_id, paid_m; //결제 누적 수 paid_m 추가 
	private String id, email, password, nickname, phone_num, subscribe_yn, 
									delete_yn, img; // 유저 프로필 가져오기 위해 img 추가 
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
			+", create_type=" + create_type 
			+ ", paid_m=" + paid_m 
			+ ", img=" + img 
			+ "]";
	}

}
  

```
</details>

<details>
<summary> <b>Service / ServiceImpl</b> </summary>
  

- 아이디 찾기 / 비밀번호 찾기 / 비밀번호 변경으로 나눠져 있습니다


```java 
// Service
// 아이디 찾기
String findid(String email);

// 비밀번호 찾기
String findpw(UserDto dto);

// 비밀번호 변경
void changepw(UserDto dto);

// ServiceImpl
// 아이디 찾기
@Override
public String findid(String email) {
	return userDao.findid(email);
}

// 비밀번호 찾기
@Override
public String findpw(UserDto dto) {
	return userDao.findpw(dto);
}

// 비밀번호 변경
@Override
public void changepw(UserDto dto) {
	userDao.changepw(dto);
}
  
```
</details>
  
<details>
<summary> <b>DAO</b> </summary>
  

- 아이디 찾기 / 비밀번호 찾기 / 비밀번호 변경으로 나눠져 있습니다.
  


```java 
//아이디 찾기 
public String findid(String email) {
	return sqlSessionTemplate.selectOne("user.findid", email);
}

//비밀번호 찾기 
public String findpw(UserDto dto) {
	return sqlSessionTemplate.selectOne("user.findpw", dto);
}

//비밀번호 변경 
public void changepw(UserDto dto) {
	sqlSessionTemplate.selectOne("user.changepw", dto);
}
  
```
</details>
  
<details>
<summary> <b>XML</b> </summary>
  

- 아이디 찾기 / 비밀번호 찾기 / 비밀번호 변경으로 나눠져 있습니다


```xml 
<!-- 아이디 찾기 -->
<!-- 사용자가 입력한 이메일을 통해 ID를 리턴 -->
<select id="findid" resultType="String">
		select ID 
		  from USER
		 where EMAIL = #{email}
</select>

<!-- 비밀번호 찾기 -->
<!-- 사용자가 입력한 이메일과 아이디를 통해 NICKNAME을 리턴 -->
<select id="findpw" resultType="String">
		select NICKNAME
		  from USER
		 where EMAIL = #{email} 
		   and ID = #{id}
	</select>

<!-- 비밀번호 변경 -->
<!-- 암호화로 입력된 패스워드를 해당 사용자의 아이디에 맞게 DB에 저장 -->
<update id="changepw">
		update USER
		   set PASSWORD=#{password}
		 where ID = #{id}
</update>
```
</details>
	   
### 4.4. 내 보관함 기능

![mvc](https://github.com/kim17841/OTTproject/blob/main/Portfolio/mylist.jpg?raw=true)

<details>
<summary> <b>기능 설명</b> </summary>

  - 내 보관함 기능 : 해당 영상에 찜하기 버튼을 클릭하면 영상이 내 보관함 리스트에 담김.

  - 찜하기 아이콘을 다시 클릭하면 내 보관함 리스트에 담긴 해당 영상이 삭제.

 
</details>
  
<details>
<summary> <b>JSP</b> </summary>

  
- DB에서 해당 정보를 리턴 받아와 view로 출력합니다.
```
  (... 생략 ...)
  <!-- 영상페이지에 있는 찜하기 버튼 -> 클릭시 내 보관함 리스트에 영상 추가 -->
  <input type="hidden" id="title_data" value="${dto.title}">
  <!-- 찜하기 버튼 value -->
  <c:set var="rental_id" value="${rental_id}"/>
  <c:choose>
      <c:when test="${rental_id ne null}"> <!-- rental_id가 null값이 아닐 경우 -->
          <i class="fas fa-heart comu_btn" id="subscribe"></i>
      </c:when>
      <c:otherwise> <!-- rental_id가 null일 경우 -->
          <i class="far fa-heart comu_btn" id="subscribe"></i>
      </c:otherwise>
  </c:choose>
  <p>찜하기</p>
  (... 생략 ...)

  <!-- 내 보관함 리스트 영역-->
  <div class="section">
        <!-- 내 보관함 text -->
        <div><h1 class="mylocker_text">내보관함</h1></div>
        <!-- 내 보관함 슬라이드 - 양옆 버튼 추가, 슬릭 기능 -->
        <div class="slider">
           <!-- 내보관함 리스트 출력 영역-->
           <c:forEach var="movie" items="${dto}">
              <div class="video_div">
                 <a href="/video/detail?video_id=${movie.video_id}"> 
			<img src="${movie.image_url}" alt="Image not found"></a>
              </div> 
           </c:forEach>

        </div>
     </div>
```
</details>
	  
<details>
<summary> <b>Javascript</b> </summary>

- 찜하기 버튼을 누르면 아이콘 변경 후 보관함에 담기 / 삭제를 합니다.
- 찜한 영상은 내 페이지에 접속하면 영상 리스트가 나옵니다
  <details>
  <summary> <b>찜하기 버튼 구현 코드</b> </summary>

  ```javascript
	// 찜하기 버튼 클릭 이벤트
	const comu_btn = document.querySelectorAll('.comu_btn'); 
	comu_btn[0].addEventListener('click', function(){ // 찜하기 버튼 클릭 이벤트
		let title = $('#title_data').val(); // 찜하기 버튼 value 
	    if(this.className.includes('fas')){ // 내보관함에서 삭제
		$.ajax({ // 내보관함에서 삭제
			url : 'mylocker_de',
			type : 'post',
			data : {'title' : title},		
		})
		this.className = 'far fa-heart comu_btn';
		alert('내보관함에서 삭제되었습니다');

	    }else { // 내보관함에 담기
		$.ajax({
			url : 'mylocker_in',
			type : 'post',
			data : {'title' : title},
		})
		this.className = 'fas fa-heart comu_btn';
		alert('내보관함에 담겼습니다');
	    }
	});

  ```

  </details>

	
  <details>
  <summary> <b>슬라이드 기능</b> </summary>

  ```javascript
  // 슬릭 이벤트
	$(function(){
		(...생략...)
		$(".slider").not('.slick-initialized').slick({
			slidesToShow:6,
			slidesToScroll:6,    
			prevArrow: "<button type='button' class='slick-arrow'><i class='fa-solid fa-angle-left'></i></button>",
			nextArrow: "<button type='button' class='slick-next'><i class='fa-solid fa-angle-right'></i></button>",
		});
	})
  ```

  </details>
  
</details>
	   
<details>
<summary> <b>Controller</b> </summary>

- JS로 받은 정보를 통해 사용자의 아이디와 해당 영상의 아이디를 불러와 DB에 전달합니다.
- 추가 / 삭제가 이루어지면 각각의 다른 결과를 view단으로 리턴합니다.

  <details>
  <summary> <b>찜하기 버튼</b> </summary>

  ```java
  // 내 보관함 기능 구현 - 찜하기 버튼
	@RequestMapping(value = {"mylocker_in", "mylocker_de"}, method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView mylocker(String title, RentalDTO dto, HttpSession session, 
					HttpServletRequest request, ModelAndView mv) throws Exception{
		String requestUrl = request.getRequestURL().toString(); 
		// mylocker_in와 mylocker_de의 매핑을 다르게 받기 위해 사용
		String id = (String) session.getAttribute("user_id");
		int video_id = videoService.getid(title); 
		// 비디오 제목을 가져가 비디오 아이디를 가져오는것
		if(id == null) { // 로그인 상태가 아닌 경우 / 세션 유지 시간이 만료된 경우
			mv.setViewName("redirect:/user/signin");
		}
		
		if(requestUrl.contains("mylocker_in")) { // 내 보관함 담기
			dto.setVideo_id(video_id);
			dto.setId(id);
			rentalService.insert(dto);
			String rental_id = rentalService.getid(dto);
			// 영상 ID와 유저 ID를 담은 rental_id를 영상메인페이지로 리턴 
			mv.addObject("rental_id",rental_id); 
			mv.setViewName("video/detail");
		}
		else { // 내 보관함 삭제
			dto.setId(id);
			dto.setVideo_id(video_id);
			rentalService.delete(dto);
			String rental_id = rentalService.getid(dto);
			mv.addObject("rental_id",rental_id);
			mv.setViewName("video/detail");
		}		
		return mv;	
	}

  ```
    
   ```java
	// 찜하기 아이콘 유지
	public ModelAndView detail(@RequestParam int video_id, ModelAndView mv, 
				HttpSession session, RentalDTO dto) {
		dto.setId(id); // dto에 저장
		String rental_id = rentalService.getid(dto);// rental id를 가져오는 것
		mv.addObject("rental_id",rental_id);
		mv.setViewName("video/detail");
		return mv;
	}
  ```
   
  </details>
  <details>
  <summary> <b>보관함 리스트 구현</b> </summary>

   ```java
	  public ModelAndView detail(HttpSession session, ModelAndView mv) {
		String user_id =(String) session.getAttribute("user_id").toString(); 
		// 세션에서 사용자의 아이디를 가져옴
		List<VideoDto> list = rentalService.list(user_id); 
		// 해당 아이디에 저장된 비디오 리스트를 가져오기 위함
		mv.addObject("dto", list);
		mv.setViewName("mypage/mydetail");
		return mv;
	}
   ```

  </details>

</details>
	
<details>
<summary> <b>DTO</b> </summary>

- 테이블에 들어 있는 정보를 미리 변수로 생성하고 getter/setter를 설정한 파일입니다.
 
```java 
// VideoDTO
package com.test.test1.video.dto;

import java.util.Date;

public class VideoDto {
	private String title, video_url, image_url, summary, create_country, 
									grade, actor, genre_id, create_year;
	private int video_id, recommand, category_id;
	private Date upload_date;
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getVideo_url() {
		return video_url;
	}
	
	public void setVideo_url(String video_url) {
		this.video_url = video_url;
	}
	
	public String getImage_url() {
		return image_url;
	}
	
	public void setImage_url(String image_url) {
		this.image_url = image_url;
	}
	
	public String getSummary() {
		return summary;
	}
	
	public void setSummary(String summary) {
		this.summary = summary;
	}
	
	
	public String getGrade() {
		return grade;
	}
	
	public void setGrade(String grade) {
		this.grade = grade;
	}
	
	public String getGenre_id() {
		return genre_id;
	}
	
	public void setGenre_id(String genre_id) {
		this.genre_id = genre_id;
	}	
	
	public String getActor() {
		return actor;
	}
	
	public void setActor(String actor) {
		this.actor = actor;
	}	
	
	public int getVideo_id() {
		return video_id;
	}

	public void setVideo_id(int video_id) {
		this.video_id = video_id;
	}
	
	public String getCreate_year() {
		return create_year;
	}
	
	public void setCreate_year(String create_year) {
		this.create_year = create_year;
	}
	
	public int getRecommand() {
		return recommand;
	}
	
	public void setRecommand(int recommand) {
		this.recommand = recommand;
	}	
	
	public int getCategory_id() {
		return category_id;
	}
	
	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}

	public Date getUpload_date() {
		return upload_date;
	}

	public void setUpload_date(Date upload_date) {
		this.upload_date = upload_date;
	}

	public String getCreate_country() {
		return create_country;
	}

	public void setCreate_country(String create_country) {
		this.create_country = create_country;
	} 
	
	@Override
	public String toString() {
		return "VideoDto [title = " + title
			+ ", video_url = " + video_url
			+ ", image_url = " + image_url
			+ ", summary = " + summary
			+ ", country = " + create_country
			+ ", grade = " + grade
			+ ", actor = " + actor
			+ ", genre_id = " + genre_id
			+ ", video_id = " + video_id
			+ ", create_year = " + create_year
			+ ", recommand = " + recommand
			+ ", category_id = " + category_id 
			+ "]";
	}
	
}
```
```java 
// RentalDTO
package com.test.test1.video.dto;

import java.util.Date;

public class RentalDTO {
	
	private String id;
	private int video_id;
	private Date rental_date;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getVideo_id() {
		return video_id;
	}

	public void setVideo_id(int video_id) {
		this.video_id = video_id;
	}
	
	public Date getRental_date() {
		return rental_date;
	}

	public void setRental_date(Date rental_date) {
		this.rental_date = rental_date;
	}
	
	@Override
	public String toString() {
		return "rentalDTO[id = " + id 
			+ ", video_id = " + video_id 
			+ ", rental_date = " + rental_date 
			+ "]";
	}
}
```
</details>
	
<details>
<summary> <b>Service / ServiceImpl</b> </summary>
  

- Controller로 받은 데이터를 DAO로 전달합니다.


```java 
// 찜하기 버튼 기능 Service / ServiceImpl
// service
public interface RentalService {

	void insert(RentalDTO dto);

	void delete(RentalDTO dto);
}
  
//ServiceImpl
@Service
public class RentalServiceImpl implements RentalService{
	
	@Inject
	RentalDao rentalDao;

	@Override
	public void insert(RentalDTO dto) {
		rentalDao.insert(dto);
	}

	@Override
	public void delete(RentalDTO dto) {
		rentalDao.delete(dto);
	}

}

```
  
```java 
// 보관함 리스트 기능 Service / ServiceImpl
// Service
public interface RentalService {

	List<VideoDto> list(String user_id);

}
  
// ServiceImpl
@Service
public class RentalServiceImpl implements RentalService{
	
	@Inject
	RentalDao rentalDao;

	@Override
	public List<VideoDto> list(String user_id) {
		return rentalDao.list(user_id);
	}

}

```
</details>
  
<details>
<summary> <b>DAO</b> </summary>
  

- Service에서 전달 받은 데이터를 XML로 전달합니다.
  


```java 
// 찜하기 기능 구현 DAO
@Repository
public class RentalDao {
	
	@Inject
	SqlSession sqlSession;

	// rental_id를 입력
	public void insert(RentalDTO dto) {
		sqlSession.insert("rental.insert", dto);
	}

	// rental_id를 삭제
	public void delete(RentalDTO dto) {
		sqlSession.delete("rental.delete", dto);
	}

}
  
```
  
```java 
// 보관함 리스트 구현 DAO
@Repository
public class RentalDao {
	
	@Inject
	SqlSession sqlSession;

	// 해당 사용자가 찜한 영상을 불러오는 것
	public List<VideoDto> list(String user_id) {
		return sqlSession.selectList("rental.list", user_id);
	}

}
  
```
</details>
  
<details>
<summary> <b>XML</b> </summary>

- DAO에서 전달 받은 데이터로 쿼리문을 통해 내 보관함 데이터를 추가/삭제합니다.
- 보관함 리스트는 VIDEO_DTO를 통해 영화 제목/이미지 URL 등 데이터를 view단으로 반환하여 영상 리스트를 출력합니다.


```xml 
<!-- 찜하기 기능 구현 XML -->
<!-- 찜하기 -->
<insert id="insert">
	insert into RENTAL(USER_ID, VIDEO_ID)
	values((select USER_ID from USER where ID = "${id}"), #{video_id})
</insert>

<!-- 찜 제거-->
<delete id="delete">
	<![CDATA[
	delete from RENTAL
	 where USER_ID = (select USER_ID from USER where ID = "${id}")
		 and VIDEO_ID = #{video_id}
	]]>
</delete>
```
  
```xml 
<!-- 보관함 리스트 구현 XML -->
<select id="list" resultType="com.test.test1.video.dto.VideoDto">
	<![CDATA[
	select distinct v.VIDEO_ID, v.TITLE, v.IMAGE_URL, v.VIDEO_URL
    from VIDEO v 
    left join RENTAL r
		  on v.VIDEO_ID = r.VIDEO_ID
		left join USER u
		  on r.USER_ID = u.USER_ID
	 where u.USER_ID = (select USER_ID from USER where ID = "${user_id}")
	]]>
</select>
```
</details>

	
### 4.5. 내 프로필 업로드 기능

![mvc](https://github.com/kim17841/OTTproject/blob/main/Portfolio/profile.jpg?raw=true)
![mvc](https://github.com/kim17841/OTTproject/blob/main/Portfolio/nav.jpg?raw=true)

<details>
<summary> <b>기능 설명</b> </summary>

  - 프로필 변경버튼을 누르면 파일 선택이 진행되어 사용자가 선택한 이미지로 프로필이 바뀜.

  - 변경된 프로필은 사용자가 로그인하는 동안에 다른 페이지에서도 상단에 이미지가 유지.

</details>
  
<details>

  <summary> <b>JSP</b> </summary>

  
- 사용자가 프로필을 변경하면 JS를 통해 form태그에 해당 이미지를 Controller로 전송합니다.
- 사용자가 설정해 놓은 이미지가 없을 경우 기본 이미지를 출력합니다.
- 설정한 이미지가 있을 경우 내 페이지와 다른 페이지 상단에 프로필 이미지를 출력합니다.
- 사용자가 영상에 댓글을 남기면 설정한 프로필이 나옵니다.

  <details>
    <summary> <b>네비바 이미지 출력</b> </summary>

 
    ```
    <!-- 상단에 프로필 이미지 출력 -->
    (...생략...)
    <c:choose>
        <!-- 사용자가 변경한 이미지가 있을 경우 -->
        <c:when test="${img != null && img != ''}">
            <img src="${img}" id="img_onload" class="img_tag"> 
        </c:when>
        <!-- 사용자가 변경한 이미지가 없을 경우 -->
        <c:when test="${img == null}">
            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxmp7sE1ggI4
            _L7NGZWcQT9EyKaqKLeQ5RBg&usqp=CAU" class="img_tag">
        </c:when>
    </c:choose>
    (...생략...)
    ```

  </details>
    <details>
    <summary> <b>프로필 이미지 등록/변경</b> </summary>

    
    ```
    <!-- 내 페이지 프로필 변경-->
    (... 생략...)
    <div class="left-side">
    <!-- 프로필 기능 -->
        <c:choose>
            <!-- 사용자가 설정한 이미지가 있을 경우 -->
            <c:when test="${data.img != null && data.img != ''}">
                <img src="${data.img}" id="img_onload" class="img_tag"> 
            </c:when>
            <!-- 사용자가 설정한 이미지가 없을 경우 - 기본이미지 -->
            <c:when test="${data.img == null}">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxmp7sE1gg
                I4_L7NGZWcQT9EyKaqKLeQ5RBg&usqp=CAU" class="img_tag">
            </c:when>
        </c:choose>
        <!-- 프로필 변경 버튼 - input type을 display : none하고 label로 연결 -->
        <div class="input_file_box">
            <label class="input_button" for="uploadFile">프로필 변경</label>
            <input type="file" name='uploadFile' id="uploadFile">
        </div>
    </div>
    (... 생략...)
    ```

  </details>
  
     <details>
    <summary> <b>댓글 프로필 출력</b> </summary>

    
    ```
    <!-- 내 페이지 프로필 변경-->
    (... 생략...)
    <div class="left-side">
  <!-- 댓글에 사용자의 프로필 이미지 출력 -->
  <div class="user_img_area">
      <c:choose>
          <!-- 컨트롤러에서 리턴한 이미지를 받고 ready를 통해 함수 호출 -> 이미지 출력 -->
          <c:when test="${comt.img != null && comt.img != ''}">
              <img src="${comt.img}" class="com_img">
          </c:when>
          <c:when test="${comt.img == null}">
              <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxmp7sE1gg
              I4_L7NGZWcQT9EyKaqKLeQ5RBg&usqp=CAU" class="default_img">
          </c:when>
      </c:choose>
  </div>
    ```
  </details>

</details>

<details>
<summary> <b>Javascript</b> </summary>

- 사용자가 파일 선택을 진행하면 해당 파일이 이미지인지 검사 후에 AJAX로 Controller에 전달을 진행합니다.
- ResponseEntity로 반환 받은 이미지 경로를 encoding해서 쿼리스트링으로 display 메소드를 호출, 이미지를 출력합니다.
- 위와 같은 방식으로 네비바, 댓글에도 이미지를 상시 출력합니다.
  <details>
  <summary> <b>네비바 이미지 출력</b> </summary>

  ```javascript
	// 네비바 이미지 로딩 위한 함수
	$(function() {
		$('.img_tag').ready(function() {
			$.ajax({
				url : '/user/navbarImg2',
				dataType : 'text',
				success : function(result2) {
					if(result2 == "" || result2 == null){return}
					let fileCallPath = encodeURI(result2); // 해당 파일의 이름
					$('.img_tag').attr('src', "/mypage/display?fileName=" + fileCallPath);
				}
			});
		})
	});

	  ```

	  </details>
	  <details>
	  <summary> <b>프로필 이미지 등록/변경</b> </summary>

	  ```javascript
	//파일 선택 후 이미지인지 점검 -> ajax로 Controller에 전송
	$(function() {
		$("input[type='file']").on("change", function(e){
			// formData 객체 선언 - 이미지 파일을 전송하기 위함
			let formData = new FormData();
			// 사용자가 선택한 파일
			let fileInput = $('input[name="uploadFile"]'); 
			let fileList = fileInput[0].files; // 첫번째 선택한 파일
			let fileObj = fileList[0]; // 파일 객체

			// 이미지인지 파일 체크, 용량 체크 
			if(!fileCheck(fileObj.name, fileObj.size)){
				return false;
			}

			// formData 객체에 해당 파일 추가(uploadFile로 이름 설정)
			formData.append("uploadFile", fileObj); 

			$.ajax({
				url: '/mypage/upload',
		    processData : false,
		    contentType : false,
		    data : formData, 
		    type : 'POST',
		    dataType : 'json', // 제이슨타입으로 formData를 전달
		    success : function(result) {
					showUploadImage(result);  //이미지 출력 함수
				},
		    error : function(result){
			alert("이미지 파일이 아닙니다.");
		    }
			});
		});
	});

	  // 이미지인지 파일 체크, 용량 체크 
	  function fileCheck(fileName, fileSize){
	      let regex = new RegExp("(.*?)\.(jpg|png)$"); 
	      let maxSize = 1048576; //1MB

	      if(fileSize >= maxSize){ // 파일 사이즈 검사
		  alert("파일 사이즈 초과");
		  return false;
	      }

	      if(!regex.test(fileName)){ // 이미지가 아닌 파일 잡는것
		  alert("해당 종류의 파일은 업로드할 수 없습니다.");
		  return false;
	      }
	      return true;		
	  }

	  //이미지 등록후 프로필을 출력하기 위한 함수
	  function showUploadImage(result){
	      // 전달받은 데이터가 값이 없는 경우
	      if(result == "" || result == null){return} 
	      // fileCallPath에 리턴받은 해당 이미지 경로를 encoding
	      let fileCallPath = encodeURI("C:\\upload\\"+result.uploadPath + result.uuid + 
	      "_" + result.fileName); // 해당 파일의 이름
	      // src 경로 값으로 쿼리스트링과 encoding한 이미지 경로를 설정 
	      // -> display 메소드 호출하면서 파라미터 fileName의 값을 encoding한 
	      // 이미지 경로를 부여
	      $('.img_tag').attr('src', "/mypage/display?fileName=" + fileCallPath);
	  }

	  //이미지 상시 출력을 위한 함수 
	  $(function() {
	      $("#img_onload").ready(function(){
		  let formData = new FormData();
		  // fileInput : 이미지 태그의 src값 
		  // - Controller에서 리턴한 이미지의 절대 경로를 담고 있음
		  let fileInput = $('#img_onload').attr('src');
		  // formData 객체에 해당 파일 추가(uploadFile로 이름 설정) 
		  formData.append("uploadFile", fileInput); 

		  $.ajax({
		      url: '/mypage/onload',
		  processData : false,
		  contentType : false,
		  data : formData, 
		  type : 'POST',
		  dataType : 'text', 
		      // 제이슨타입으로 formData를 전달 - ResponseEntity 타입이 String이기 때문
		  success : function(result) {
			  showOnloadImage(result);  //이미지 상시 출력 메서드
		      },
		  error : function(result){
			  alert("이미지 파일이 아닙니다.");
		  }
		  });
	      });
	  });

	  //이미지 로딩 위한 함수
	  function showOnloadImage(result){
	      // 전달받은 데이터가 값이 없는 경우
	      if(result == "" || result == null){return}
	      let fileCallPath = encodeURI(result); // 이미지 절대 경로를 encoding
	      $('#img_onload').attr('src', "/mypage/display?fileName=" + fileCallPath);
	  }

  ```

  </details>
   <details>
  <summary> <b>댓글 이미지 출력</b> </summary>

  ```javascript
  // 원댓글 이미지 출력
  $(function() {
      $('.com_img').ready(function() {
          let fileInput = document.querySelectorAll('.com_img');
          for(let i = 0; i < fileInput.length; i++){
              let formData = new FormData();
              formData.append("uploadFile", fileInput[i].currentSrc);
              $.ajax({
                  url: '/mypage/onload',
              processData : false,
              contentType : false,
                  data : formData,
              type : 'POST',
                  dataType : 'text',
                  success : function(result2) {
                      if(result2 == "" || result2 == null){return}
                      let fileCallPath = encodeURI(result2); // 해당 파일의 이름
                      fileInput[i].src = "/mypage/display?fileName=" + fileCallPath;
                  }
              });
          }
      })
  });

  // 대댓글 이미지 출력
  function imgOnload() {
      $('.cocom_img').ready(function() {
          let fileInput = document.querySelectorAll('.cocom_img');
          for(let i = 0; i < fileInput.length; i++){
              let formData = new FormData();
              formData.append("uploadFile", fileInput[i].currentSrc);
              $.ajax({
                  url: '/mypage/onload',
              processData : false,
              contentType : false,
                  data : formData,
              type : 'POST',
                  dataType : 'text',
                  success : function(result2) {
                      if(result2 == "" || result2 == null){return}
                      let fileCallPath = encodeURI(result2); // 해당 파일의 이름
                      fileInput[i].src = "/mypage/display?fileName=" + fileCallPath;
                  }
              });
          }
      });
  }

  // 대댓글 형성후 - 이미지 로딩
  (... 생략...)
  cocomText += "<tr>";
      if(this.img != null && this.img != '') {
          cocomText += "<td class='cocom_title text'>"
          cocomText += "	<div class='user_img_area'>"
          cocomText += "		<img src='" + this.img + "' class='cocom_img'>"
          cocomText += "	</div>"
      }
      else {
          cocomText += "<td class='cocom_title text'>"
          cocomText += "	<div class='user_img_area'>"
          cocomText += "		<img src='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxmp7sE1ggI4_L7NGZWcQT9EyKaqKLeQ5RBg&usqp=CAU' 
              				class='img_tag2'>"
          cocomText += "	</div>"
      }
  (... 생략...)
  cocomText += "</td>"
  (... 생략...)
  imgOnload();

  ```

  </details>
  
</details>

<details>
<summary> <b>Controller</b> </summary>

- 프로필 이미지를 경로, 날짜, uuid를 설정하고, 파일 명에 합쳐 Service에 전달합니다.
- upload 메소드 : 경로 설정을 끝낸 이미지 파일을 ResponseEntity 객체로 변환하여 리턴합니다.
- display 메소드 : 경로가 부여된 이미지 파일을  깊은 복사를 한 후 헤더 설정과 HTTP 상태 코드를  ResponseEntity 객체에 담아 리턴하여 이미지를 view에 출력합니다.
- onload 메소드 : 절대 경로가 담긴 이미지 파일을 ResponseEntity 객체에 HTTP 상태 코드를 같이 담아서 리턴합니다.
- 네비바 이미지 출력은 onload 메소드처럼 리턴한 후 display메소드를 호출해 이미지를 출력한다.

  <details>
  <summary> <b>네비바 이미지 출력</b> </summary>

  ```java
	// 네비바 프로필 이미지 호출
	@RequestMapping(value={"navbarImg1", "navbarImg2"}, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> navbarImg(HttpSession session, UserDto dto, 
					HttpServletRequest request) {
		String requestUrl = request.getRequestURL().toString(); 
		// 매핑값마다 실행되는 코드를 다르게 하기 위해 HttpServletRequest 객체로 매핑 조정
		if(requestUrl.contains("navbarImg1")) { // 네비바1에서의 프로필 로딩
			String id =(String) session.getAttribute("user_id").toString();
			String img = userService.navbarImg(id); 
			// 아이디 정보를 통해서 해당 사용자의 프로필 경로를 받아옴
			// 이미지 값을 ResponseEntity로 변환
			// -> 프로필 이미지 절대 경로와 HTTP 상태 코드를 객체에 넣음
			ResponseEntity<String> result1 = new ResponseEntity<String>(img, HttpStatus.OK); 
			return result1;
		}
		else { // 네비바2에서의 프로필 로딩
			String id =(String) session.getAttribute("user_id").toString();
			String img = userService.navbarImg(id);
			ResponseEntity<String> result2 = new ResponseEntity<String>(img, HttpStatus.OK);
			return result2;
		}
	}

  ```

  </details>

  <details>
  <summary> <b>프로필 이미지 등록/변경</b> </summary>

   ```java

	  // 프로필 등록
	  @RequestMapping(value="upload", produces = MediaType.APPLICATION_JSON_VALUE)
	  public ResponseEntity<ImgDto> test(MultipartFile uploadFile, ImgDto dto, HttpSession session, ModelAndView mv) { 
	      // 세션에 저장된 사용자의 아이디 변수 id에 저장
	      String id = (String) session.getAttribute("user_id"); 

	      // 이미지 파일 체크
	      File checkfile = new File(uploadFile.getOriginalFilename()); // 파일명을 불러옴
	      String type = null;
	      try {
		  type = Files.probeContentType(checkfile.toPath()); 
		  // 해당 파일의 확장자를 불러옴, 확장자가 없으면 type은 null값을 반환
	      } catch (IOException e) {
		  e.printStackTrace();
	      }
	      // Date 객체로 날짜 경로 만들기 
	      // - 하나의 파일에 파일이 많아지면 데이터 관리에 부담이 생김		
	      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-"); 
	      // 뒤에 '-'을 더 붙인 이유 : 날짜와 파일명을 구분하기 위함
	      Date date = new Date();
	      String str = sdf.format(date); // yyyy-MM-dd 형식으로 날짜가 들어감
	      // '-'를 separator(파일 구분자)로 나눠 놓음 
	      // -> 2023 - 02 - 24 형식으로 폴더를 만들기 위함
	      String datePath = str.replace("-", File.separator);  

	      String uploadFolder = "C:\\upload\\"; // 처음 경로 설정
	      File uploadPath = new File(uploadFolder, datePath); 
	      // 파일 생성 클래스 -> 파일 객체 생성

	      if(uploadPath.exists() == false) { // 해당 경로에 파일이 없으면 파일 생성
		      uploadPath.mkdirs();
	      }

	      // 파일 이름
	      String uploadFileName = uploadFile.getOriginalFilename();
	      dto.setFileName(uploadFileName);
	      dto.setUploadPath(datePath);

	      // uuid적용한 파일 이름
	      String uuid = UUID.randomUUID().toString(); 
	      // uuid 생성, 파일을 구분하는 키값을 생성하기 위함
	      uploadFileName = uuid + "_" + uploadFileName;
	      dto.setUuid(uuid);

	      String saveFilestr = uploadPath + uploadFileName;
	      File saveFile = new File(uploadPath, uploadFileName); 

	      try {
		  uploadFile.transferTo(saveFile); // saveFile을 저장
		  dto.setSaveFileStr(saveFilestr);
		  dto.setId(id);
		  userService.img_update(dto); 
		  // 해당 사용자의 아이디에 프로필 이미지 경로를 등록하기 위함
	      } catch (IOException e) {
		  e.printStackTrace();
	      }

	      // ResponseEntity 객체로 HTTP 상태 코드와 이미지 경로를 저장
	      ResponseEntity<ImgDto> result = new ResponseEntity<ImgDto>(dto, 
	      HttpStatus.OK); 

	      return result;		
	  }

	  // 이미지 출력 메소드
	  @RequestMapping(value = "display")
	  public ResponseEntity<byte[]> display(String fileName) 
			  throws FileNotFoundException { // 이미지 파일을 바이트 배열로 받아옴

	      File file = new File(fileName);
	      if (!file.exists() || !file.canRead()) { // 파일이 없는 경우
		  throw new FileNotFoundException("The file '" + fileName + "' 을 찾을수 없습니다.");
	      }
	      ResponseEntity<byte[]> result = null; // ResponseEntity 객체 초기화

	      try {
		  HttpHeaders header = new HttpHeaders(); // HttpHeaders 객체 생성
		  header.add("Content-type", Files.probeContentType(file.toPath())); 
		  // 헤더 객체에 Content-type을 파일 확장자로 설정 
		  // ResponseEntity 객체에 이미지 바이트 배열화된 파일 복사한 것과  
		  // HttpHeaders 객체, HTTP 상태 코드를 담음
		  result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, 
		  HttpStatus.OK);
	      } catch (IOException e) {
		  e.printStackTrace();
	      }
	      return result;
	  }

	  // 프로필 상시 
	  @RequestMapping(value="onload", produces = MediaType.APPLICATION_JSON_VALUE)
	  public ResponseEntity<String> onload(String uploadFile) { 
	      // 절대 경로로 된 이미지를 HTTP 상태 코드와 함께  ResponseEntity 객체에 담음
	      ResponseEntity<String> result = new ResponseEntity<String>(uploadFile, 
	      HttpStatus.OK);
	      return result;		
	  }
   ```

  </details>


</details>
	  
<details>
<summary> <b>DTO</b> </summary>

- 테이블에 들어 있는 정보를 미리 변수로 생성하고 getter/setter를 설정한 파일입니다.
 
```java 

package com.test.test1.mypage.dto;

public class ImgDto {

	/* 경로 */
	private String uploadPath;
	
	/* uuid */
	private String uuid;
	
	/* 파일 이름 */
	private String fileName;
	
	private String saveFilestr;
	
	private String id;
	

	public String getUploadPath() {
		return uploadPath;
	}

	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getSaveFile() {
		return saveFilestr;
	}

	public void setSaveFileStr(String saveFilestr) {
		this.saveFilestr = saveFilestr;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "ImagDto [uploadPath=" + uploadPath 
			+ ", uuid=" + uuid 
			+ ", fileName=" + fileName 
			+ ", saveFilestr=" + saveFilestr 
			+ ", id=" + id 
			+"]";
	}
}
  

```
</details>

<details>
<summary> <b>Service / ServiceImpl</b> </summary>
  

- Controller로 받은 데이터를 DAO로 전달합니다.


```java 
// 네비바 이미지 출력 기능 Service / ServiceImpl
// Service
public interface UserService {
	String navbarImg(String id);

}

// ServiceImpl
@Service
public class UserServiceImpl implements UserService{
	
	@Inject
	UserDao userDao;

	@Override
	public String navbarImg(String id) {
		return userDao.navbarImg(id);
	}
}

```
  
```java 
// 프로필 이미지 등록/변경 기능 Service / ServiceImpl
// Service
public interface UserService {
	void img_update(ImgDto dto);

}

// ServiceImpl
@Service
public class UserServiceImpl implements UserService{
	
	@Inject
	UserDao userDao;

	@Override
	public void img_update(ImgDto dto) {
		userDao.img_update(dto);
	}
}

```
</details>
	  
<details>
<summary> <b>DAO</b> </summary>
  

- Service에서 전달 받은 데이터를 XML로 전달합니다.
  


```java 
// 네비바 이미지 출력 기능 구현 DAO
@Repository
public class UserDao {
	
	@Inject
	SqlSessionTemplate sqlSessionTemplate;
	
	public String navbarImg(String id) {
		return sqlSessionTemplate.selectOne("user.navbarImg" , id);
	}
}
  
```
  
```java 
// 프로필 이미지 등록/변경 기능 구현 DAO
@Repository
public class UserDao {
	
	@Inject
	SqlSessionTemplate sqlSessionTemplate;
	
	public void img_update(ImgDto dto) {
		sqlSessionTemplate.selectOne("user.img_update" , dto);
	}
}
  
```
</details>
  
<details>
<summary> <b>XML</b> </summary>
  

- DAO에서 전달 받은 데이터로 쿼리문을 통해 프로필 이미지 경로를 등록하거나 리턴합니다.

  <details>
    <summary> <b>네비바 이미지 출력</b> </summary>

    - 해당 사용자의 프로필 이미지 경로를 아이디 정보를 통해 불러옵니다.
 
    ```xml 
    <!-- 네비바 이미지 출력 기능 xml -->
    <select id="navbarImg" resultType="String">
            <![CDATA[
            select IMG
              from USER
             where ID=#{user_id}
            ]]>
    </select>
    ```
 
  </details>
    <details>
    <summary> <b>프로필 이미지 등록/변경</b> </summary>

    - 이미지 경로를 해당 사용자의 정보에 저장합니다.<br>
    - 변경을 할 때에도 위와 같은 방법으로 저장이 이루어집니다. 
 
    ```xml 
    <!-- 프로필 이미지 등록/변경 기능 xml -->
    <update id="img_update">
      update USER
             set IMG = #{saveFilestr}
         where ID = #{id}
    </update>
    ```
 
  </details>

</details>
</details>

## 5. 핵심 트러블 슈팅

### 5.1. **비디오 스트리밍 방법에 대한 문제**
- 처음 개발 시 DB에 저장된 비디오 경로를 ejs파일에 \<video> 태그안에 직접 구현하여 비디오 파일을 바로 불러올 수 있도록 처리 
- 데이터가 큰 비디오 파일을 불러올 시 한번에 데이터를 다 불러온 다음 실행되기 때문에 클라이언트, 서버 모두 데이터 처리 비용 소모가 큼

#### 해결방법
- fs(file system)모듈을 활용한 stream 을 사용하여 해결 
- 해당 모듈을 사용하여 stream을 할 경우 데이터를 모듈화하여 보내기 때문에 클라이언트, 서버 모두 데이터 처리 효율 향상
- [코드확인](#4-구현-기능-핵심-코드)

