<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
h1{
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
			<!-- Topbar -->
			<jsp:include page="/WEB-INF/views/inc/Topbar.jsp"></jsp:include>
			<!-- Main Content -->
			<div id="content">
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
							<div class="card mb-4">
								<!-- Card Header - Dropdown -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h5 class="m-0 font-weight-bold text-info">
										계정 등록 &nbsp;&nbsp;
									</h5>
								</div>
								<!-- Card Body -->
								<div class="card-body">
									<form action="/HR_management/EmployeeAccount.do" method="POST"
										id="newEmpForm">
										<div class="row justify-content-center">
											<div class="col-md-12">
												<div class="pt-3 pr-3 pl-3">
													<div class="row p-3">
														<div class="input-group col-md-12">
															<div class="input-group-prepend">
																<span class="input-group-text inputGroup-sizing-default"
																	id="checkEmpNo">사원번호</span>
															</div>
															<input type="text" class="form-control"
																placeholder="자동생성 : [입사일(년,월) + 본부 + 부서 + 순번]"
																name="empNo" id="empNo" readonly>
														</div>
													</div>

													<div class="row p-3">
														<div class="input-group col-md-12">
															<div class="input-group-prepend">
																<span class="input-group-text each-label"
																	id="checkEmpNo">이
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 름</span>
															</div>
															<input type="text" class="form-control"
																placeholder="이름을 입력해주세요." name="ename" id="ename">
														</div>
													</div>

													<div class="row p-3">
														<div class="input-group col-md-12">
															<div class="input-group-prepend">
																<span class="input-group-text each-label"
																	id="inputGroup-sizing-default">생년월일</span>
															</div>
															<input type="text" class="form-control datepicker"
																placeholder="생년월일을 입력해주세요" name="birth" id="birth">
															<input type="hidden" name="pwd" id="pwd">
														</div>
													</div>

													<div class="row p-3">
														<div class="input-group col-md-12">
															<div class="input-group-prepend">
																<span class="input-group-text each-label input_change"
																	id="inputGroup-sizing-default">입사일자</span>
															</div>
															<input type="text" class="form-control datepicker"
																placeholder="입사일 입력해주세요" id="hireDate" name="hireDate">
														</div>
													</div>

													<div class="row p-3">
														<div class="input-group col-md-12">
															<div class="input-group-prepend">
																<span class="input-group-text each-label input_change"
																	id="inputGroup-sizing-default">본
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 부</span>
															</div>
															<select name="headCode" id="head"
																class="form-control input-radius">
															</select>
														</div>
													</div>

													<div class="row p-3">
														<div class="input-group col-md-12">
															<div class="input-group-prepend">
																<span class="input-group-text each-label"
																	id="inputGroup-sizing-default input_change">부
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 서</span>
															</div>
															<select name="deptCode" id="dept"
																class="form-control input-radius">
																<option selected value="null">먼저 본부를 선택해주세요.</option>
															</select>
														</div>
													</div>

													<div class="row p-3">
														<div class="input-group col-md-12">
															<div class="input-group-prepend">
																<span class="input-group-text">직
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 책</span>
															</div>
															<select name="classCode" id="class"
																class="form-control input-radius">
															</select>
														</div>
													</div>

													<div class="row p-3">
														<div class="input-group col-md-12">
															<div class="input-group-prepend">
																<span class="input-group-text">직
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 위</span>
															</div>
															<select name="positionCode" id="position"
																class="form-control input-radius">
															</select>
														</div>
													</div>

													<input type="hidden" name="enabled" value="1">
													<!-- enabled : true -->
													<input type="hidden" name="statusCode" value="10">
													<!-- 사원 신규 등록 : statusCode = 10번 -->
												</div>
											</div>
										</div>
										<br> <br>
										<div class="row justify-content-center">
											<button type="reset" class="btn btn-danger btn-icon-split">
												<span class="icon text-white-50"> <i
													class="fas fa-redo"></i>
												</span> <span class="text">초기화</span>
											</button>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<button type="button" id="submitBtn"
												class="btn btn-success btn-icon-split">
												<span class="icon text-white-50"> <i
													class="fas fa-check"></i>
												</span> <span class="text">사원 등록</span>
											</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /.container-fluid -->
	</div>
	<!-- Logout Modal-->
	<jsp:include page="/WEB-INF/views/inc/LogOutModal.jsp" />
	<!-- Footer 모듈화 -->
	<jsp:include page="/WEB-INF/views/inc/Footer.jsp"></jsp:include>
	<!-- End of Footer 모듈화 -->
	<!-- 모든 스크립트 모듈화 -->
	<jsp:include page="/WEB-INF/views/inc/BottomLink.jsp"></jsp:include>

	<!-- Validation -->
	<script src="/resources/js/Hr_management/validationBeforeInsert.js"></script>
	<!-- SweetAlert -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<!-- datepicker -->
	<link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/airbnb.css">
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
</body>
</html>