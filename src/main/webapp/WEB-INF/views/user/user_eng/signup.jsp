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
				<span id="signUpText_j">SIGNUP</span>
		            <!-- form start  -->
					<form name="form1" action="signup" method="post">
		                <div id="viewInput_j">
		                
		                
							<div class="wrapInput">
				            	<div>   
				                	<input type="text" name="id" id="id" placeholder="ID" autocomplete="on">
				                </div>
								<div>
					            	<button type="button" id="btn">check</button>
									<span id="idcheck"></span>
					        	</div>  
							</div>      
		                
		                	<div class="wrapInput">	
	                    		<input type="email" name="email" id="email" placeholder="email" autocomplete="on">
								<button type="button" id="email_btn">check</button>						
								<span id="emailcheck"></span>
							</div>	
							
							<div>
								<br>
			                  	<!-- 인증번호 입력 / 확인버튼 추기 ___  이메일로 받은 인증번호를 사용자가 입력-->
			                	<input type="text" placeholder="Certification number input"autocomplete="off" class="authorkey" id="author" maxlength="6">
			                 	<!-- 인증번호 발급해준 것과 사용자 입력값 비교 -->
								<button class="key_submit" id="author_submit">Check</button>
			                	<button class="email_checkbtn" id="emailchk">EA</button> <!-- 이메일 인증 버튼 -->
							</div>
			               
							<!-- 비밀번호  -->
							<div id = "passwordArea">
								<div class="wrapInput">		                    	
		                    		<input type="password" name="password" id="password" placeholder="8 to 15, eng, num, special characters(~!@#$%^&*) combination" autocomplete="on">
									<i class="fa-solid fa-eye-slash fa-lg" id="eye1"></i>
									<span id="pwMsg"></span>
			                    </div>
			                    
			                    <div class="wrapInput">
			                        <input type="password" name="password1" id="password1" placeholder="checkPW" autocomplete="on">
	  								<i class="fa-solid fa-eye-slash fa-lg" id="eye2"></i>
	  							</div>
		                    </div>  
		                    
		                    <div class="wrapInput">
								<input type="text" name="nickname" id="nicknamecheck" class="formInputs" placeholder= "Nickname(except blank, special characters)">
							
									<span id="nncheck"></span>
									<c:if test="${message=='fault'}">
										<span id="nncheck2">Duplicate nickname.</span>
									</c:if>

		                    </div>
		                    <div class="wrapInput">
		                        <input type="text" name="phone_num" id="phone_numcheck" class="formInputs" placeholder="PhoneNum"  oninput="autoHyphen(this)" maxlength="13" autocomplete="no">
		                    </div>
		             </div>
					
					
					<!-- checkbox start  -->
					
					
					<div id="checkbox">   
                    	<input type='checkbox' id='selectAll' value="" /> All agree <br>
                        <input type='checkbox' class="checkB" id="check1" name="check" value=""> I am over 14 years old<br>
                        <input type='checkbox' class="checkB" id="check2"  name="check" value=""> [Required] Agree to the Terms of Service<br> 
						<input type='checkbox'class="checkB" id="check3"  name="check" value=""> [Required] Consent to personal information collection and service use
		            </div> 
					<!--  id="checkbox" end  -->
	            <input id="submit" type="button" value="SIGNUP" >
	            <c:if test="${message=='fault'}">
				</c:if>
				</form> <!-- form end  -->	
		</div>  
	</div> <!--<div id="mainDiv_j"> end --> 
</div> <!-- <div id="container_j"> end -->
<input type="hidden" value="eng" id="sessionL">
<!-- footer start  -->  
  <div id="signUpF">
<%@ include file="/WEB-INF/views/common/common_eng/footer.jsp" %>
  </div>
	<script src="/resources/js/user/user_signup.js"></script>
</body>
</html>