<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/common/table.css">
<link href="/resources/css/admin/sb-admin-2.min.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/admin/main.css">
<link rel="stylesheet" href="/resources/css/admin/admin_otherdb.css">
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
				<div class="dbDiv">
				<c:set var="i" value="0" />
				<c:set var="j" value="5" />
					<table border="1">
					<h3>카테고리</h3>					
						<tbody>
						<c:forEach var="list" items="${data}">
							<c:if test="${i%j == 0}">						
							<tr>
							</c:if>
								<form name="delCategory" action="/admin/delCategory">
									<input type="hidden" name="category_name" value="${list.category_name}">						
									<td>${list.category_name}<button class="deleteBtn" type="button" onclick="delTarget(this)">삭제</button></td>
								</form>
							<c:if test="${i%j == j-1}">
							</tr>
							</c:if>
							<c:set var="i" value="${i+1}" />	
						</c:forEach>
						</tbody>
					</table>
					<form name="newCategory" action="/admin/addCategory">
						<input type="text" name="category_name" placeholder="추가할 카테고리명">
						<button id="categoryBtn" class="deleteBtn" type="button">등록</button>	
					</form>
				</div>
				
				<div class="dbDiv">
				<c:set var="i" value="0" />
				<c:set var="j" value="5" />
					<table border="1">
					<h3>장르</h3>			
						<tbody>
						<c:forEach var="list" items="${datasec}">
							<c:if test="${i%j == 0}">						
							<tr>
							</c:if>
								<form name="delGenre" action="/admin/delGenre">
									<input type="hidden" name="genre_name" value="${list.genre_name}">
									<td>${list.genre_name}<button class="deleteBtn" type="button" onclick="delTarget(this)">삭제</button></td>
								</form>
							<c:if test="${i%j == j-1}">
							</tr>
							</c:if>
							<c:set var="i" value="${i+1}" />							
						</c:forEach>
						</tbody>
					</table>
					<form name="newGenre" action="/admin/addGenre">
						<input type="text" name="genre_name" placeholder="추가할  장르명">
						<button id="genreBtn" class="deleteBtn" type="button">등록</button>
					</form>
				</div>
			</div>
			
			<div class="container-fluid">				
				<div class="dbDiv">
				<c:set var="i" value="0" />
				<c:set var="j" value="7" />
					<table border="1">
					<h3>배우</h3>
						<tbody>
						<c:forEach var="list" items="${datathr}">
							<c:if test="${i%j == 0}">
							<tr>
							</c:if>
								<form name="delActor" action="/admin/delActor">
									<input type="hidden" name="actor_name" value="${list.actor_name}">						
									<td>${list.actor_name}<button class="deleteBtn" type="button" onclick="delTarget(this)">삭제</button></td>
								</form>
							<c:if test="${i%j == j-1}">
							</tr>
							</c:if>
							<c:set var="i" value="${i+1}" />
						</c:forEach>
						</tbody>
					</table>
					<form name="newActor" action="/admin/addActor">
						<input type="text" name="actor_name" placeholder="추가할 배우명">
						<button id="actorBtn" class="deleteBtn" type="button">등록</button>	
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="/resources/js/admin/admin_otherdb.js"></script>
<script src="/resources/js/admin/admin_main.js"></script>
</body>
</html>