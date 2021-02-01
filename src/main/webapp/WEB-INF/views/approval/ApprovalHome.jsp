<%-- 
    파일명: approvalHome.jsp
    설명: 전자결재 홈 페이지
    작성일: 2020-12-28
    작성자: 백희승
--%>
<!-- 
	파일명: approvalHome.jsp
    설명: 전자결재 홈 페이지 백단 작업
	작성일 : 2021-01-04
	작성자 : 박선우
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Project_HR</title>
<!-- 스타일시트, CDN 모듈화 -->
<jsp:include page="/WEB-INF/views/inc/HeadLink.jsp"></jsp:include>
<style type="text/css">
h1{
	text-decoration: underline;
	font-weight: bold;
	text-decoration-color: #ffe561;
	text-decoration-thickness: 5px;
}
/* 채연 */
.styled-table {
	border-collapse: collapse;
	margin: 25px 0;
	font-size: 1em;
	min-width: 100%;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
}

.styled-table thead tr {
	background-color: #86A8E7;
	color: #ffffff;
}

.styled-table th, .styled-table td {
	padding: 12px 15px;
}

.styled-table tbody tr {
	border-bottom: 1px solid #dddddd;
}

.styled-table tbody tr:nth-of-type(even) {
	background-color: #f3f3f3;
}

.styled-table tbody tr:last-of-type {
	border-bottom: 2px solid #7F7FD5;
}

.button {
	width: 100px;
	background-color: #7F7FD5;
	border: none;
	color: #fff;
	padding: 10px 0;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 15px;
	margin: 4px;
	cursor: pointer;
	border-radius: 10px;
}
/* //채연 */
h6.text-primary>i.fas {
	font-size: 1.15rem;
}

.text-goup {
	color: #00FF40;
}

.text-godown {
	color: #FF8000;
}

.border-none {
	border: none;
}

.text-sm {
	font-size: .9rem;
}

.list-bt {
	border-bottom: 1px solid rgba(0, 0, 0, .125);
}

.card-for-flex {
	display: flex;
}

.card-body-tridiv {
	flex: 1 1 auto;
}

