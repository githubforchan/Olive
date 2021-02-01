<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
	aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Logout</h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">로그아웃하시겠습니까 ?</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
				
				<!-- Spring Security Logout basic Form -->
				<c:url value="/logout" var="logoutURL"/>
				<form action="${logoutURL}" method="POST">
					<input type="submit" class="btn btn-primary" value="Logout" />
					<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> --%>
				</form> 
				
				
			</div>
		</div>
	</div>
</div>