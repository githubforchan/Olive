<%-- 
    파일명: EmployeeAccount.jsp
    설명: 직원 계정 CRUD (인사팀 전용)
    작성일: 2020-12-29
    작성자: 정민찬
    
    수정일 : 2021-01-02
    수정자 : 백희승
    수정내역 : 사원 등록을 위한 Modal 추가 작성
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
<title>인사관리 - 계정 관리</title>
<!-- 스타일시트, CDN 모듈화 -->
<jsp:include page="/WEB-INF/views/inc/HeadLink.jsp"></jsp:include>
<!-- datepicker 용 CDN -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css" />
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style>
.paging-background {
  background-color: #eaecf4 !important;
}

p.each-label {
	margin-top: 0.5rem;
	margin-bottom: 0;
	font-weight: bolder;
}

p.each-label ~ .form-control::placeholder, p.each-label+select option {
	font-size: 0.75rem;
	color: gray;
}

p.each-label span {
	font-weight: normal;
	font-size: 0.75rem;
}

p.each-label>span {
	font-weight: bold;
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
					<!-- 계정관리 컨텐츠 시작 -->
					<div class="row">
						<div class="col-xl-12 col-lg-12">
							<div class="card shadow mb-4">
								<!-- Card Header -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h5 class="ml-0 mr-0 font-weight-bold text-info">계정 관리</h5>
									<form class="form-group mb-0">
										<div class="input-group">
											<input type="button" class="btn btn-primary form-control" id="excelBtn"
												value="다운로드">
											<select class="form-control text-center form-select-lg" id="newSearchType">
												<option selected>사번</option>
												<option>이름</option>
												<option>본부</option>
												<option>부서</option>
											</select> 
											<input type="text" class="form-control text-center form-select-lg"
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
														<td><button	class="btn-sm btn-info shadow-sm empEditBtn"
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
															<li class="page-link page-item paging-background" >${paging}</li>
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
		</div>
		<!-- End of Content Wrapper -->
	</div>
	<!-- End of Page Wrapper -->
	<!-- Logout Modal-->
	<jsp:include page="/WEB-INF/views/inc/LogOutModal.jsp" />
	<!-- 모든 스크립트 모듈화 -->
	<jsp:include page="/WEB-INF/views/inc/BottomLink.jsp"></jsp:include>
	<!-- SearchAndPaging -->
	<script src="/resources/js/Hr_management/searchAndPaging.js"></script>
	<!-- downloadToExcel -->
	<script src="/resources/js/Hr_management/downloadToExcel.js"></script>
	<!-- SweetAlert -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script>
		$(document).on("click", ".empEditBtn", function() {
			var empno = $(this).val();
			console.log(empno);
			window.location.href = "/HR_management/empEdit.do?empno=" + empno
		});
	</script>
</body>
</html>