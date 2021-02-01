<!-- 
	파일명:M_Attendance.jsp
	설명: 근태현황(매니져) 홈페이지 
	작성일 : 2020-12-30
	수정일 : 2020-01-07
	작성자 : 심재형 
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link href='fullcalendar/main.css' rel='stylesheet' />
<script src='fullcalendar/main.js'></script>
<script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<link href='../resources/fullcalendar-5.5.0/lib/main.css' rel='stylesheet' />
<script src='../resources/fullcalendar-5.5.0/lib/main.js'></script>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>Project_HR</title>
<!-- 스타일시트, CDN 모듈화 -->
<jsp:include page="/WEB-INF/views/inc/HeadLink.jsp"></jsp:include>
</head>
<style>

#calendar {
	max-width: 1300px;
	margin: 0 auto;
}

.item {
	flex: 1 1 auto;
}
h1 {
	text-decoration: underline;
    font-weight: bold;
    text-decoration-color: #ffe561;
    text-decoration-thickness: 5px;
}
</style>
<body id="page-top">
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
				<!-- End of Topbar -->
				<!-- Begin Page Content -->
				<div class="container-fluid">
					<!-- Page Heading -->
					<div class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 text-gray-800">근태관리</h1>
					</div>
					<c:set var="emp" value="${emp}" />
					<c:set var="annualCard" value="${annualCard}" />
					<!-- Page Heading -->
					<div class="row">
						
						<div class="col-xl col-md-6 mb-4">
							<div class="card border-left-primary shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div class="text-xl font-weight-bold text-primary text-uppercase mb-1">이번달 총연차</div>
											<div class="h5 mb-0 font-weight-bold text-gray-800">${annualCard.annual}일</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-calendar fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- Earnings (Annual) Card Example -->
						<div class="col-xl col-md-6 mb-4">
							<div class="card border-left-success shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div class="text-xl font-weight-bold text-success text-uppercase mb-1">이번달 사용연차</div>
											<span class="h5 font-weight-bold text-gray-800">${annualCard.count}일</span>
										</div>
										<div class="col-auto">
											<i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- Tasks Card Example -->
						<div class="col-xl col-md-6 mb-4">
							<div class="card border-left-info shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div class="text-xl font-weight-bold text-info text-uppercase mb-1">이번달 남은연차</div>
											<div class="row no-gutters align-items-center">
												<div class="col-auto">
													<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">${annualCard.diff}</div>
												</div>
											</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
						<%-- </c:if> --%>
						<%-- </c:forEach> --%>
					</div>
					<!-- End of Main Content -->
					<!-- 계정관리 컨텐츠 시작 -->
					<div class="row">
						<div class="col-xl-12 col-lg-12">
							<div class="card shadow mb-4">
								<!-- Card Header -->
								<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h5 class="ml-0 mr-0 font-weight-bold text-info">휴가테이블</h5>
									<form class="form-group mb-0">
										<div class="input-group">
											<select class="form-control text-center form-select-lg" id="newSearchType">
												<option selected>사번</option>
												<option>이름</option>
											</select>
											<input type="text" class="form-control text-center form-select-lg" id="newKeyword">
											<div class="input-group-append">
												<button type="button" class="btn btn-primary ml-0" id="searchBtn">
													<i class="fas fa-search fa-sm "></i>
												</button>
											</div>
										</div>
									</form>
								</div>
								<!-- Card Body -->
								<div class="card-body">
									<div class="card-for-flex mb-1">
										<div class="card-body-tridiv search-tab row justify-content-end mr-5">
											<div class="mb-3">
												<!-- //비동기로 DB다녀오는 친구들 -->
											</div>
										</div>
										<div class="card-body-tridiv"></div>
									</div>
									<div class="row justify-content-center mx-5">
										<table id="salary_table" class="table text-center">
											<thead>
												<tr>
													<th>문서번호</th>
													<th>사번</th>
													<th>이름</th>
													<th>사용연차</th>
													<th>발생일</th>
													<th>종료일</th>
													<th>선택</th>
												</tr>
											</thead>
											<tbody id="annualTable">
												<c:forEach var="annual_diff" items="${list}">
													<tr class="namecal">
														<td>
															<c:out value="${annual_diff.docno}" />
														</td>
														<td name="empno">
															<c:out value="${annual_diff.empno}" />
														</td>
														<td>
															<c:out value="${annual_diff.ename}" />
														</td>
														<td>
															<c:out value="${annual_diff.count}" />
														</td>
														<td>
															<fmt:formatDate value="${annual_diff.startdate}" pattern="yyyy-MM-dd HH:mm:ss" />
														</td>
														<td>
															<fmt:formatDate value="${annual_diff.enddate}" pattern="yyyy-MM-dd HH:mm:ss" />
														</td>
														<td>
															<label class="userCheck"><input class='filter' type="radio" name="user"></label>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
										<c:set var="criteria" value="${criteria}" />
										<input type="text" value="${criteria.searchType}" id="oldSearchType" hidden>
										<input type="text" value="${criteria.keyword}" id="oldKeyword" hidden>
										<input type="text" value="${criteria.page}" id="oldPage" hidden>
										<input type="text" value="${criteria.perPageNum}" id="oldPerPageNum" hidden>
										<c:set var="page" value="${pagination}"></c:set>
										<nav aria-label="Page navigation example">
											<ul class="pagination" id="pagination">
												<c:if test="${page.prev}">
													<li class="page-item"><a class="page-link page-btn-prev" href="#" aria-label="Previous">
															<span aria-hidden="true">&laquo;</span> <span class="sr-only">Previous</span>
														</a></li>
												</c:if>
												<c:forEach var="paging" begin="${page.startPage}" end="${page.endPage}">
													<c:choose>
														<c:when test="${paging eq criteria.page}">
															<li class="page-item page-link"><b>${paging}</b></li>
														</c:when>
														<c:otherwise>
															<li class="page-item"><a class="page-link page-btn" href="#">${paging}</a></li>
														</c:otherwise>
													</c:choose>
												</c:forEach>
												<c:if test="${page.next}">
													<li class="page-item"><a class="page-link page-btn-next" href="#" aria-label="Next">
															<span aria-hidden="true">&raquo;</span> <span class="sr-only">Next</span>
														</a></li>
												</c:if>
											</ul>
										</nav>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl col-lg-12">
						<div class="card shadow mb-4">
							<!-- Card Header -->
							<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
								<h5 class="m-0 font-weight-bold text-info">캘린더</h5>
							</div>
							<!-- Card Body -->
							<div class="card-body">
								<div class="center-block item">
									<div id='calendar'></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- End of Main Content -->
			<!-- Footer 모듈화 -->
			<jsp:include page="../inc/Footer.jsp"></jsp:include>
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
	<!-- SearchAndPaging -->
	<script src="/resources/js/Attendance/annual.js"></script>
	<!-- 캘린더 모듈화  -->
	<!-- <script src="/resources/js/Attendance/calendartest.js"></script> -->
	<script src="/resources/js/Attendance/annualCal.js"></script>
	<!-- 모든 스크립트 모듈화 -->
	<jsp:include page="/WEB-INF/views/inc/BottomLink.jsp"></jsp:include>
</body>
</html>