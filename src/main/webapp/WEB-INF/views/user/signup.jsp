<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>signup</title>
  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css"/>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<link href="/resources/css/user/user_signup.css" rel="stylesheet">
</head>
<body>
<!--네비바 추가 0227 김지혜  -->   
<div id="navSection">
<%@ include file="/WEB-INF/views/common/navbar1.jsp" %>
</div>
<!--네비바 end  -->  

<div class="container_j"> 
		<div id="mainDiv_j">
	        <div id="viewDiv_j">
				<span id="signUpText_j">LOGO 회원가입</span>
		            <!-- form start  -->
					<form name="form1" id="form1" method="post" action="/user/signup">
		                <div id="viewInput_j">
							<div class="wrapInput">
				            	<div>   
				                	<input value="<c:if test="${userDto.id != null}">${userDto.id}</c:if>" type="text" name="id" id="id" placeholder="ID" autocomplete="on">
				                </div>
								<div>
					            	<button type="button" id="btn"> 아이디 중복체크</button>
									<span id="idcheck"></span>
					        	</div>  
							</div>      
		                
		                	<div class="wrapInput">	
	                    		<input value="<c:if test="${userDto.email != null}">${userDto.email}</c:if>" type="email" name="email" id="email" placeholder="이메일" autocomplete="on">
								<button type="button" id="email_btn">이메일 중복체크</button>						
								<span id="emailcheck"></span>
							</div>	
							
							<div>
								<br>
			                  	<!-- 인증번호 입력 / 확인버튼 추기 ___  이메일로 받은 인증번호를 사용자가 입력-->
			                	<input type="text" placeholder="인증번호 입력" autocomplete="off" class="authorkey" id="author" maxlength="6">
			                 	<!-- 인증번호 발급해준 것과 사용자 입력값 비교 -->
								<button class="key_submit" id="author_submit">확인</button>
			                	<button class="email_checkbtn" id="emailchk">이메일 인증</button> <!-- 이메일 인증 버튼 -->
							</div>
			               
							<!-- 비밀번호  -->
							<div id = "passwordArea">
								<div class="wrapInput">		                    	
		                    		<input type="password" name="password" id="password" placeholder="영문, 숫자, 특수문자(~!@#$%^&*) 조합 8~15 자리 " autocomplete="on">
									<i class="fa-solid fa-eye-slash fa-lg" id="eye1"></i>
									<span id="pwMsg"></span>
			                    </div>
			                    
			                    <div class="wrapInput">
			                        <input type="password" name="password1" id="password1" placeholder="비밀번호 확인" autocomplete="on">
	  								<i class="fa-solid fa-eye-slash fa-lg" id="eye2"></i>
	  							</div>
		                    </div>  
		                    
		                    <div class="wrapInput">
								<input value="<c:if test="${userDto.nickname != null}">${userDto.nickname}</c:if>" type="text" name="nickname" id="nicknamecheck" class="formInputs" placeholder= "닉네임(빈칸,특수문자 제외)">
							
									<span id="nncheck"></span>

		                    </div>
		                    <div class="wrapInput">
		                        <input value="<c:if test="${userDto.phone_num != null}">${userDto.phone_num}</c:if>" type="text" name="phone_num" id="phone_numcheck" class="formInputs" placeholder="휴대폰번호"  oninput="autoHyphen(this)" maxlength="13" autocomplete="no">
		                    </div>
		             </div>
					
					
					<!-- checkbox start  -->
					
					
					<div id="checkbox">   
		                             <input type='checkbox' id='selectAll' value="" /> 모두 동의 합니다 <br>
		                             	<input type='checkbox' class="checkB" id="check1" name="check" value="">  만 14세 이상입니다<br>
		                                <input type='checkbox' class="checkB" id="check2"  name="check" value="">  [필수] 서비스 이용약관 동의<br> 
										<input type='checkbox'class="checkB" id="check3"  name="check" value=""> [필수] 개인정보 수집 및 서비스 활용 동의
		            </div> 
					<!--  id="checkbox" end  -->
	            <input id="submit" type="submit" value="가입하기" >
				</form> <!-- form end  -->
		</div>  
	</div> <!--<div id="mainDiv_j"> end --> 
</div> <!-- <div id="container_j"> end -->
<!-- footer start  -->  
  <div id="signUpF">
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
  </div>
<!-- footer end  -->
	<script src="/resources/js/user/user_signup.js"></script>
</body>
</html>