<%-- 
    파일명: ProgressDoc.jsp
    설명: 전자결재 - 결재진행함
    작성일: 2020-12-30
    작성자: 박채연
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
<jsp:include page="../inc/HeadLink.jsp"></jsp:include>
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
		<jsp:include page="../inc/Sidebar.jsp"></jsp:include>
		<!-- End Of Sidebar 모듈화 -->
		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<!-- Main Content -->
			<div id="content">
				<jsp:include page="../inc/Topbar.jsp"></jsp:include>
				<!-- Begin Page Content -->
				<div class="container-fluid">
					<!-- Page Heading -->
					<h1 class="h3 text-gray-800">전자결재</h1><span class="my-0 h5">결재진행함</span>
					<div class="card shadow py-0 bg-white my-4">
						<div class="card-header pt-3 pb-0 d-flex flex-row align-items-center justify-content-between">
							<ul class="nav nav-tabs" id="myTab" role="tablist" >
								<li class="nav-item"><button class="nav-link active doc" value="50" id="total" data-toggle="tab" role="tab" aria-controls="home" aria-selected="true">전체 문서</button></li>
								<li class="nav-item"><button class="nav-link doc" value="10" id="app_ready" data-toggle="tab" role="tab" aria-controls="profile" aria-selected="false">대기 문서</button></li>
								<li class="nav-item"><button class="nav-link doc" value="20" id="app_ing" data-toggle="tab" role="tab" aria-controls="contact" aria-selected="false">결재 진행</button></li>
								<li class="nav-item"><button class="nav-link doc" value="30" id="app_cmp" data-toggle="tab" role="tab" aria-controls="contact" aria-selected="false">결재 완료</button></li>
								<li class="nav-item"><button class="nav-link doc" value="40" id="app_rej" data-toggle="tab" role="tab" aria-controls="contact" aria-selected="false">반려 문서</button></li>
								<li class="nav-item"><button class="nav-link" value="60" id="app_ref" data-toggle="tab" role="tab" aria-controls="contact" aria-selected="false">참조 문서</button></li>
							</ul>
						</div>
						
						<div class="card-body-tridiv justify-content-end search-tab row mr-5 mt-4" id="myTabContent"></div>
						<div class="mb-3" id="home" role="tabpanel" aria-labelledby="home-tab">
							<c:set var="appdoc" value="${requestScope.appdoc}" />
							<div class="row justify-content-center mx-5">
								<table class="table text-center">
									<thead>
										<tr>
											<th>문서번호</th>
											<th>분류</th>
											<th>제목</th>
											<th>기안자</th>
											<th>결재 양식</th>
											<th>기안날짜</th>
											<th>결재날짜</th>
											<th>결재 상태</th>
										</tr>
									</thead>
									<tbody id="appBody">
										<c:forEach var="list" items="${pagingList}">
											<tr>
												<td>${list.docno}</td>
												<c:if test="${list.app_check =='1'||list.app_check=='2'}">
													<td>완료</td>
												</c:if>
												<c:if test="${list.app_check=='0'||list.app_check == null}">
													<td>대기</td>
												</c:if>
												<td>
													<a href="viewDocument.do?docno=${list.docno}" name="document">${list.title}</a>
												</td>
												<td>${list.ename }</td>
												<td>${list.typename}</td>
												<td>
													<fmt:formatDate value="${list.writedate}" pattern="yyyy-MM-dd" />
												</td>
												<td>
													<fmt:formatDate value="${list.app_date}" pattern="yyyy-MM-dd" />
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
								<c:set var="page" value="${pagination}"></c:set>
								<nav aria-label="Page navigation example">
									<ul class="pagination" id="pagination">
										<c:if test="${page.prev}">
											<li class="page-item"><a class="page-link page-btn-prev" href="#" aria-label="Previous">
													<span aria-hidden="true">&laquo;</span> <span class="sr-only">Previous</span>
												</a></li>
										</c:if>
										<c:forEach var="paging" begin="${page.startPage}" end="${page.endPage}">
											<li class="page-item"><a class="page-link page-btn" href="#">${paging}</a></li>
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
				<c:set var="criteria" value="${criteria}" />
				<input type="text" value="${criteria.searchType}" id="oldSearchType" hidden>
				<input type="text" value="${criteria.keyword}" id="oldKeyword" hidden>
				<input type="text" value="${criteria.searchType2}" id="oldSearchType2" hidden>
				<input type="text" value="${criteria.keyword2}" id="oldKeyword2" hidden>
				<input type="text" value="${criteria.page}" id="oldPage" hidden>
				<input type="text" value="${criteria.perPageNum}" id="oldPerPageNum" hidden>
				<!-- /.container-fluid -->
			</div>
			<!-- End of Main Content -->
			<!-- Footer 모듈화 -->
			<jsp:include page="../inc/Footer.jsp"></jsp:include>
			<!-- End of Footer 모듈화 -->
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
	<script src="/resources/js/Approval/progressDoc.js">
	
	</script>
</body>
</html>