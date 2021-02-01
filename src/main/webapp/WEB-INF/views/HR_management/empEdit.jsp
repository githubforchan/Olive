<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
h1 {
	text-decoration: underline;
	font-weight: bold;
	text-decoration-color: #ffe561;
	text-decoration-thickness: 5px;
}

img-margin-auto {
	max-width: 100%;
	height: auto display:block;
	margin-left: auto;
	margin-right: auto;
}

br-none {
	border-right: 0px;
}

bl-none {
	border-left: 0px;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
						<div class="row justify-content-center pr-3">
							<button type="reset" class="btn btn-danger btn-icon-split">
								<span class="icon text-white-50"> <i class="fas fa-redo"></i>
								</span> <span class="text">돌아가기</span>
							</button>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" id="submitBtn"
								class="btn btn-success btn-icon-split">
								<span class="icon text-white-50"> <i class="fas fa-check"></i>
								</span> <span class="text">수
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;정</span>
							</button>
						</div>
					</div>
					<!-- 계정관리 컨텐츠 시작 -->
					<div class="row">
						<div class="col-xl-6 col-lg-6 pr-0 ">
							<div class="card mb-4 br-none">
								<!-- Card Header - Dropdown -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-info">개인 정보</h6>
								</div>
								<!-- Card Body -->
								<div class="card-body  pd-5">
									<form action="" method="" id="">
										<div class="row justify-content-center">
											<div class="col-md-12">
												<div class="pt-3 pr-3 pl-3">
													<div class="row p-4">
														<div class="col-md-12">
															<div
																class="d-flex flex-column align-items-center text-center">
																<img id="preview"
																	class="img-margin-autorounded-circle content img-responsive center-block"
																	src="/resources/upload/${empinfo.PIC}" width="200"
																	onerror="this.src='/resources/img/undraw_profile_1.svg'">
															</div>
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
																value="${empinfo.ENAME}" placeholder="이름을 입력해주세요."
																name="ename" id="ename">
														</div>
													</div>
													<div class="row p-3">
														<div class="input-group col-md-12">
															<div class="input-group-prepend">
																<span class="input-group-text each-label"
																	id="inputGroup-sizing-default">이&nbsp;&nbsp;메&nbsp;&nbsp;일</span>
															</div>
															<input type="text" class="form-control"
																placeholder="전화번호를 입력해주세요" name="email" id="email"
																value="${empinfo.EMAIL}" readonly>
														</div>
													</div>
													<div class="row p-3">
														<div class="input-group col-md-12">
															<div class="input-group-prepend">
																<span class="input-group-text each-label"
																	id="inputGroup-sizing-default">생년월일</span>
															</div>
															<input type="text"
																class="form-control datepicker bg-white"
																placeholder="생년월일을 입력해주세요" name="birth" id="birth"
																value="${empinfo.BIRTH}">
														</div>
													</div>
													<div class="row p-3">
														<div class="input-group col-md-12">
															<div class="input-group-prepend">
																<span class="input-group-text each-label"
																	id="inputGroup-sizing-default">전화번호</span>
															</div>
															<input type="text" class="form-control"
																placeholder="전화번호를 입력해주세요" name="phone" id="phone"
																value="${empinfo.PHONE}" readonly>
														</div>
													</div>
													<div class="row p-3">
														<div class="input-group col-md-12">
															<div class="input-group-prepend">
																<span class="input-group-text each-label"
																	id="inputGroup-sizing-default">주
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 소</span>
															</div>
															<input type="text" class="form-control"
																placeholder="전화번호를 입력해주세요" name="address" id="address"
																value="${empinfo.ADDRESS}" readonly>
														</div>
													</div>
												</div>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
						<div class="col-xl-6 col-lg-6 pl-0">
							<div class="card mb-4 bl-none">
								<!-- Card Header - Dropdown -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-info">인사 정보</h6>
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
															<input type="text" class="form-control" name="empNo"
																id="empNo" value="${empinfo.EMPNO}" readonly>
														</div>
													</div>

													<div class="row p-3">
														<div class="input-group col-md-12">
															<div class="input-group-prepend">
																<span class="input-group-text each-label input_change"
																	id="inputGroup-sizing-default">입사일자</span>
															</div>
															<input type="text"
																class="form-control datepicker bg-white" id="hireDate"
																name="hireDate" value="${empinfo.HIREDATE}" readonly>
														</div>
													</div>
													<div class="row p-3">
														<div class="input-group col-md-12">
															<div class="input-group-prepend">
																<span class="input-group-text each-label input_change"
																	id="inputGroup-sizing-default">퇴사일자</span>
															</div>
															<input type="text"
																class="form-control datepicker bg-white" id="leaveDate"
																name="leaveDate" value="${empinfo.LEAVEDATE}" readonly>
														</div>
													</div>

													<div class="row p-3">
														<div class="input-group col-md-6">
															<div class="input-group-prepend">
																<span class="input-group-text each-label input_change"
																	id="inputGroup-sizing-default">본
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 부</span>
															</div>
															<input type="text" class="form-control input-radius"
																id="tempHead" name="headCode"
																value="${empinfo.HEADNAME}" readonly>
															<input type="text" id="headCode" value="${empinfo.HEADCODE}" hidden>
 														</div>
														<div class="input-group col-md-6">
															<div class="input-group-prepend">
																<span class="input-group-text each-label input_change"
																	id="inputGroup-sizing-default">선
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 택</span>
															</div>
															<select name="headCode" id="head"
																class="form-control input-radius">
															</select>
														</div>
													</div>

													<div class="row p-3">
														<div class="input-group col-md-6">
															<div class="input-group-prepend">
																<span class="input-group-text each-label input_change"
																	id="inputGroup-sizing-default">부
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 서</span>
															</div>
															<input type="text" class="form-control input-radius"
																id="tempDept" name="dept"
																value="${empinfo.DEPTNAME}" readonly>
																<input type="text" id="deptCode" value="${empinfo.DEPTCODE}" hidden>
														</div>
														<div class="input-group col-md-6">
															<div class="input-group-prepend">
																<span class="input-group-text each-label"
																	id="inputGroup-sizing-default input_change">선
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 택</span>
															</div>
															<select name="deptCode" id="dept"
																class="form-control input-radius">
																<option selected value="null">먼저 본부를 선택해주세요.</option>
															</select>
														</div>
													</div>

													<div class="row p-3">
														<div class="input-group col-md-6">
															<div class="input-group-prepend">
																<span class="input-group-text">직
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 책</span>
															</div>
															<input type="text" class="form-control input-radius"
																id="classTemp" name="" value="${empinfo.CLASSNAME}"
																readonly>
																<input type="text" id="classCode" value="${empinfo.CLASSCODE}" hidden>
														</div>
														<div class="input-group col-md-6">
															<div class="input-group-prepend">
																<span class="input-group-text">선
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 택</span>
															</div>
															<select name="" id="class"
																class="form-control input-radius">
															</select>
														</div>
													</div>

													<div class="row p-3">
														<div class="input-group col-md-6">
															<div class="input-group-prepend">
																<span class="input-group-text">직
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 위</span>
															</div>
															<input type="text" class="form-control input-radius"
																id="tempPosition" name=""
																value="${empinfo.POSITIONNAME}" readonly>
																<input type="text" id="positionCode" value="${empinfo.POSITIONCODE}" hidden>
														</div>
														<div class="input-group col-md-6">
															<div class="input-group-prepend">
																<span class="input-group-text">선
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 택</span>
															</div>
															<select name="positionCode" id="position"
																class="form-control input-radius">
															</select>
														</div>
													</div>
													<div class="row p-3">
														<div class="input-group col-md-6">
															<div class="input-group-prepend">
																<span class="input-group-text each-label input_change"
																	id="inputGroup-sizing-default">계정상태</span>
															</div>
															<input type="text" class="form-control" id="statusCode"
																name="status" value="${empinfo.STATUSNAME}" readonly>
														</div>
														<div class="input-group col-md-6"></div>
													</div>
													<div class="row p-3">
														<div class="col-md-6"></div>
														<div class="col-md-6">
															<div class="row justify-content-center">
																<button type="button" id="resetBtn"
																	class="btn btn-m btn-info">
																	<span class="text-white-50"></span> <span class="text">초&nbsp;&nbsp;기&nbsp;&nbsp;화</span>
																</button>
																<c:if test="${empty empinfo.LEAVEDATE}">
																&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																<button type="button" id="retireBtn"
																	class="btn btn-m btn-info">
																	<span class="text-white-50"></span> <span class="text">퇴사처리</span>
																</button>
																</c:if>
															</div>
														</div>
													</div>
												</div>
											</div>
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
	<!-- Footer 모듈화 -->
	<jsp:include page="/WEB-INF/views/inc/Footer.jsp"></jsp:include>
	<!-- End of Footer 모듈화 -->
	<!-- 모든 스크립트 모듈화 -->
	<jsp:include page="/WEB-INF/views/inc/BottomLink.jsp"></jsp:include>

	<!-- employee edit -->
	<script src="/resources/js/Hr_management/employee-edit.js"></script>
	<!-- SweetAlert -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<!-- datepicker -->
	<link rel="stylesheet" type="text/css"
		href="https://npmcdn.com/flatpickr/dist/themes/airbnb.css">
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
</body>
</html>