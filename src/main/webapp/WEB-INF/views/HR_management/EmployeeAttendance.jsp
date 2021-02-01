
<%-- 
    파일명: EmployeeAttendance.jsp
    설명: 직원 휴가 및 근태 관리 CRUD (인사팀 전용)
    작성일: 2021-01-12
    작성자: 박채연
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>인사관리 - 근태 및 휴가 관리</title>
<!-- 스타일시트, CDN 모듈화 -->
<jsp:include page="/WEB-INF/views/inc/HeadLink.jsp"></jsp:include>
<!-- datepicker 용 CDN -->
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css" />
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style>
h1 {
	text-decoration: underline;
	font-weight: bold;
	text-decoration-color: #ffe561;
	text-decoration-thickness: 5px;
}

.paging-background {
	background-color: #eaecf4 !important;
}

/* Modal styles */
.modal .modal-dialog {
	max-width: 70%;
}

.modal .modal-header, .modal .modal-body, .modal .modal-footer {
	padding: 20px 30px;
}

.modal .modal-content {
	border-radius: 3px;
}

.modal .modal-footer {
	background: #ecf0f1;
	border-radius: 0 0 3px 3px;
}

.modal .modal-title {
	display: inline-block;
}

.modal .form-control {
	border-radius: 2px;
	box-shadow: none;
	border-color: #dddddd;
}

.modal textarea.form-control {
	resize: vertical;
}

.modal .btn {
	border-radius: 2px;
	min-width: 100px;
}

.modal form label {
	font-weight: normal;
}