.search-tab {
	max-width: 200px;
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
				<!-- Begin Page Content -->
				<div class="container-fluid">
					<!-- Page Heading -->
					<div class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 text-gray-800">전자결재</h1>
					</div>
					<!-- 결재 정리된 UI -->
					<div class="row">
						<!-- 내가 올린 결재 : 부트스트랩 list-group 이용 -->
						<div class="col-xl-6 col-lg-6">
							<div class="card  shadow mb-4">
								<div class="card-header">
									<div class="font-weight-bold h5 text-uppercase text-info mb-1">개인문서함</div>
								</div>
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<c:set var="doclist" value="${requestScope.document }" />
											<c:set var="arrangedList" value="${requestScope.arrangedDoc }" />
											<div class="mb-0 font-weight-bold text-sm">
												<div class="row">
													<div class="col-md-6 ">
														<ul class="list-group" style="padding:30px;">
															<li class="list-group-item  d-flex justify-content-between align-items-center" style="border: 0px; padding: 0px; font-size: 20px;">기안함 <span class="badge mr-3">${arrangedList.doc_ready.size()}</span>
															</li>
															<li class="list-group-item d-flex justify-content-between align-items-center" style="border: 0px; padding: 0px; font-size: 20px;">결재중 <span class="badge mr-3">${arrangedList.doc_ing.size()}</span>
															</li>
															<li class="list-group-item d-flex  justify-content-between align-items-center" style="border: 0px; padding: 0px; font-size: 20px;">결재완료됨 <span class="badge mr-3">${arrangedList.doc_cmp.size()}</span>
															</li>
															<li class="list-group-item d-flex justify-content-between align-items-center" style="border: 0px; padding: 0px; font-size: 20px;">반려됨 <span class="badge mr-3">${arrangedList.doc_rej.size()}</span>
															</li>
														</ul>
													</div>
													<div class="col-md-6">
														<canvas id="document-chart"></canvas>
													</div>
												</div>
											</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-level-up-alt fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 내가 받은 결재 -->
						<c:set var="applist" value="${requestScope.approver}" />
						<c:set var="arrangedAppList" value="${requestScope.arrangedAppDoc }" />
						<div class="col-xl-6 col-lg-6">
							<div class="card shadow mb-4">
								<div class="card-header">
									<div class="font-weight-bold h5 text-uppercase text-info mb-1">결재진행함</div>
								</div>
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div class="mb-0 font-weight-bold text-sm">
												<div class="row">
													<div class="col-md-6">
														<ul class="list-group" style="padding:30px">
															<li class="list-group-item bdn d-flex justify-content-between align-items-center " style="border: 0px; padding: 0px; font-size: 20px;">처리요망 <span class="badge mr-3">${arrangedAppList.doc_ready.size()}</span>
															</li>
															<li class="list-group-item  d-flex justify-content-between align-items-center" style="border: 0px; padding: 0px; font-size: 20px;">진행중 <span class="badge mr-3">${arrangedAppList.doc_ing.size()}</span>
															</li>
															<li class="list-group-item d-flex justify-content-between align-items-center" style="border: 0px; padding: 0px; font-size: 20px;">결재완료함 <span class="badge mr-3">${arrangedAppList.doc_cmp.size()}</span>
															</li>
															<li class="list-group-item  d-flex justify-content-between align-items-center" style="border: 0px; padding: 0px; font-size: 20px;">반려함 <span class="badge mr-3">${arrangedAppList.doc_rej.size()}</span>
															</li>
														</ul>
													</div>
													<div class="col-md-6">
														<canvas id="Approval-chart"></canvas>
													</div>
												</div>
											</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-level-down-alt fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- 내가 올린 결재 컨텐츠 시작 -->
					<div class="row">
						<div class="col-xl-12 col-lg-12">
							<div class="card shadow mb-4">
								<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h5 class="m-0 font-weight-bold text-info">내가 최근 올린 결재</h5>
									<!-- 바로가기 버튼 : -->
									<div class="">
										<a class="" href="/approval/PersonalDoc.do" role="button">
											<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
  <path
													d="M19.2928932,4 L16.5,4 C16.2238576,4 16,3.77614237 16,3.5 C16,3.22385763 16.2238576,3 16.5,3 L20.5,3 C20.7761424,3 21,3.22385763 21,3.5 L21,7.5 C21,7.77614237 20.7761424,8 20.5,8 C20.2238576,8 20,7.77614237 20,7.5 L20,4.70710678 L14.8535534,9.85355339 C14.6582912,10.0488155 14.3417088,10.0488155 14.1464466,9.85355339 C13.9511845,9.65829124 13.9511845,9.34170876 14.1464466,9.14644661 L19.2928932,4 L19.2928932,4 Z M20,11.5 C20,11.2238576 20.2238576,11 20.5,11 C20.7761424,11 21,11.2238576 21,11.5 L21,18.5 C21,19.8807119 19.8807119,21 18.5,21 L5.5,21 C4.11928813,21 3,19.8807119 3,18.5 L3,5.5 C3,4.11928813 4.11928813,3 5.5,3 L12.5,3 C12.7761424,3 13,3.22385763 13,3.5 C13,3.77614237 12.7761424,4 12.5,4 L5.5,4 C4.67157288,4 4,4.67157288 4,5.5 L4,18.5 C4,19.3284271 4.67157288,20 5.5,20 L18.5,20 C19.3284271,20 20,19.3284271 20,18.5 L20,11.5 Z"
												/>
</svg>
										</a>
									</div>
								</div>
								<!-- 내가 올린 결재 card-body -->
								<div class="card-body px-2 py-0 mb-2">
									<div class="card-for-flex mb-0">
										<div class="card-body-tridiv search-tab"></div>
										<div class="card-body-tridiv">
											<!-- 3분할공간차지 -->
										</div>
										<div class="card-body-tridiv mb-1"></div>
									</div>
									<div class="row justify-content-center mx-5">
										<table id="salary_table" class="table text-center my-2">
											<thead>
												<tr>
													<th>문서번호</th>
													<th>분류</th>
													<th>문서 제목</th>
													<th>기안자</th>
													<th>기안일</th>
													<th>진행 상태</th>
												</tr>
											</thead>
											<tbody id="inputState_docBody">
												<c:forEach var="list" items="${doclist}">
													<tr>
														<td>${list.docno }</td>
														<td>${list.typeName}</td>
														<td>${list.title}</td>
														<td>${list.ename}</td>
														<td>
															<fmt:formatDate value="${list.writedate}" pattern="yyyy-MM-dd" />
														</td>
														<td>${list.statusName}</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
								<!-- //내가 올린 결재 card-body -->
							</div>
						</div>
					</div>
					<!-- 내가 받은 결재 컨텐츠 시작 -->
					<div class="row">
						<div class="col-xl-12 col-lg-12">
							<div class="card  shadow mb-4">
								<!-- Card Header - Dropdown -->
								<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h5 class="m-0 font-weight-bold text-info">내가 최근 받은 결재</h5>
									<!-- 옵션 버튼 : -->
									<div class="">
										<a class="" href="/approval/ProgressDoc.do" role="button">
											<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
  <path
													d="M19.2928932,4 L16.5,4 C16.2238576,4 16,3.77614237 16,3.5 C16,3.22385763 16.2238576,3 16.5,3 L20.5,3 C20.7761424,3 21,3.22385763 21,3.5 L21,7.5 C21,7.77614237 20.7761424,8 20.5,8 C20.2238576,8 20,7.77614237 20,7.5 L20,4.70710678 L14.8535534,9.85355339 C14.6582912,10.0488155 14.3417088,10.0488155 14.1464466,9.85355339 C13.9511845,9.65829124 13.9511845,9.34170876 14.1464466,9.14644661 L19.2928932,4 L19.2928932,4 Z M20,11.5 C20,11.2238576 20.2238576,11 20.5,11 C20.7761424,11 21,11.2238576 21,11.5 L21,18.5 C21,19.8807119 19.8807119,21 18.5,21 L5.5,21 C4.11928813,21 3,19.8807119 3,18.5 L3,5.5 C3,4.11928813 4.11928813,3 5.5,3 L12.5,3 C12.7761424,3 13,3.22385763 13,3.5 C13,3.77614237 12.7761424,4 12.5,4 L5.5,4 C4.67157288,4 4,4.67157288 4,5.5 L4,18.5 C4,19.3284271 4.67157288,20 5.5,20 L18.5,20 C19.3284271,20 20,19.3284271 20,18.5 L20,11.5 Z"
												/>
</svg>
										</a>
									</div>
								</div>
								<!-- 결재 홈 테이블 -->
								<div class="card-body px-2 py-0 mb-2">
									<div class="card-for-flex mb-1">
										<div class="card-body-tridiv search-tab">
											<!-- //비동기로 DB다녀오는 친구들 -->
										</div>
										<div class="card-body-tridiv">
											<!-- 3분할공간차지 -->
										</div>
										<div class="card-body-tridiv">
											<!-- 3분할공간차지 -->
										</div>
									</div>
									<div class="row justify-content-center mx-5">
										<table id="salary_table" class="table text-center my-2">
											<thead>
												<tr>
													<th>문서번호</th>
													<th>분류</th>
													<th>문서 제목</th>
													<th>기안자</th>
													<th>기안일</th>
													<th>진행 상태</th>
												</tr>
											</thead>
											<tbody id="inputState_appBody">
												<c:forEach var="list" items="${applist}">
													<tr>
														<td>${list.docno}</td>
														<c:if test="${list.app_Check eq 1 || list.app_Check eq 2}">
															<td>완료</td>
														</c:if>
														<c:if test="${list.app_Check eq 0 || list.app_Check == null}">
															<td>대기</td>
														</c:if>
														<td>${list.title}</td>
														<td>${list.ename}</td>
														<td>
															<fmt:formatDate value="${list.writedate}" pattern="yyyy-MM-dd" />
														</td>
														<td>
															<div class="progress">
																<div class="progress-bar" role="progressbar" style="width:${(list.curr_Approval/list.total_Approval)*100}%;" aria-valuenow="${list.curr_Approval }" aria-valuemin="0" aria-valuemax=>${list.curr_Approval }/${list.total_Approval }</div>
															</div>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
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
	<!-- 모든 스크립트 모듈화 -->
	<jsp:include page="../inc/BottomLink.jsp"></jsp:include>
</body>
<script type="text/javascript">

$(function(){
	$('#collapseEA').addClass('show');
	$('#collapseEA').prev().removeClass('collapsed');
	$('#collapseEA').prev().children().css("color","#fff");
	
	//파이차트 for document
	var ctx2 = $("#document-chart");
	var chart2 = new Chart(ctx2, {
		type : 'doughnut',
		data : {
			labels : [ "기안", "결재중", "결재완료","반려" ],
			datasets : [ {
				data : [${arrangedList.doc_ready.size()}, ${arrangedList.doc_ing.size()}, ${arrangedList.doc_cmp.size()}, ${arrangedList.doc_rej.size()}],
				backgroundColor : [ 'rgb(78,115,223,.5)', 'rgb(28,100,138,.5)', 'rgb(54,185,204,.5)','rgb(234,86,72,.5)' ],
				hoverBackgroundColor : [ '#2e59d9', '#17a673', '#2c9faf','#ff0033' ],
				hoverBorderColor : "rgba(234, 236, 244, 1)",
			} ],
		},
		options : {
			maintainAspectRatio : false,
			tooltips : {
				backgroundColor : "rgb(255,255,255)",
				bodyFontColor : "#858796",
				borderColor : '#dddfeb',
				borderWidth : 1,
				xPadding : 15,
				yPadding : 15,
				displayColors : false,
				caretPadding : 10,
			},
			legend : {
				display : false
			},
			cutoutPercentage : 80
		}
	})

	//파이차트 for 결재문서
	var ctx2 = $("#Approval-chart");
	var chart2 = new Chart(ctx2, {
		type : 'doughnut',
		data : {
			labels : [ "결재대기", "결재 진행중", "결재완료","반려" ],
			datasets : [ {
				data : [${arrangedAppList.doc_ready.size()}, ${arrangedAppList.doc_ing.size()}, ${arrangedAppList.doc_cmp.size()}, ${arrangedAppList.doc_rej.size()}],
				backgroundColor : [ 'rgba(242,166,54,.5)', 'rgba(39,79,76,.5)', 'rgba(40,161,130,.5)','rgba(206,29,22,.5)' ],
				hoverBackgroundColor : [ 'rgb(242,166,54)', 'rgb(39,79,76)', 'rgb(40,161,130)','rgb(206,29,22)' ],
				hoverBorderColor : "rgba(234, 236, 244, 1)",
			} ],
		},
		options : {
			maintainAspectRatio : false,
			tooltips : {
				backgroundColor : "rgb(255,255,255)",
				bodyFontColor : "#858796",
				borderColor : '#dddfeb',
				borderWidth : 1,
				xPadding : 15,
				yPadding : 15,
				displayColors : false,
				caretPadding : 10,
			},
			legend : {
				display : false
			},
			cutoutPercentage : 80
		}
	})


	
			

	
	
})		

	
</script>
</html>