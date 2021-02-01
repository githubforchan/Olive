<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Salary</title>

<!-- 스타일시트, CDN 모듈화 -->
<jsp:include page="/WEB-INF/views/inc/HeadLink.jsp"></jsp:include>
<link href="/resources/css/chaeyeon.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style>
h1{
	text-decoration: underline;
	font-weight: bold;
	text-decoration-color: #ffe561;
	text-decoration-thickness: 5px;
}
.paging-background {
  background-color: #eaecf4 !important;
}

.file {
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
}
.file > input[type='file'] {
  display: none
}
.file > label {
  font-size: 1rem;
  font-weight: 300;
  cursor: pointer;
  outline: 0;
  user-select: none;
  border-color: rgb(216, 216, 216) rgb(209, 209, 209) rgb(186, 186, 186);
  border-style: solid;
  border-radius: 4px;
  border-width: 1px;
  background-color: hsl(0, 0%, 100%);
  color: hsl(0, 0%, 29%);
  padding : 5px;
  display: flex;
  justify-content: center;
  align-items: center;
  margin:0;
}
.file > label:hover {
  border-color: rgb(73, 85, 113);
}
.file > label:active {
  background-color: rgb(73, 85, 113);
}
.file > label > i {
  padding-right: 5px;
}
.file--uploading > label {
  color: rgb(73, 85, 113);
  border-color: rgb(73, 85, 113);
}

.file--uploading > label > i {
  animation: pulse 5s infinite;
}

.file--uploading > label:hover {
  border-color: rgb(73, 85, 113);
  background-color: rgba(73, 85, 113, 0.3);
}

.file--uploading > label:active {
  background-color:  rgba(73, 85, 113, 0.3);
}
.btn{
  margin:3px;
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
					<h1 class="h3 mb-4 text-gray-800 NanumGothicB">인사관리</h1>
					<div class="row">
						<!-- Area Chart -->
						<div class="col-xl-6 col-lg-6">
							<div class="card shadow mb-4">
								<!-- Card Header - Dropdown -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h5 class="m-0 font-weight-bold text-info">부서별 평균 급여</h5>
								</div>
								<!-- Card Body -->
								<div class="card-body">
									<div class="chart-area">
										<canvas id="salChartForDept"></canvas>
									</div>
								</div>
							</div>
						</div>
						<!-- Area Chart -->
						<div class="col-xl-6 col-lg-6">
							<div class="card shadow mb-4">
								<!-- Card Header - Dropdown -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h5 class="m-0 font-weight-bold text-info">직급별 평균 급여</h5>
								</div>
								<!-- Card Body -->
								<div class="card-body">
									<div class="chart-area">
										<canvas id="salChartForClass"></canvas>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="row">
						<!-- Area Chart -->
						<div class="col-xl-12 col-lg-12">
							<div class="card shadow mb-4">
								<!-- Card Header - Dropdown -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<div class="input-group" align="right">
										<!-- <form id="uploadForm" method="post"
											enctype="multipart/form-data">
									      <input type='file' name="excelFile" id="excelFile"/>
									      <input type="button" onclick="uploadProcess()" value="submit">
										</form> -->
										<form id="uploadForm" method="post"
											enctype="multipart/form-data">
										<div class='file file--uploading ' >
											<label for='excelFile'>
										      <i class="far fa-folder"></i>File
										    </label>
									      <input type='file' name="excelFile" id="excelFile"/>
									      <!--  -->
									      <!-- <input type="button" class="btn btn-info" onclick="uploadProcess()" value="upload"> -->
									    </div> 
										</form>
										
									</div>
									<div class="d-flex justify-content-between">
										<input type="button" class="btn btn-info" onclick="uploadProcess()" value="제출">
										<a href="/HR_management/SalaryExcelForm.do"> 
											<input type="button" class="form-control btn btn-info" value="양식 다운">
										</a>
									</div>
								</div>
								<!-- Card Body -->
								<div class="card-body">
									<div class="row justify-content-center mx-2 mt-1">
										<table id="salary_table" class="table text-center">
											<thead>
												<tr>
													<th>지급일자</th>
													<th>성 명</th>
													<th>사 번</th>
													<th>부 서</th>
													<th>지급 총액</th>
													<th>공제 총액</th>
													<th>실 수령액</th>
													<th>급여 상세</th>
												</tr>
											</thead>
											<tbody id="salaryTbl">
												<c:forEach var="list" items="${list}">
													<tr>
														<td>${fn:substring(list.SAL_DATE,0,4)}년
															${fn:substring(list.SAL_DATE,5,7)}월
															${fn:substring(list.SAL_DATE,8,10)}일</td>
														<td>${list.ename}</td>
														<td>${list.EMPNO}</td>
														<td>${list.deptname}</td>
														<td><fmt:formatNumber
																value="${list.basic_pay+list.overtime_pay+list.position_pay+list.bonus+list.maintenance_of_vehicle+list.educational_supports+list.mess_allowance}"
																type="number" /></td>
														<td><fmt:formatNumber
																value="${list.income_tax + list.local_income_tax + list.health_insurance + list.care_insurance + list.employment_insurance + list.national_pension}"
																type="number" /></td>
														<td><fmt:formatNumber
																value="${list.basic_pay+list.overtime_pay+list.position_pay+list.bonus+list.maintenance_of_vehicle+list.educational_supports+list.mess_allowance
										- (list.income_tax + list.local_income_tax + list.health_insurance + list.care_insurance + list.employment_insurance + list.national_pension)}"
																type="number" /></td>
														<td><button class="btn btn-primary salaryDetail"
																value="${fn:substring(list.SAL_DATE,0,10)},${list.EMPNO}">보기

															</button> <input type="text" class="date"
															value="${fn:substring(list.SAL_DATE,0,10)}" hidden /> <input
															type="text" class="empno" value="${list.EMPNO}" hidden /></td>
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

	<!-- End of Footer 모듈화 -->
	<!-- 모든 스크립트 모듈화 -->
	<jsp:include page="/WEB-INF/views/inc/BottomLink.jsp"></jsp:include>
	<script>
		$(document).on(
				"click",
				".salaryDetail",
				function() {
					var date = $(this).val().split(',')[0]
					var empno = $(this).val().split(',')[1]
					console.log(date);
					console.log(empno);
					var windowW = 690; // 창의 가로 길이
					var windowH = 800; // 창의 세로 길이
					var left = Math.ceil((window.screen.width - windowW) / 2);
					var top = Math.ceil((window.screen.height - windowH) / 2);
					window.open(
							"${pageContext.request.contextPath}/HR_management/SalaryDetail.do?date="
									+ date + "&empno=" + empno, +"_blank",
							"top=" + top + ", left=" + left + ", height="
									+ windowH + ", width=" + windowW
									+ "resizable=no");
				});
	</script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
	<link rel="stylesheet"
		href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="/resources/js/Hr_management/excelUpload.js"></script>
	<script src="/resources/js/Hr_management/salaryPaging.js"></script>
	
	<script src="/resources/js/Hr_management/salary-chart2.js"></script>
</body>
<script type="text/javascript">
$(function(){
	$('#collapseHRM').addClass('show');
	$('#collapseHRM').prev().removeClass('collapsed');
	$('#collapseHRM').prev().children().css("color","#fff");
	
	
})
</script>

</html>