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
<script src="/resources/js/common/start.js"></script>
</head>
<body>
<!-- 네비바  start _ 02/27 김지혜 네비바 수정 -->

<%@ include file="/WEB-INF/views/common/navbar1.jsp" %>

<!-- 네비바  end -->
    <!-- sectionA start -->
    <!-- 첫번째_화면 -->
    <div class="sectionA">
    	<!-- 사이트 소개 -->
        <div class="intro">
            <h1 class="introA1">
                <span>한곳에서 원하는 콘텐츠를 한눈에</span>
            </h1>
            <br> 
            <h4 class="introA2">영화, 드라마, 예능, 다큐멘터리, 웹툰을 무제한으로</h4>
            <br>
            <!-- 로그인 -->
            <div>
                <input type="button" value="다양한 컨텐츠 이용 시작하기" class="center_btn">
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
                <span>보고 싶은 콘텐츠를 언제 어디서나 <br>오프라인으로 즐기세요.</span> 
            </h1>
            <br>
            <h4 class="introA2">10만여 편의 콘텐츠를 무제한 스트리밍하세요.</h4>
            <br>
            <!-- 로그인 -->
            <div>
                <input type="button" value="다양한 컨텐츠 이용 시작하기" class="center_btn">
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
                <span>스마트폰, 태블릿, TV, PC, 크롬캐스트에서</span> 
            </h1>
			<br>
			<h4 class="introA2">이동 중에도 감상을 멈추지 마세요</h4>
			<br>
			<!-- 로그인 -->
			<div>
				<input type="button" value="다양한 컨텐츠 이용 시작하기" class="center_btn">
			</div>
		</div>
    </div>
	<!-- sectionC end -->

    <!-- footer start -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	<!-- footer end -->
	<script>
	$(function(){
		const url = new URL(window.location.href);
		const urlParams = url.searchParams;
		if(urlParams.get('error') != null){
			alert(urlParams.get('error'));
		}
	})
	</script>
</body>
</html>