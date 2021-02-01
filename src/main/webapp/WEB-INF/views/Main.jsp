<%-- 
    파일명: index.jsp
    설명: 모든 사원 로그인 시 표시되는 대쉬보드 컨텐츠 페이지
    작성일: 2020-12-26
    작성자: 백희승
--%>
<%-- 
    파일명: Main.jsp
    설명: 모든 사원 로그인 시 표시되는 대쉬보드 컨텐츠 페이지 수정 
    작성일: 2020-01-14
    작성자: 박선우
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="/resources/img/icon.png" type="image/x-icon">
<title>Project_HR</title>
<!-- 스타일시트, CDN 모듈화 -->
<!-- 날씨 css -->
<link href="/resources/css/weather.css" rel="stylesheet" type="text/css">
<style type="text/css">
	.appbadge{
		position:absolute;
		right:3px;
		font-size:13px;
	}
	h1 {
	text-decoration: underline;
	font-weight: bold;
	text-decoration-color: #ffe561;
	text-decoration-thickness: 5px;
}
	
</style>
</head>
<body id="page-top">
	<input value='<spring:eval expression="@weather.getProperty('weatherkey')"></spring:eval>' hidden id="weatherkey">
	<!-- Page Wrapper -->
	<div id="wrapper">
		<!-- Sidebar 모듈화 -->
		<jsp:include page="/WEB-INF/views/inc/Sidebar.jsp"></jsp:include>
		<!-- End Of Sidebar 모듈화 -->
		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<!-- Main Content -->
			<div id="content">
				<!-- Topbar -->
				<jsp:include page="/WEB-INF/views/inc/Topbar.jsp"></jsp:include>
				<c:set var="arrangedDocList" value="${requestScope.arrangedDocList }" />
				<c:set var="arrangedAppList" value="${requestScope.arrangedAppList }" />
				<c:set var="attList" value="${requestScope.attList }"/>
				<c:set var="emp" value="${requestScope.emp }"/>
				<!-- End of Topbar -->
				<!-- Begin Page Content -->
				<div class="container-fluid">
					<!-- Page Heading -->
					<div class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">대쉬보드</h1>
					</div>
					<!-- 날씨 API + 뉴스 API 파트 row -->
					<div class="row">
						<!-- 날씨 API -->
						<div class="col-xl-4 col-lg-5">
							<div class="card shadow mb-4">
								<!-- Card Header - Dropdown -->
								<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h5 class="m-0 font-weight-bold text-info">오늘의 날씨</h5>
								</div>
								<!-- 날씨 컨텐츠 :  -->
								<div class="card-body weather-here div-min-height">
									<jsp:include page="/WEB-INF/views/inc/preloadingWeather.jsp" />
								</div>
							</div>
						</div>
						<!-- 뉴스 API -->
						<div class="col-xl-8 col-lg-7 ">
							<div class="card shadow mb-4 height-fix">
								<!-- Card Header - Dropdown -->
								<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h5 class="m-0 font-weight-bold text-info">데일리 뉴스</h5>
								</div>
								<!-- 데일리 뉴스 컨텐츠 -->
								<div class="card-body">
									<div id="myCarousel" class="carousel slide">
										<!-- The slideshow-->
										<div class="carousel-inner">
											<div id="news1" class="carousel-item active"></div>
											<div id="news2" class="carousel-item"></div>
											<div id="news3" class="carousel-item"></div>
											<div id="news4" class="carousel-item"></div>
											<div id="news5" class="carousel-item"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- xl3 md6 카드들 row -->
					<div class="row">
						<!-- Tasks Card Example -->
						<div class="col-xl-3 col-md-6 mb-4">
							<div class="card  shadow h-100">
								<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
								<h5 class="m-0 font-weight-bold text-info">개인 문서함</h5>
								<div class="">
										<a class="" href="/approval/PersonalDoc.do" role="button">
											<img src="/resources/img/external-link.png">
										</a>
									</div>
								</div>
								
								<div class="card-body"> 
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div class="row no-gutters align-items-center my-2">
												<img src="/resources/img/document.png">
												<div class="col-auto">
													<div class="h5 mb-0 mx-3 text-gray-800">기안 문서</div>
												</div>
												<div class="badge badge-danger appbadge">
									
												${arrangedDocList.doc_ready.size() }
												</div>
											</div>
											<div class="row no-gutters align-items-center my-2">
												<img src="/resources/img/onApp.png">
												<div class="col-auto">
													<div class="h5 mb-0 mx-3 text-gray-800">결재 진행중</div>
												</div>
												<div class="badge badge-danger appbadge">
									
												${arrangedDocList.doc_ing.size() }
												</div>
											</div>
											<div class="row no-gutters align-items-center my-2">
												<img src="/resources/img/document.png">
												<div class="col-auto">
													<div class="h5 mb-0 mx-3 text-gray-800">반려 문서</div>
												</div>
												<div class="badge badge-danger appbadge">
									
												${arrangedDocList.doc_rej.size() }
												</div>
											</div>
											<div class="row no-gutters align-items-center my-2">
												<img src="/resources/img/doneApp.png">
												<div class="col-auto">
													<div class="h5 mb-0 mx-3 text-gray-800">결재 완료</div>
												</div>
												<div class="badge badge-danger appbadge">
									
												${arrangedDocList.doc_cmp.size() }
												</div>
											</div>
										</div>
										
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-3 col-md-6 mb-4">
							<div class="card  shadow h-100">
								<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
								<h5 class="m-0 font-weight-bold text-info">결재 문서함</h5>
								<div class="">
										<a class="" href="/approval/ProgressDoc.do" role="button">
											<img src="/resources/img/external-link.png">
										</a>
									</div>
								</div>
								
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div class="row no-gutters align-items-center my-2">
												<img src="/resources/img/document.png">
												<div class="col-auto">
													<div class="h5 mb-0 mx-3 text-gray-800">결재 대기</div>
												</div>
												<div class="badge badge-danger appbadge">
									
												${arrangedAppList.doc_ready.size() }
												</div>
											</div>
											<div class="row no-gutters align-items-center my-2">
												<img src="/resources/img/onApp.png">
												<div class="col-auto">
													<div class="h5 mb-0 mx-3 text-gray-800">결재 진행중</div>
												</div>
												<div class="badge badge-danger appbadge">
									
												${arrangedAppList.doc_ing.size() }
												</div>
											</div>
											<div class="row no-gutters align-items-center my-2">
												<img src="/resources/img/document.png">
												<div class="col-auto">
													<div class="h5 mb-0 mx-3 text-gray-800">반려 문서</div>
												</div>
												<div class="badge badge-danger appbadge">
									
												${arrangedAppList.doc_rej.size() }
												</div>
											</div>
											<div class="row no-gutters align-items-center my-2">
												<img src="/resources/img/doneApp.png">
												<div class="col-auto">
													<div class="h5 mb-0 mx-3 text-gray-800">결재 완료</div>
												</div>
												<div class="badge badge-danger appbadge">
									
												${arrangedAppList.doc_cmp.size() }
												</div>
											</div>
										</div>
										
									</div>
								</div>
							</div>
						</div>
						<!-- Pending Requests Card Example -->
						<div class="col-xl-3 col-md-6 mb-4">
							<div class="card shadow h-100">
								<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
								<h5 class="m-0 font-weight-bold text-info">근태현황</h5>
								<div class="">
										<a class="" href="${pageContext.request.contextPath}/attendance/attendance.do" role="button">
											<img src="/resources/img/external-link.png">
										</a>
									</div>
								</div>
								
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div class="row no-gutters align-items-center my-2">
												<img src="/resources/img/attendance.png">
												<div class="col-auto">
													<div class="h5 mb-0 mx-3 text-gray-800">정상</div>
												</div>
												<div class="badge badge-danger appbadge">
												
												${attList.normal.size() }
												</div>
											</div>
											<div class="row no-gutters align-items-center my-2">
												<img src="/resources/img/late.png">
												<div class="col-auto">
													<div class="h5 mb-0 mx-3 text-gray-800">지각</div>
												</div>
												<div class="badge badge-danger appbadge">
									
												${attList.over.size() }
												</div>
											</div>
											<div class="row no-gutters align-items-center my-2">
												<img src="/resources/img/leave-early.png">
												<div class="col-auto">
													<div class="h5 mb-0 mx-3 text-gray-800">조퇴</div>
												</div>
												<div class="badge badge-danger appbadge">
									
												${attList.early.size() }
												</div>
											</div>
											<div class="row no-gutters align-items-center my-2">
												<img src="/resources/img/absent.png">
												<div class="col-auto">
													<div class="h5 mb-0 mx-3 text-gray-800">결근</div>
												</div>
												<div class="badge badge-danger appbadge">
									
												${attList.none.size() }
												</div>
											</div>
										</div>
										
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-3 col-md-6 mb-4">
							<div class="card shadow h-100">
								<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
								<h5 class="m-0 font-weight-bold text-info">연차 현황</h5>
								<div class="">
										<a class="" href="${pageContext.request.contextPath}/attendance/annual.do" role="button">
											<img src="/resources/img/external-link.png">
										</a>
									</div>
								</div>
								
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div class="row no-gutters align-items-center my-2">
												<img src="/resources/img/total_calendar.png">
												<div class="col-auto">
													<div class="h5 mb-0 mx-3 text-gray-800">총 연차</div>
												</div>
												<div class="badge badge-danger appbadge">
												
												${emp.annual}
												</div>
											</div>
											<div class="row no-gutters align-items-center my-2">
												<img src="/resources/img/checked_calendar.png">
												<div class="col-auto">
													<div class="h5 mb-0 mx-3 text-gray-800">사용연차</div>
												</div>
												<div class="badge badge-danger appbadge">
									
												${emp.usedAnnual}
												</div>
											</div>
											<div class="row no-gutters align-items-center my-2">
												<img src="/resources/img/left_calendar.png">
												<div class="col-auto">
													<div class="h5 mb-0 mx-3 text-gray-800">남은연차</div>
												</div> 
												<div class="badge badge-danger appbadge">
									
												${emp.annual-emp.usedAnnual}
												</div>
											</div>
										</div>
										
									</div>
								</div>
							</div>
						</div>
					</div>
		<!-- /.container-fluid -->
				</div>
	<!-- End of Main Content -->
			</div> 
	<!-- End of Footer 모듈화 -->
	<jsp:include page="/WEB-INF/views/inc/Footer.jsp"></jsp:include>
		</div>
	<!-- End of Content Wrapper -->
	</div>
	<!-- End of Page Wrapper -->
	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top">
		<i class="fas fa-angle-up"></i>
	</a>
	<!-- Logout Modal-->
	<jsp:include page="/WEB-INF/views/inc/LogOutModal.jsp" />
	<!-- 모든 스크립트 모듈화 -->
	<jsp:include page="/WEB-INF/views/inc/BottomLink.jsp"></jsp:include>
	<script src="/resources/js/skycons.js"></script>
	<script src="/resources/js/openweatherAPIuse.js"></script>
	<script src="/resources/js/newsAPI.js"></script>
</body>
</html>