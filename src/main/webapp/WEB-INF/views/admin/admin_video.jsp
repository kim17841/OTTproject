<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/common/table.css">
<link href="/resources/css/admin/sb-admin-2.min.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/admin/main.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" />
<!-- 검색 -->
<link rel="stylesheet" href="/resources/css/board/searchbar.css">
<!-- 검색 및 테이블 -->
<link rel="stylesheet" href="/resources/css/board/qna_list.css">
<link rel="stylesheet" href="/resources/css/board/style.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
</head>
<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

	<!-- Sidebar -->
	<ul id="navUL" class="navbar-nav bg-secondary sidebar sidebar-dark accordion" id="accordionSidebar">
		<!-- Sidebar - Brand -->
		<a class="sidebar-brand d-flex align-items-center justify-content-center" href="/admin">
			<div class="sidebar-brand-icon rotate-n-15">
				<i class="fas fa-laugh-wink"></i>
			</div>
			<div class="sidebar-brand-text mx-3">관리자 페이지</div>
		</a>	
		<!-- Divider -->
		<hr class="sidebar-divider my-0">	
		<!-- Nav Item - Dashboard -->
		<li class="nav-item active">
			<a class="nav-link" href="/admin/userlist">
				<i class="fas fa-fw fa-tachometer-alt"></i>
				<span>회원 관리</span>
			</a>
		</li>		
		<!-- Divider -->
		<hr class="sidebar-divider">
		
		<!-- Heading -->
		<div class="sidebar-heading">
		    databases
		</div>
		
		<!-- Nav Item - Pages Collapse Menu -->
		<li class="nav-item">
		    <a id="dropdownLI" class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
		        aria-expanded="true" aria-controls="collapseTwo">
		        <i class="fas fa-fw fa-cog"></i>
		        <span>Database</span>
		    </a>
		    <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
		        <div class="bg-white py-2 collapse-inner rounded">
		            <h6 class="collapse-header">Video Database:</h6>
		            <a class="collapse-item" href="/admin/databases/video">Video</a>
		            <a class="collapse-item" href="/admin/databases/others">Others</a>
		        </div>
		    </div>
		</li>
		
		<hr class="sidebar-divider">
		<div class="sidebar-heading">
		    1:1chat
		</div>
		
		<!-- Nav Item - Pages Collapse Menu -->
		<li class="nav-item">
		    <a id="dropdownLI" class="nav-link collapsed" aria-expanded="true" aria-controls="collapseTwo" href="/admin/adminchat">
		        <i class="fas fa-fw fa-cog"></i>
		        <span>Chat</span>
		    </a>
		</li>	
		<!-- Divider -->
	    <hr class="sidebar-divider d-none d-md-block">
	</ul>
<!-- End of Sidebar -->

