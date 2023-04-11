<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/user/user_find_id.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css"/>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<script src="/resources/js/user/user_find_id.js"></script>
</head>
<body>
	<!-- 로고 영역 -->
	<header>
		<%@ include file="/WEB-INF/views/common/navbar1.jsp" %>
	</header>
	
	<section>
	<!-- 로그인 창 영역 -->
		<div class="section_loginform">
			<span class="login">Fine ID</span>         
			<form>
				<div>
					<!-- 사용자의 이메일을 입력받음 -->
					<div class="input_text">
						<input type="email" name="email" placeholder="Email" autocomplete="off" 
						class="input_size" id="input_email1">
					</div>
					<div>
						<!-- 이메일 인증 버튼 -->
						<button class="email_checkbtn" id="emailchk1">EA</button>
	
						<!-- 이메일 인증 상태 메세지 -->
						<span id="email_text1" class="formSpans"></span> 
						<br>
						<!-- 0209 인증번호 입력 / 확인버튼 추기 -->
						<!-- 이메일로 받은 인증번호를 사용자가 입력-->
						<input type="text" placeholder="Certification number input" autocomplete="off" 
						class="authorkey" id="author1" maxlength="6">
						<!-- 인증번호 발급해준 것과 사용자 입력값 비교 -->
						<button class="key_submit" id="author_submit1">Check</button>
					</div>
					<!-- 최종적으로 인증을 끝낸 후 아이디를 찾기  -->
					<input type="button" value="Find ID" class="login_submit_id">
					<br>
					<!-- 아이디 찾기 상태 메세지  -->
					<span id="submit_id_text" class="formSpans"></span>                    
				</div> 
			</form>
			<!-- 구분선  -->
			<span class="division_line"></span> 
	
	
			<span class="login">find password</span> 
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
						<!-- 이메일 인증 -->
						<button class="email_checkbtn" id="emailchk2">EA</button>
						<!-- 이메일 인증 상태 확인 메세지 -->
						<span id="email_text2" class="formSpans"></span> 
						<br>
						<!-- 이메일로 받은 인증번호를 사용자가 입력-->
						<input type="text" placeholder="인증번호 입력" autocomplete="off" 
						class="authorkey" id="author2" maxlength="6">
						<!-- 인증번호 발급해준 것과 사용자 입력값 비교 -->
						<button class="key_submit" id="author_submit2">Check</button>
					</div>
					<!-- 비밀번호 찾기 버튼 -->
					<input type="button" value="find password" class="login_submit_pw" id="pw_submit">
					<br>
					<!-- 비밀번호 찾기 상태 확인 메세지 -->
					<span id="submit_pw_text" class="formSpans"></span>       
				</div> 
			</form>
		</div>
		<div class="popup">  <!-- 팝업처럼 하기 위한 배경 -->
			<div class="pwrap">  <!-- 실제 팝업창 -->
				<a class="closebtn">X</a> <!-- 비밀번호 변경창 닫기 버튼 -->
				<h2>Change Password</h2>
				<!-- 비밀번호 입력 -->
				<div class="pw_input_text" id="password_input">
                    <input type="password" name="password" placeholder="Password" autocomplete="off" 
                        class="input_size" id="pw">
				<!-- 비밀번호 입력 상태 확인 메세지 - 정규표현식에 위배되면 출력됨 -->
                    <i class="fa-solid fa-eye-slash fa-lg" id="eye1"></i>
                    <span id="input_regex" class="formSpans"></span>
                </div>
                <!-- 비밀번호 확인 입력 -->
                <div class="pw_input_text" id="password_confirm">
                    <input type="password" name="password_confirm" placeholder="Confirm Password" autocomplete="off" 
                        class="input_size" id="pw_confirm" disabled="disabled"><!-- 비밀번호 입력에서 정규표현식에 맞게 입력되면 입력가능 -->
                	<i class="fa-solid fa-eye-slash fa-lg" id="eye2"></i>
                	<span id="input_confirm_regex" class="formSpans"></span>
                </div>
                <!-- 비밀번호와 비밀번호 확인란의 입력값이 같은지 확인 -->
                <button id="pw_checkbtn">Check</button>
                
                <!-- 입력값 상태 메세지 -->
                <span id="check_result" class="formSpans"></span>
                
                <!-- 비밀번호 변경 버튼 - 입력값이 같은지 확인이 되면 사용가능 -->
                <input type="button" value="Change Password" 
                class="login_submit_pw" id="change_pw" disabled="disabled">
			</div>
		</div>
	</section>
	<h1>asdfsdfaashgsadgsdf</h1>
	<input type="hidden" value="eng" id="sessionL">	
	<footer>
<%@ include file="/WEB-INF/views/common/common_eng/footer.jsp" %>

	</footer>
</body>
</html>