<!-- 
    파일명 : Login.jsp
    설명 : 로그인 페이지
    작성일 : 2020-12-27
    작성자 : 박채연
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
    파일명 : login.html
    설명 : 로그인 페이지
    작성일 : 2020-12-27
    작성자 : 박채연
 -->
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>SB Admin 2 - Login</title>
<!-- Custom fonts for this template-->
<link href="resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<!-- Custom styles for this template-->
<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">
<link href="resources/css/chaeyeon.css" rel="stylesheet">
<style>
p.errorMsg {
	font-size: 0.8rem;
	color: red;
}
</style>
</head>
<body onload="document.frm.empno.focus();" class="bg-gradient-loginpage">
	<div class="container">
		<!-- Outer Row -->
		<div class="row justify-content-center my-5">
			<div class="col-xl-10 col-lg-12 col-md-9 ">
				<div class="card o-hidden border-0 shadow-lg my-5">
					<div class="card-body p-5 ">
						<!-- Nested Row within Card Body -->
						<div class="row">
							<div class="col-lg-6 d-none d-lg-block my-auto text-center">
								<img src="resources/img/logo.png" width="100">
								<br>
								<br>
								<h2>Olive</h2>
								<p class="text-black">the utmost choice to kickstart your career</p>
								<img src="resources/img/6308.jpg" width="400">
							</div>
							<div class="col-lg-6">
								<div class="p-5">
									<div class="text-center">
										<h1 class="h4 text-gray-900 mb-4">Welcome !</h1>
									</div>
									<%-- <c:url value="/Login" /> --%>
									<c:url value="/login" var="loginURL"/>
									<form name="frm" action="${loginURL}" class="user" method="POST">
										<div class="form-group">
											<input class="form-control form-control-user" name="empno" placeholder="사번">
										</div>
										<div class="form-group">
											<input type="password" class="form-control form-control-user" id="exampleInputPassword" name="pwd"
												placeholder="비밀번호">
										</div>
										<div class="form-group">
											<div class="custom-control custom-checkbox small">
												<c:if test="${requestScope.ERROR_MSG != null}">
													<p class="errorMsg">${requestScope.ERROR_MSG}</p>
												</c:if>
												<%-- <c:if test="${param.error != null}"> --%>
													<%-- <p class="errorMsg"><c:out value="${sessionScope.SPRING_SECURITY_LAST_EXCEPTION.message}" /></p> --%>
													<%-- 이 값을 읽어오는 것은 스프링 시큐리티에서 던진 예외가 세션에 담겨 온다. >> 인증 예외 시 세션에 에러 메세지가 들어온다.
													세션에 에러메세지가 들어온다 ? >> 인증되지도 않은 사용자 인증행위 (의도적인 공격 등)가 많아지면? Full GC! >> 세션에
													에러 메세지를 가져와 읽는 것은 독이다. >>>>>>>....
													authentication-success-handler-ref 속성과 failure-ref 속성을 이용해 제어하고, 인증(authentication)과 권한(authorization)을
													커스터마이징할 수 있다.--%>
												<%-- </c:if> --%>
												<input type="checkbox" class="custom-control-input" id="remember-me" name="remember-me">
												<!-- Spring Security Remember-me option 아직 미구현, id&name 고정 -->
												<label class="custom-control-label" for="customCheck">Remember Me </label>
											</div>
										</div>
										<button type="submit" class="btn btn-login btn-user btn-block">Login</button>
										<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> --%>
									</form>
									<hr>
									<div class="text-center">
										<a class="small text-primary" href="/findPassword.do">비밀번호 찾기</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Bootstrap core JavaScript-->
	<script src="resources/vendor/jquery/jquery.min.js"></script>
	<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- Core plugin JavaScript-->
	<script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script>
	<!-- Custom scripts for all pages-->
	<script src="resources/js/sb-admin-2.min.js"></script>
</body>
</html>