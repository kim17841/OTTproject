<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
<link rel="stylesheet" href="/resources/css/common/start.css">
 <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar1.jsp" %>
    <!-- sectionA start -->
    <!-- 첫번째_화면 -->
    <div class="sectionA">
    	<!-- 사이트 소개 -->
        <div class="intro">
            <h1 class="introA1">
                <span>You can see the content that you want in one place at a glance</span>
            </h1>
            <br> 
            <h4 class="introA2">Movies, dramas, entertainment shows, documentaries, and webtoons</h4>
            <br>
            <!-- 로그인 -->
            <div>
                <input type="button" value="Getting Started with Various Content" class="center_btn">
            </div>
        </div>
        <img src ="https://an2-img.amz.wtchn.net/image/v2/llh5gNLQ8b52zGFpsikOhQ.webp?jwt=ZXlKaGJHY2lPaUpJVXpJMU5pSjkuZXlKdmNIUnpJanBiSW1KbklsMHNJbkFpT2lJdmRqSXZjM1J2Y21VdmFXMWhaMlV2TVRZek9UTTNOakl3T0RReU9USXhPVEkwTXlKOS42ZW94UDcwMS1EblFUcVdldEhzZlRoQlV1c3Z0NmNMejRHQkRJRkxiMGNV"
        id="img1">
        <div class="scroll_btn">
        	<div class="btn" id="btn1"></div>
        	<div class="btn" id="btn2"></div>
        	<div class="btn" id="btn3"></div>
        </div>
    </div>
    <!-- sectionA end -->


    <!-- sectionB start -->
    <!-- 두번째_화면 -->
    <div class="sectionB">
        <img src ="https://occ-0-1361-988.1.nflxso.net/dnm/api/v6/6AYY37jfdO6hpXcMjf9Yu5cnmO0/AAAABaBPgS5as_hNEjMagPMGJEJZ0wytPkBR7ZoCiECebUPtnA686YmTrvDs5JpcxpeXzJC_im6PiJmUuw3acKzTB4qspheK3ivnAFeQ.jpg?r=227"
         id="img2">
        <!-- 사이트 소개 -->
        <div class="intro">
            <h1 class="introA1">
                <span>Any content that you want to see, anytime, anywhere<br>Enjoy offline.</span> 
            </h1>
            <br>
            <h4 class="introA2">Stream more than 100,000 content unlimitedly.</h4>
            <br>
            <!-- 로그인 -->
            <div>
                <input type="button" value="Getting Started with Various Content" class="center_btn">
            </div>
        </div>
    </div>
    <!-- sectionB end -->


    <!-- sectionC start -->
    <!-- 세번째_화면 -->
    <div class="sectionC">
		<img src =
		"https://occ-0-1361-988.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABXSXupXGGRa4Q413AX_ASqMU4XOxpB4IxQlwKgsV6XnAXHCmVE1fOznLeM7sTLp-bfI20MgRYNI3TLM4uxpaRERHP0tMbxsvI4r-.jpg?r=032" 
		id="img3">
		<!-- 사이트 소개 -->
        <div class="intro">
            <h1 class="introA1">
                <span>Smartphones, tablets, TVs, PCs, Chromecast</span> 
            </h1>
			<br>
			<h4 class="introA2">Don't stop watching while you're on the move.</h4>
			<br>
			<!-- 로그인 -->
			<div>
				<input type="button" value="Getting Started with Various Content" class="center_btn">
			</div>
		</div>
    </div>
	<!-- sectionC end -->


	<%@ include file="/WEB-INF/views/common/common_eng/footer.jsp" %>
	<script>
	$(function(){
		const url = new URL(window.location.href);
		const urlParams = url.searchParams;
		if(urlParams.get('error') != null){
			alert(urlParams.get('error'));
		}
	})
	</script>
<script src="/resources/js/common/start.js"></script>	
</body>
</html>