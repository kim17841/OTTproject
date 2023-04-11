<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<script type="text/javascript" src="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet" href="/resources/css/video/list.css">
<script src="https://kit.fontawesome.com/885ba80ba8.js" crossorigin="anonymous"></script>
</head>
<body> 
<%@ include file="/WEB-INF/views/common/common_eng/navbar2.jsp" %> 
  
<!-- main video start -->    
  
	<div id="main_video">  
		<video muted autoplay loop id="bg_video">
			<c:forEach var="list" items="${dto}">
				<source src="${list.video_url} " type="video/mp4">
			</c:forEach> 
		</video>
	</div>
  
<!-- main video end -->

	<div id="section_all">    
	  <div id="search-results"></div>  <!-- 검색결과 div -->
	<!-- movie category -->
		<div class="hide">
			<h1 class="section_main_text">MOVIE</h1>
			<div class="section">
		       <div class="slider">
					<c:forEach var="row" items="${dto}">
						<c:if test="${row.category_id == '1' && fn:containsIgnoreCase(row.title, searchText)}">
							<div class="conta">
								<a href="/video/detail?video_id=${row.video_id}"> <img src="${row.image_url}" alt="Image not found"></a>
							      <span style="display:none">${row.title}</span>
							</div>
						</c:if> 
					</c:forEach>
		      </div>
			</div>
		</div>  
		
		<!-- action genre -->
		<div id="actionSubMenu" class="sub-menu" style="display:none">
			<h1 class="section_main_text">ACTION</h1>
			<div class="section">
				<c:forEach var="row" items="${dto}">
					<c:if test="${row.genre_id == '1'}"> 
						<div class="conta">
							<a href="/video/detail?video_id=${row.video_id}"> <img src="${row.image_url}" alt="Image not found"></a>
	                     </div>
					</c:if> 
				</c:forEach>
			</div> 
		</div>    
		<!-- action genre end -->       
	                         
		<!-- drama genre -->
		<div id="dramaSubMenu" class="sub-menu" style="display:none">
			<h1 class="section_main_text">DRAMA</h1>
			<div class="section">
				<c:forEach var="row" items="${dto}">
					<c:if test="${row.genre_id == '2'}"> 
						<div class="conta">
							<a href="/video/detail?video_id=${row.video_id}"> <img src="${row.image_url}" alt="Image not found"></a>
						</div>
					</c:if> 
				</c:forEach>
			</div> 
		</div>   
		<!-- drama genre end -->        
	                
		<!-- fantasy genre -->
		<div id="fantasySubMenu" class="sub-menu" style="display:none">
			<h1 class="section_main_text">FANTASY</h1>
			<div class="section">
				<c:forEach var="row" items="${dto}">
					<c:if test="${row.genre_id == '3'}"> 
						<div class="conta">
							<a href="/video/detail?video_id=${row.video_id}"> <img src="${row.image_url}" alt="Image not found"></a>
						</div>
					</c:if> 
				</c:forEach>
			</div> 
		</div>     
		<!-- fantasy genre end -->
	                 
		<!-- SF genre  -->
		<div id="sfSubMenu" class="sub-menu" style="display:none">
			<h1 class="section_main_text">SF</h1>
			<div class="section">
				<c:forEach var="row" items="${dto}">
					<c:if test="${row.genre_id == '4'}"> 
						<div class="conta">
							<a href="/video/detail?video_id=${row.video_id}"> <img src="${row.image_url}" alt="Image not found"></a>
						</div>
					</c:if> 
				</c:forEach>
			</div> 
		</div>          
		<!-- SF genre end  -->      
	               
		<!-- crime genre -->
		<div id="crimeSubMenu" class="sub-menu" style="display:none">
			<h1 class="section_main_text">CRIME</h1>
			<div class="section">
				<c:forEach var="row" items="${dto}">
					<c:if test="${row.genre_id == '5'}"> 
						<div class="conta">
							<a href="/video/detail?video_id=${row.video_id}"> <img src="${row.image_url}" alt="Image not found"></a>
						</div>
					</c:if> 
				</c:forEach>
			</div> 
		</div>           
		<!-- crime genre end -->    
	                      
	<!-- movie category end -->

		<!-- animation category -->
		<div class="hide">
			<h1 class="section_main_text">ANIMATION</h1>
			<div class="section">
			    <div class="slider">
					<c:forEach var="row" items="${dto}">
						<c:if test="${row.category_id == '2' && fn:containsIgnoreCase(row.title, searchText)}">
							<div class="conta">
								<a href="/video/detail?video_id=${row.video_id}"> <img src="${row.image_url}" alt="Image not found"></a>
							      <span style="display:none">${row.title}</span>
							</div>
						</c:if>
					</c:forEach>
	           </div>
		</div>
		<!-- animation section end -->
		</div> 
	
	
	</div>
<%@ include file="/WEB-INF/views/common/ads.jsp" %>
<%@ include file="/WEB-INF/views/common/common_eng/footer.jsp" %>	
<!-- footer end  -->
<script src="/resources/js/video/list.js"></script>
<script src="/resources/js/video/list.js"></script>

</body>
</html>