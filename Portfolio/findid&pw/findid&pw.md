
### 아이디/비밀번호 찾기 기능 구현

![mvc](https://github.com/kim17841/OTTproject/blob/main/Portfolio/findid%26pw.jpg?raw=true)

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