<!-- Content Wrapper -->
	<div id="content-wrapper" class="d-flex flex-column">
	
		<!-- Main Content -->
		<div id="content">
	
			<!-- Topbar -->
			<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
				<div class="d-sm-flex align-items-center justify-content-between mb-4">
					<h1 class="h3 mb-0 text-gray-800">Databases</h1>
				</div>
			</nav>
			<!-- End of Topbar -->
				
				<!-- Begin Page Content -->
				<div class="container-fluid">
				
				<!-- Page Heading -->
					<!-- 검색 -->
					<div class="s003">
						<form name="form1">
							<div class="inner-form">
								<div class="input-field first-wrap">
									<div class="input-select">
										<select id="selectBox" name="option" data-trigger="">
											<option value="TITLE">제목</option>											  
										</select>
									</div>
								</div>
								<div class="input-field second-wrap">
									<input id="searchh" type="text" placeholder="검색" name="keyword">
								</div>
								<div class="input-field third-wrap"> 
									<button class="btn-search" type="button" id="searchBtn">
										<svg class="svg-inline--fa fa-search fa-w-16" aria-hidden="true" data-prefix="fas" data-icon="search" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
											<path fill="currentColor" d="M505 442.7L405.3 343c-4.5-4.5-10.6-7-17-7H372c27.6-35.3 44-79.7 44-128C416 93.1 322.9 0 208 0S0 93.1 0 208s93.1 208 208 208c48.3 0 92.7-16.4 128-44v16.3c0 6.4 2.5 12.5 7 17l99.7 99.7c9.4 9.4 24.6 9.4 33.9 0l28.3-28.3c9.4-9.4 9.4-24.6.1-34zM208 336c-70.7 0-128-57.2-128-128 0-70.7 57.2-128 128-128 70.7 0 128 57.2 128 128 0 70.7-57.2 128-128 128z"></path>
										</svg>
									</button>				
								</div>  
								<input type="hidden" name="page" value="1">
							</div>
						</form>
					</div>
					
					<div class="content">
						<div class="container">
							<input class="deleteBtn"type="button" value="생성하기" onclick="location.href='/admin/databases/video/create'">
							<input class="deleteBtn"type="button" value="삭제하기" onclick="dataDelete()">						
							<div class="table-responsive custom-table-responsive">
								<table class="table custom-table">
									<thead>
										<tr>
											<th scope="col">
							                	<label class="control control--checkbox">
								                	<input type="checkbox" class="js-check-all"/>
								                	<div class="control__indicator"></div>
							                	</label>
											</th>
											<th scope="col">IDX</th>
											<th scope="col">제목</th>
											<!-- 추천수 정렬을 위한 a태그 추가 - 02.21 김범수 -->
											<th scope="col" class="hit">추천수&nbsp;
											<form id="hit_form" action="/admin/databases/video" method="get">
											<c:choose>
												<c:when test="${sort == 'desc1'}"> <!-- 오름차순 정렬을 진행한 경우 -->
													<a><i class="fa-solid fa-angle-down arrowbtn"></i><input type="hidden" name="sort" class="sort"></a>
												</c:when>
												<c:when test="${sort == 'asc1'}"> <!-- 내림차순 정렬을 진행한 경우 -->
													<a><i class="fa-solid fa-angle-up arrowbtn"></i><input type="hidden" name="sort" class="sort"></a>
												</c:when>
												<c:otherwise><!-- 처음 지정값 -->
													<a><i class="fa-solid fa-angle-up arrowbtn"></i><input type="hidden" name="sort" class="sort"></a>
												</c:otherwise>
											</c:choose>
											</form></th>
											<!-- 02.21 김범수 -->
											<th scope="col">등급</th>											
											<th scope="col">생성일자</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="list" items="${data}">
							            <tr class="moveDetail" scope="row">
											<th scope="row">
												<label class="control control--checkbox">
													<input class="checkNum" type="checkbox"/>
													<div class="control__indicator"></div>
												</label>
											</th>
											<td>${list.video_id}</td>
											<td>${list.title}</td>
											<td>${list.recommand}</td>
											<td>${list.grade}
											<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${list.upload_date}" /></td>
										</tr>
										<tr class="spacer"><td colspan="100"></td></tr>				
									</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>					
				<!-- 페이징 -->
				<div>			
					<form name="form2">
					<div id="pagination">
						<ul id="pageUL" class="btn-group">
						    <c:if test="${pageMaker.prev}">
						    <li class="left">
						        <a class="left" href='<c:url value="/admin/databases/video?page=${pageMaker.startPage-1}"/>'><i class="fa fa-chevron-left"></i></a>
						    </li>
						    </c:if>
						    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
						    <li class="curPage">
						        <a href='<c:url value="/admin/databases/video?page=${pageNum}"/>'><i class="fa">${pageNum}</i></a>
						    </li>
						    </c:forEach>
						    <c:if test="${pageMaker.next && pageMaker.endPage >0}">
						    <li class="right">
						        <a class="right" href='<c:url value="/admin/databases/video?page=${pageMaker.endPage+1}"/>'><i class="fa fa-chevron-right"></i></a>
						    </li>
						    </c:if>
						</ul>
					</div>
					<!-- 페이징에 정렬 값을 추가 - 02.22 김범수 -->
					<input type="hidden" name="sort" value="${pageMaker.cri.sort}"> <!-- 페이징에 해당 정렬 값을 추가-->
					<input id="pageH" type="hidden" name="page" value="${pageMaker.cri.page}">
					<input id="keywordH" type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
					<input id="optionH" type="hidden" name="option" value="${pageMaker.cri.option}">
					</form>		
				</div>
			</div>
		</div>
	</div>

<script src="/resources/js/admin/admin_video.js"></script>
<script src="/resources/js/board/searchbar.js"></script>
<!-- 
<script src=https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.3/js/bootstrap.min.js></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.6/umd/popper.min.js"></script>
 -->
<script>
const choices = new Choices('[data-trigger]',
{
  searchEnabled: false,
  itemSelectText: '',
});
</script>
</body>
<script src="/resources/js/admin/admin_main.js"></script>
</html>