<!-- 
    파일명 : Login.jsp
    설명 : 로그인 페이지
    작성일 : 2020-12-27
    작성자 : 박채연
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link href='/resources/css/login.css' rel='stylesheet' />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="/resources/js/login.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.6.0/gsap.min.js"></script>
<link rel="icon" href="/resources/img/logo_favicon.png" type="image/x-icon">
</head>

<body>

	<div id="login-button">
		<img src="/resources/img/lo5.png"></img>
	</div>

	<div id="container">
		<h1>OLIVE</h1>
		<span class="close-btn"> <img
			src="https://cdn4.iconfinder.com/data/icons/miu/22/circle_close_delete_-128.png"></img>
		</span>


		<c:url value="/login" var="loginURL" />
		<form name="frm" action="${loginURL}" id="loginform" class="user" method="POST">
			<div class="form-group">
				<input class="form-control" placeholder="사번" form-control-user" name="empno">
			</div>
			<div class="form-group">
				<input type="password" placeholder="비밀번호"
					class="form-control form-control-user" id="exampleInputPassword"
					name="pwd">
			</div>
			<div class="form-group">
				<div class="custom-control custom-checkbox small">
					<c:if test="${requestScope.ERROR_MSG != null}">
						<p class="errorMsg">${requestScope.ERROR_MSG}</p>
					</c:if>
				</div>
			</div>
			<br><br>
			<div class="form-group mt-5">
				<a href="#" id="submit" class="orange-btn">Login</a>
				<a href="/findPassword.do" class="white-btn">Password</a>
			</div>
			
		</form>
		
	</div>
	<c:if test="${requestScope.ERROR_MSG != null}">
	<script>
	jb('#login-button').fadeOut("fast", function() {
			jb("#container").fadeIn();
			TweenMax.from("#container", .4, {
				scale : 0,
				ease : Sine.easeInOut
			});
			TweenMax.to("#container", .4, {
				scale : 1,
				ease : Sine.easeInOut
			});
		});
	</script>
	</c:if>
	
</body>
	
	
	
	
	<!-- SweetAlert -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<!-- Email validation JavaScript -->
	<script src="/resources/js/email.js"></script>
</html>