.comBtn {
	display: none;
}
</style>
</head>
<body id="page-top">
	<!-- Page Wrapper -->
	<div id="wrapper">
		<!-- Sidebar 모듈화 -->
		<jsp:include page="/WEB-INF/views/inc/Sidebar.jsp"></jsp:include>
		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<!-- Main Content -->
			<div id="content">
				<!-- Topbar -->
				<jsp:include page="/WEB-INF/views/inc/Topbar.jsp"></jsp:include>
				<!-- Begin Page Content -->
				<div class="container-fluid">
					<!-- Page Heading -->
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">인사관리</h1>
					</div>
					<div class="row">
						<!-- Area Chart -->
						<div class="col-xl-7 col-lg-7">
							<div class="card shadow mb-4">
								<!-- Card Header - Dropdown -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h5 class="m-0 font-weight-bold text-info">부서별 근태 현황</h5>
								</div>
								<!-- Card Body -->
								<div class="card-body">
									<div class="chart-area">
										<canvas id="attChartForDept"></canvas>
									</div>
								</div>
							</div>
						</div>

						<!-- Pie Chart -->
						<div class="col-xl-5 col-lg-5">
							<div class="card shadow mb-4">
								<!-- Card Header -->
								<div
									class="card-header py-2 d-flex flex-row align-items-center justify-content-between">
									<h5 class="m-0 font-weight-bold text-info">근태 현황</h5>
									<div class="dropdown no-arrow">
										<form
											class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-1 my-md-0 mw-50 navbar-search">
											<div class="input-group">
												<input type="text" class="form-control bg-light border-1"
													placeholder="Search for..." aria-label="Search"
													aria-describedby="basic-addon2" id="searchBar">
												<div class="input-group-append">
													<button class="btn btn-primary ml-0" type="button"
														id="searchBtn5">
														<i class="fas fa-search fa-sm"></i>
													</button>
												</div>
											</div>
										</form>
									</div>
								</div>
								<!-- Card Body -->
								<div class="card-body">
									<div class="chart-pie pt-2 pb-2">
										<div class="text-right small">
											<i class="text-primary" id="emp"></i>
										</div>
										<canvas id="attChart"></canvas>
									</div>
									<div class="mt-4 text-center small">
										<span class="mr-2"> <i
											class="fas fa-circle text-primary"></i> 출근
										</span> <span class="mr-2"> <i
											class="fas fa-circle text-success"></i> 지각
										</span> <span class="mr-2"> <i class="fas fa-circle text-info"></i>
											휴가
										</span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-xl-12 col-lg-12">
							<div class="card shadow mb-4">
								<!-- Card Header -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h5 class="ml-0 mr-0 font-weight-bold text-info">근태 관리</h5>
									<form class="form-group mb-0">
										<div class="input-group">
											<select
												class="form-control text-center form-select-lg"
												id="newSearchType">
												<option selected>사번</option>
												<option>이름</option>
												<option>본부</option>
												<option>부서</option>
											</select> <input type="text"
												class="form-control text-center form-select-lg"
												id="newKeyword">
											<div class="input-group-append">
												<button type="button" class="btn btn-primary ml-0"
													id="searchBtn">
													<i class="fas fa-search fa-sm "></i>
												</button>
											</div>
										</div>
									</form>
								</div>
							<!-- Card Body -->
							<div class="card-body">
								<div class="card-for-flex  mb-1">
									<div
										class="card-body-tridiv justify-content-end search-tab row mr-5">
									</div>
								</div>
								<div class="row justify-content-center mx-5">
									<table id="empAtt_table" class="table text-center">
										<thead>
											<tr>
												<th>사번</th>
												<th>이름</th>
												<th>출근시간</th>
												<th>퇴근시간</th>
												<th>상태</th>
												<th>수정</th>
											</tr>
										</thead>
										<tbody id="attListTable">
											<c:forEach var="attendance" items="${attendance}">
												<tr>
													<td>${attendance.empno}</td>
													<td>${attendance.ename}</td>
													<td>${attendance.starttime}</td>
													<td>${attendance.endtime}</td>
													<td>${attendance.attname}</td>
													<td><c:if test="${attendance.attname ne '정상'}">
															<button class='attBtn btn btn-primary'>정상처리</button>
														</c:if></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									<c:set var="criteria" value="${criteria1}" />
									<input type="text" value="${criteria.searchType}"
										id="oldSearchType" hidden> <input type="text"
										value="${criteria.keyword}" id="oldKeyword" hidden> <input
										type="text" value="${criteria.page}" id="oldPage" hidden>
									<input type="text" value="${criteria.perPageNum}"
										id="oldPerPageNum" hidden>


									<c:set var="page" value="${pagination1}"></c:set>
									<nav aria-label="Page navigation example">

										<ul class="pagination" id="pagination">
											<c:if test="${page.prev}">
												<li class="page-item"><a
													class="page-link page-btn-prev" href="#"
													aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
														<span class="sr-only">Previous</span>
												</a></li>
											</c:if>

											<c:forEach var="paging" begin="${page.startPage}"
												end="${page.endPage}">
												<c:choose>
													<c:when test="${paging eq criteria.page}">
														<li class="page-item page-link paging-background"><b>${paging}</b></li>
													</c:when>
													<c:otherwise>
														<li class="page-item"><a class="page-link page-btn"
															href="#">${paging}</a></li>
													</c:otherwise>
												</c:choose>
											</c:forEach>

											<c:if test="${page.next}">
												<li class="page-item"><a
													class="page-link page-btn-next" href="#" aria-label="Next">
														<span aria-hidden="true">&raquo;</span> <span
														class="sr-only">Next</span>
												</a></li>
											</c:if>
										</ul>

									</nav>


								</div>
							</div>
						</div>

					</div>
				</div>

				<!-- 휴가 관리 컨텐츠 시작 -->
				<div class="row">
					<div class="col-xl-12 col-lg-12">
						<div class="card shadow mb-4">
							<!-- Card Header -->
							<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h5 class="ml-0 mr-0 font-weight-bold text-info">연차 관리</h5>
									<form class="form-group mb-0">
										<div class="input-group">
											<select
												class="form-control text-center form-select-lg"
												id="newSearchType2">
												<option selected>사번</option>
												<option>이름</option>
												<option>본부</option>
												<option>부서</option>
											</select> <input type="text"
												class="form-control text-center form-select-lg"
												id="newKeyword2">
											<div class="input-group-append">
												<button type="button" class="btn btn-primary ml-0"
													id="searchBtn2">
													<i class="fas fa-search fa-sm "></i>
												</button>
											</div>
										</div>
									</form>
								</div>
							<!-- Card Body -->
							<div class="card-body">
								<div class="card-for-flex mb-1">
									<div
										class="card-body-tridiv search-tab row justify-content-end mr-5">

									</div>
									<div class="card-body-tridiv"></div>
								</div>
								<div class="row justify-content-center mx-5">
									<table id="annTable" class="table text-center">
										<thead>
											<tr>
												<th>사번</th>
												<th>이름</th>
												<th>발생연차</th>
												<th>사용연차</th>
												<th>잔여연차</th>
												<th></th>
											</tr>
										</thead>
										<tbody id="annListTable">
											<c:forEach var="annual" items="${annual}">
												<tr>
													<td>${annual.empno}</td>
													<td>${annual.ename}</td>
													<td>${annual.annual}</td>
													<td>${annual.COUNT}</td>
													<td>${annual.DIFF}</td>
													<td><input type="button"
														class="checkBtn btn btn-primary" value="목록" /> <input
														type="button" class="editBtn btn btn-primary" value="수정" />
														<input type="button" class="comBtn" value="완료" /></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									<!-- 페이징 -->
									<c:set var="criteria" value="${criteria2}" />
									<input type="text" value="${criteria.searchType}"
										id="oldSearchType2" hidden> <input type="text"
										value="${criteria.keyword}" id="oldKeyword2" hidden> <input
										type="text" value="${criteria.page}" id="oldPage2" hidden>
									<input type="text" value="${criteria.perPageNum}"
										id="oldPerPageNum2" hidden>


									<c:set var="page" value="${pagination2}"></c:set>
									<nav aria-label="Page navigation example">

										<ul class="pagination" id="pagination2">
											<c:if test="${page.prev}">
												<li class="page-item"><a
													class="page-link page-btn-prev2" href="#"
													aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
														<span class="sr-only">Previous</span>
												</a></li>
											</c:if>

											<c:forEach var="paging" begin="${page.startPage}"
												end="${page.endPage}">
												<c:choose>
													<c:when test="${paging eq criteria2.page}">
														<li class="page-item page-link paging-background"><b>${paging}</b></li>
													</c:when>

													<c:otherwise>
														<li class="page-item"><a class="page-link page-btn2"
															href="#">${paging}</a></li>
													</c:otherwise>
												</c:choose>
											</c:forEach>

											<c:if test="${page.next}">
												<li class="page-item"><a
													class="page-link page-btn-next2" href="#" aria-label="Next">
														<span aria-hidden="true">&raquo;</span> <span
														class="sr-only">Next</span>
												</a></li>
											</c:if>
										</ul>
									</nav>
								</div>
							</div>
						</div>

					</div>
				</div>


				<!-- Edit Modal HTML -->
				<div id="EmpModal" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">

							<!-- Modal Header -->
							<div class="modal-header">
								<h4 class="modal-title">연차 사용 이력</h4>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>
							<div class="annModalTable">
								<table id="annModalTable" class="table text-center">
									<thead>
										<tr>
											<th>사번</th>
											<th>이름</th>
											<th>구분</th>
											<th>신청일</th>
											<th>시작일</th>
											<th>종료일</th>
											<th>사용연차</th>
										</tr>
									</thead>
									<tbody id="annBody">
										<!-- table append -->
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- /.container-fluid -->
		</div>
		<!-- End of Main Content -->
		<!-- Footer 모듈화 -->
	<jsp:include page="/WEB-INF/views/inc/Footer.jsp"></jsp:include>
	</div>
	<!-- End of Content Wrapper -->
	</div>
	<!-- End of Page Wrapper -->
	<!-- 모든 스크립트 모듈화 -->
	<jsp:include page="/WEB-INF/views/inc/BottomLink.jsp"></jsp:include>
	<!-- datepicker 용 jquery ui script -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
	<!-- SearchAndPaging -->
	<script src="/resources/js/Hr_management/EmployeeAttendancejs.js"></script>
	<!-- SweetAlert -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script src="/resources/js/Hr_management/organization-attChart.js"></script>
	<script src="/resources/js/Hr_management/attendance-chart.js"></script>
</body>
<script type="text/javascript">
	$(function() {
		$('#collapseHRM').addClass('show');
		$('#collapseHRM').prev().removeClass('collapsed');
		$('#collapseHRM').prev().children().css("color", "#fff");

	})

</script>
</html>