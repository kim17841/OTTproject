<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<!-- Custom fonts for this template-->
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<!-- Custom styles for this template-->
<link href="/resources/css/admin/sb-admin-2.min.css" rel="stylesheet">
<!-- FontAwesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" />
<!-- 수정 CSS -->
<link rel="stylesheet" href="/resources/css/admin/main.css">
<!-- Canvas Chart -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
					<h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
				</div>
			</nav>
			<!-- End of Topbar -->
	
			<!-- Begin Page Content -->
			<div class="container-fluid">
	
				<!-- Page Heading -->

	
				<!-- Content Row -->
				<div class="row">
				<!-- Earnings (Monthly) Card Example -->
					<div class="col-xl-3 col-md-6 mb-4">
	    				<div class="card border-left-primary shadow h-100 py-2">
	        				<div class="card-body">
	            				<div class="row no-gutters align-items-center">
	                				<div class="col mr-2">
	                    				<div class="text-xs font-weight-bold text-primary text-uppercase mb-1">일 매출</div>
	                    				<div class="h5 mb-0 font-weight-bold text-gray-800">${dailySales}원</div>
	                				</div>
	                				<div class="col-auto">
	                					<i class="fa-duotone fa-sack"></i>
	                    				<i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
	                				</div>
	            				</div>
	        				</div>
	    				</div>
					</div>
	
					<!-- Earnings (Monthly) Card Example -->
					<div class="col-xl-3 col-md-6 mb-4">
						<div class="card border-left-primary shadow h-100 py-2">
							<div class="card-body">
								<div class="row no-gutters align-items-center">
									<div class="col mr-2">
										<div class="text-xs font-weight-bold text-primary text-uppercase mb-1">전체 매출</div>
										<div class="h5 mb-0 font-weight-bold text-gray-800">${totalSales}원</div>
									</div>
									<div class="col-auto"><i class="fas fa-clipboard-list fa-2x text-gray-300"></i></div>
								</div>
							</div>
						</div>
					</div>
	
					<div class="col-xl-3 col-md-6 mb-4">
	    				<div class="card border-left-success shadow h-100 py-2">
	        				<div class="card-body">
	            				<div class="row no-gutters align-items-center">
	                				<div class="col mr-2">
	                    				<div class="text-xs font-weight-bold text-success text-uppercase mb-1">일 방문자 수</div>
	                    				<div class="h5 mb-0 font-weight-bold text-gray-800">${todayVisit}명</div>
	                				</div>
	                				<div class="col-auto">
	                					<i class="fa-duotone fa-sack"></i>
	                    				<i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
	                				</div>
	            				</div>
	        				</div>
	    				</div>
					</div>
					
					<div class="col-xl-3 col-md-6 mb-4">
	    				<div class="card border-left-success shadow h-100 py-2">
	        				<div class="card-body">
	            				<div class="row no-gutters align-items-center">
	                				<div class="col mr-2">
	                    				<div class="text-xs font-weight-bold text-success text-uppercase mb-1">총 방문자 수</div>
	                    				<div class="h5 mb-0 font-weight-bold text-gray-800">${totalVisit}명</div>
	                				</div>
	                				<div class="col-auto">
	                					<i class="fa-duotone fa-sack"></i>
	                    				<i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
	                				</div>
	            				</div>
	        				</div>
	    				</div>
					</div>
				</div>
	
				<!-- Content Row -->
				<div class="row">
				
					<!-- Area Chart -->
					<div class="col-xl-6 col-lg-8">
						<div class="card shadow mb-4">
						<!-- Card Header - Dropdown -->
							<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
								<h6 class="m-0 font-weight-bold text-primary">카테고리별 조회수</h6>
							</div>
							<!-- Card Body -->
							<div class="card-body">
								<div class="chart-area">
									<canvas id="categoryChart"></canvas>
								</div>
							</div>
						</div>
					</div>
	
					<!-- Area Chart -->
					<div class="col-xl-6 col-lg-8">
						<div class="card shadow mb-4">
						<!-- Card Header - Dropdown -->
							<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
								<h6 class="m-0 font-weight-bold text-primary">장르별 조회수</h6>
							</div>
							<!-- Card Body -->
							<div class="card-body">
								<div class="chart-area">
									<canvas id="genreChart"></canvas>
								</div>
							</div>
						</div>
					</div>
					
					<div class="col-xl-6 col-lg-8">
						<div class="card shadow mb-4">
						<!-- Card Header - Dropdown -->
							<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
								<h6 class="m-0 font-weight-bold text-primary">주간 매출</h6>
							</div>
							<!-- Card Body -->
							<div class="card-body">
								<div class="chart-area">
									<canvas id="salesChart"></canvas>
								</div>
							</div>
						</div>
					</div>
					
					<div class="col-xl-6 col-lg-8">
						<div class="card shadow mb-4">
						<!-- Card Header - Dropdown -->
							<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
								<h6 class="m-0 font-weight-bold text-primary">주간 방문자</h6>
							</div>
							<!-- Card Body -->
							<div class="card-body">
								<div class="chart-area">
									<canvas id="visitChart"></canvas>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<input id="categoryH" type="hidden" value="${category}">
<input id="genreH" type="hidden" value="${genre}">
<input id="visitH" type="hidden" value="${visit}">
<input id="salesH" type="hidden" value="${sales}">
<script src="/resources/js/admin/category_chart.js"></script>
<script src="/resources/js/admin/genre_chart.js"></script>
<script src="/resources/js/admin/salesChart.js"></script>
<script src="/resources/js/admin/visitChart.js"></script>

</body>
<script src="/resources/js/admin/admin_main.js"></script>
</html>