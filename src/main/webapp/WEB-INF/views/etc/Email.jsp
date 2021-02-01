<!-- 
	파일명: Email.jsp
	설명: 이메일 홈페이지 
	작성일 : 2020-12-28
	작성자 : 심재형 
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>SB Admin 2 - Forgot Password</title>
<!-- Custom fonts for this template-->
<link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<!-- Custom styles for this template-->

<link href="/resources/css/sb-admin-2.css" rel="stylesheet">

<style>

html, body {
	background: url('/resources/img/Login.png');
    background-size: cover; 
    overflow: hidden;
    margin: 0;
    height: 100%;

}
h1{
  font-size: 40px;
  color: #ddd;
  text-shadow: 3px 3px 10px #000;
}

.loader {
  border: 16px solid #f3f3f3;
  border-radius: 50%;
  border-top: 16px solid #62B942;
  border-bottop: 16px solid #62B942; 
  width: 120px;
  height: 120px;
  animation: spin 2s linear infinite;
  
  position: absolute;
  top: 40%;
  left: 50%;
  box-shadow: 0px 0px 50px #888888;
  /* transform: translateX(-50%); */
  visibility: hidden;
  oppacity: 0;
  transition:all 0.3s;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.swal-overlay {
  background-color: rgba(43, 165, 137, 0.45);
}

#emailPage{
  border-radius: 5px;
  background: rgba(3,3,3,0.25);
  box-shadow: 1px 1px 50px #000;
}

.valid-form-control:focus {
  background-color: #fff;
  border-color: #0bbf14;
  outline: none;
  box-shadow: 0 0 0 0.3rem rgba(11, 191, 20, 0.5);
}

.invalid-form-control:focus {
  background-color: #fff;
  border-color: #eb4034;
  outline: none;
  box-shadow: 0 0 0 0.3rem rgba(235, 64, 52, 0.5);
}
</style>


</head>
<body>
	<div class="container h-100">
		<!-- Outer Row -->
		<div class="row justify-content-center h-100">
			<div class="col-xl-6 col-lg-6 col-md-6 align-self-center">
					<div class="card-body p-0">
						<!-- Nested Row within Card Body -->
						<div class="row">
							
							<div class="col-lg-10 mx-auto" id="emailPage">
								<div class="p-5">

									<div class="text-center">
										<sec:authentication var="principal" property="principal" />
										<h1 class="h4 mb-5" >이메일 인증</h1>
										<p class="mb-4" style="color:white;">
											${principal.username} 님 환영합니다!
											<br>이메일 인증을 통해 OLIVE를 사용해보세요
										</p>
									</div>
									<form method="POST" class="user" id="emailForm">
										<div class="form-group">
											<input type="email" class="form-control form-control-user" id="email" name="email"
												aria-describedby="emailHelp" placeholder="Enter 이메일 주소..." required>
												<span id="checkEmail"></span>
										</div>
										<button type="button" id="submitBtn" class="btn btn-primary btn-user btn-block" style="margin-bottom: 30px">인증번호
											발송</button>
									</form>
									<form class="user">
										<div class="form-group" id="codeForm">
											<input type="number" class="form-control form-control-user" id="code" name="code"
												aria-describedby="emailHelp" placeholder="Enter 이메일 인증코드..." readonly>
										</div>
										<button type="button" id="finalCheck" class="btn btn-secondary btn-user btn-block" disabled>인증하기</button>
									</form>
									<hr>
									<div class="form-group" id="goToMain">
									
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	<div class="loader"></div>
	<!-- Bootstrap core JavaScript-->
	<script src="/resources/vendor/jquery/jquery.min.js"></script>
	<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- Core plugin JavaScript-->
	<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
	<!-- Custom scripts for all pages-->
	<script src="/resources/js/sb-admin-2.min.js"></script>
	<!-- SweetAlert -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<!-- Email validation JavaScript -->
	<script src="/resources/js/email.js"></script>
</body>
</html>