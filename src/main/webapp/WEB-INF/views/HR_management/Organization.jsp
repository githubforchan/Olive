<%-- 
    파일명: EmployeeAccount.jsp
    설명: 직원 계정 CRUD (인사팀 전용)
    작성일: 2020-12-29
    작성자: 정민찬
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인사관리 - 조직관리</title>
<jsp:include page="/WEB-INF/views/inc/HeadLink.jsp"></jsp:include>
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
</style>
</head>

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
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">인사관리</h1>
					</div>

					<!-- xl3 md6 카드들 row -->
					<div class="row">
						<!-- 직원 수 -->
						<div class="col-xl-3 col-md-6 mb-4">
							<div class="card border-left-primary shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div
												class="text-xs font-weight-bold text-primary text-uppercase mb-1">
												<h6>headcount</h6>
											</div>
											<div class="h5 mb-0 font-weight-bold text-gray-800">${dashboard.headCount}명</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-calendar fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- Earnings (Annual) Card Example -->
						<div class="col-xl-3 col-md-6 mb-4">
							<div class="card border-left-success shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div
												class="text-xs font-weight-bold text-success text-uppercase mb-1">
												<h6>hired</h6>
											</div>
											<div class="h5 mb-0 font-weight-bold text-gray-800">${dashboard.hired}명</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- Pending Requests Card Example -->
						<div class="col-xl-3 col-md-6 mb-4">
							<div class="card border-left-warning shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div
												class="text-xs font-weight-bold text-warning text-uppercase mb-1">
												<h6>retired</h6>
											</div>
											<div class="h5 mb-0 font-weight-bold text-gray-800">${dashboard.retired}명</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-comments fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>


						<!-- Tasks Card Example -->
						<div class="col-xl-3 col-md-6 mb-4">
							<div class="card border-left-info shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div
												class="text-xs font-weight-bold text-info text-uppercase mb-1">
												<h6>Occupancy rate</h6>
											</div>
											<div class="row no-gutters align-items-center">
												<div class="col-auto">
													<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">
														<fmt:formatNumber value="${dashboard.headCount/50*100}"
															pattern=".0" />
														%
													</div>
												</div>
												<div class="col">
													<div class="progress progress-sm mr-2">
														<div class="progress-bar bg-info" role="progressbar"
															style="width: <fmt:formatNumber value="${dashboard.headCount/50*100}" pattern=".0"/>%"
															aria-valuenow="<fmt:formatNumber value="${dashboard.headCount/30*100}" pattern=".0"/>"
															aria-valuemin="0" aria-valuemax="100"></div>
													</div>
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
					</div>

					<!-- 차트 row -->
					<div class="row">
						<!-- Area Chart -->
						<div class="col-xl-8 col-lg-7">
							<div class="card shadow mb-4">
								<!-- Card Header - Dropdown -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h5 class="m-0 font-weight-bold text-info">연도별 사원 수</h5>
								</div>
								<!-- Card Body -->
								<div class="card-body">
									<div class="chart-area">
										<canvas id="employees-chart" style="height: 30vh; width: 50vw"></canvas>
									</div>
								</div>
							</div>
						</div>

						<!-- Pie Chart -->
						<div class="col-xl-4 col-lg-5">
							<div class="card shadow mb-4">
								<!-- Card Header -->

								<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h5 class="m-0 font-weight-bold text-info">부서별 사원 분포</h5>
								</div>
								<!-- Card Body -->
								<div class="card-body">
									<div class="chart-area">
										<canvas id="groupedDept-chart"></canvas>
									</div>
								</div>
							</div>
						</div>
						<!-- /Pie Chart -->
					</div>

					<div class="row">
						<div class="col-xl-12 col-lg-12">
							<div class="card shadow mb-4">
								<!-- Card Header -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h5 class="ml-0 mr-0 font-weight-bold text-info">계정 관리</h5>
									<form class="form-group mb-0">
										<div class="input-group">
											<input type="button" class="btn btn-primary form-control"
												id="excelBtn" value="다운로드"> <select
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
									<div class="card-for-flex mb-1">
										<div
											class="card-body-tridiv search-tab row justify-content-end mr-5">
											<div class="mb-3">
												<!-- 비동기로 DB다녀오는 친구들 -->

											</div>
										</div>
										<div class="card-body-tridiv"></div>
									</div>
									<div class="row justify-content-center mx-5">
										<table id="salary_table" class="table text-center">
											<thead>
												<tr>
													<th>사번</th>
													<th>이름</th>
													<th>본부</th>
													<th>부서</th>
													<th>직책</th>
													<th>직급</th>
													<th>수정하기</th>
												</tr>
											</thead>
											<tbody id="empListTable">
												<c:forEach var="emp" items="${list}">
													<tr>
														<td><c:out value="${emp.EMPNO}" /></td>
														<td><c:out value="${emp.ENAME}" /></td>
														<td><c:out value="${emp.HEADNAME}" /></td>
														<td><c:out value="${emp.DEPTNAME}" /></td>
														<td><c:out value="${emp.POSITIONNAME}" /></td>
														<td><c:out value="${emp.CLASSNAME}" /></td>
														<td><button
																class="btn-sm btn-info shadow-sm empEditBtn"
																value="${emp.EMPNO}">
																<i class="fas fa-check fa-sm text-white"></i>
															</button></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
										<c:set var="criteria" value="${criteria}" />

										<input type="text" value="${criteria.searchType}"
											id="oldSearchType" hidden> <input type="text"
											value="${criteria.keyword}" id="oldKeyword" hidden> <input
											type="text" value="${criteria.page}" id="oldPage" hidden>
										<input type="text" value="${criteria.perPageNum}"
											id="oldPerPageNum" hidden>


										<c:set var="page" value="${pagination}"></c:set>
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
															<li class="page-link page-item paging-background">${paging}</li>
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
									<!-- 									<div class="row mr-5 float-right">
										<a href="#employNewEmpModal" class="btn btn-info"
											data-toggle="modal">사원 신규 등록</a>
									</div> -->
									<div class="row mr-0 float-right">
										<a
											href="${pageContext.request.contextPath}/HR_management/registration.do"
											class="btn btn-primary">사원 신규 등록</a>
									</div>
								</div>
								<!-- //내가 올린 결재 card-body -->
							</div>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->

			<!-- Footer 모듈화 -->
			<jsp:include page="/WEB-INF/views/inc/Footer.jsp"></jsp:include>
			<!-- End of Footer 모듈화 -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>
	<!-- Logout Modal-->
	<jsp:include page="/WEB-INF/views/inc/LogOutModal.jsp" />
	<!-- 모든 스크립트 모듈화 -->
	<jsp:include page="/WEB-INF/views/inc/BottomLink.jsp"></jsp:include>

	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
</body>
<!-- Logout Modal-->
<jsp:include page="/WEB-INF/views/inc/LogOutModal.jsp" />
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- SearchAndPaging -->
<script src="/resources/js/Hr_management/searchAndPaging.js"></script>
<!-- downloadToExcel -->
<script src="/resources/js/Hr_management/downloadToExcel.js"></script>
<!-- SweetAlert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="/resources/js/Hr_management/organization-dashboard.js"></script>
</html>