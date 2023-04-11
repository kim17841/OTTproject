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

## 4. 구현 기능 핵심 코드 
<details>
<summary><b>구현 기능 설명 펼치기</b></summary>
<div markdown="1">

### 4.1. 전체 흐름

![mvc](https://github.com/WonJae0914/secondProject/blob/main/portflio/img/MVC%EC%A0%84%EC%B2%B4%ED%9D%90%EB%A6%84.png?raw=true)

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
