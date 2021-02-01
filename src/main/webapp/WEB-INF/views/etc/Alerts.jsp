<!-- 
    파일명 : Salary.jsp
    설명 : 인사정보 - 급여명세 페이지
    작성일 : 2020-12-28
    작성자 : 박채연
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">알림목록</h6>
						</div>
						<div class="card-body h-100">
							<div class="table-responsive">
								<div class="list-group ">
									<div class="row h-100">
										<div class="col-xl-1 col-lg-1 d-flex  justify-content-center align-items-center pr-0">
												<i class="fas fa-user-check text-black"></i>
										</div>
										<div class="col-xl-11 col-lg-11 pl-0">
											<a href="#"
												class="list-group-item list-group-item-action align-items-start">
												<div class="d-flex w-100 justify-content-between">
													<h5 class="mb-1">누가누가누가 올린 N번글</h5>
													날짜
												</div>
												<p class="mb-1">글 제목</p>
											</a>
										</div>
									</div>
									<div class="row">
										<div class="col-xl-1 col-lg-1 d-flex bg-info justify-content-center align-items-center pr-0">
											<div class="icon-circle bg-white">
												<i class="fas fa-check text-info"></i>
											</div>
										</div>
										<div class="col-xl-11 col-lg-11 pl-0">
											<a href="#"
												class="list-group-item list-group-item-action flex-column align-items-start">
												<div class="d-flex w-100 justify-content-between">
													<h5 class="mb-1">누가누가누가 올린 N번글</h5>
													날짜
												</div>
												<p class="mb-1">글 제목</p>
											</a>
										</div>
									</div>
									<div class="row h-100">
										<div class="col-xl-1 col-lg-1 d-flex bg-primary justify-content-center align-items-center pr-0">
											<div class="icon-circle bg-white">
												<i class="fas fa-check text-primary"></i>
											</div>
										</div>
										<div class="col-xl-11 col-lg-11 pl-0">
											<a href="#"
												class="list-group-item list-group-item-action flex-column align-items-start">
												<div class="d-flex w-100 justify-content-between">
													<h5 class="mb-1">누가누가누가 올린 N번글</h5>
													날짜
												</div>
												<p class="mb-1">글 제목</p>
											</a>
										</div>
									</div>
									<a href="#"
										class="list-group-item list-group-item-action flex-column align-items-start">
										<div class="d-flex w-100 justify-content-between">
											<h5 class="mb-1">List group item heading</h5>
											<small class="text-muted">3 days ago</small>
										</div>
										<p class="mb-1">Donec id elit non mi porta gravida at eget
											metus. Maecenas sed diam eget risus varius blandit.</p>
									</a>
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
	<!-- End of Content Wrapper -->



	<!-- Footer 모듈화 -->
	<jsp:include page="/WEB-INF/views/inc/Footer.jsp"></jsp:include>
	<!-- End of Footer 모듈화 -->
	<!-- 모든 스크립트 모듈화 -->
	<jsp:include page="/WEB-INF/views/inc/BottomLink.jsp"></jsp:include>

</body>

</html>