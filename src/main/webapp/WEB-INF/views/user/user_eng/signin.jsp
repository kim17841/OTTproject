<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/user/user_signin.css">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<script src="/resources/js/user/user_signin.js"></script>
<!-- kakao -->
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<!-- kakao -->
<!-- naver -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"charset="utf-8"></script>
</head>
<body>
	<header>
		<%@ include file="/WEB-INF/views/common/navbar1.jsp" %>
	</header>
	<section>
		<div class="section_loginform">
			<span class="login"><span class="login_text">Login</span><small><a href="/user/find">Did you forget your password?</a></small></span>
			<form method="post" action="signin_check" class="login_form">
				<div>
					<div class="input_text">
						<input type="text" name="id" placeholder="ID" autocomplete="off" class="input_size">
						<span id="id" class="formSpans"></span>
					</div>
					<div class="input_text">
						<input type="password" name="password" placeholder="Password" autocomplete="off" class="input_size">
						<span id="password" class="formSpans"></span>
						<!-- test="${message == 'error' } - 조건식 : 컨트롤러에서 들고오는 메세지-->

					</div>
					<button class="login_submit">Login</button>
					<c:if test="${message == 'error' }">
            			<div class="error_text">The IDs or passwords do not match.</div>
         			</c:if>
         			<c:if test="${message == 'success' }">
            			<div class="error_text"></div>
         			</c:if>
				</div> 
			</form>
			
			<span class="division_line"> <br>Logging In Another Way</span>
                  
			<div class="image-div">
				<div id="button_area"> 
					<div class="naverIcon" id="naverIdLogin"><img src="/resources/img/user/iconNaver.svg"></div>
				</div>
				<div onclick="kakaoLogin()">
					<div class="kakaoIcon"><img src="/resources/img/user/iconKakao.svg" alt=""></div>
				</div>
			</div>
                  
			<div>
				<span class="signup_text"> <br>Aren't you a member yet? </span>
				<br>
				<form method="get" action="/user/signup">
					<button class="signup">join the membership</button>
				</form>
			</div>
		</div>
	</section>
	<input type="hidden" value="eng" id="sessionL">
	<%@ include file="/WEB-INF/views/common/common_eng/footer.jsp" %>
<script src="/resources/js/api/google.js"></script>
<script src="/resources/js/api/kakao.js"></script>
<script src="/resources/js/api/naver.js"></script>
</body>
</html>