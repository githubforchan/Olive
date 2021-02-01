<%-- 
    파일명: Sidebar.jsp
    설명: 사원에 따라 로그인 시 메뉴 노출내용이 달라지는 사이드바 모듈화한 페이지
    작성일: 2020-12-26
    작성자: 백희승
--%>
<!-- 
	파일명: Sidebar.jsp
    설명: 사이드바 권한 설정 
    작성일: 2021-01-17
    작성자: 박선우
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
	<!-- Sidebar - Brand -->
	<a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/goToMain.do">
		<div class="sidebar-brand-icon">
			<img src="/resources/img/logo.png" width="60%">
		</div>
	</a>
	<!-- Divider -->
	<sec:authorize access="isAuthenticated()">
	<sec:authorize access="hasRole('ROLE_GENERAL')">
	<hr class="sidebar-divider">
		<!-- Heading -->
		<div class="sidebar-heading">Attendance</div>
		<!-- Nav Item - Pages Collapse Menu -->
		<li class="nav-item"><a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseAtt" aria-expanded="true" aria-controls="collapseAtt">
				<i class="fas fa-fw fa-user-clock"></i> <span>근태관리</span>
			</a>
			<div id="collapseAtt" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
				<div class="bg-white py-2 collapse-inner rounded">
					<div class="collapse-divider"></div>
					<a class="collapse-item" href="${pageContext.request.contextPath}/attendance/attendance.do">근태 관리</a>
					<a class="collapse-item" href="${pageContext.request.contextPath}/attendance/annual.do">휴가 관리</a>
				</div>
			</div></li>
		<!-- Divider -->
		<sec:authorize access="hasRole('ROLE_HR')">
		<hr class="sidebar-divider">
		<!-- Heading -->
		<div class="sidebar-heading">HRM</div>
		<!-- Nav Item - Pages Collapse Menu -->
		<li class="nav-item"><a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseHRM" aria-expanded="true" aria-controls="collapseHRM">
				<i class="fas fa-fw fa-users"></i> <span>인사관리</span>
			</a>
			<div id="collapseHRM" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
				<div class="bg-white py-2 collapse-inner rounded">
					<a class="collapse-item" href="${pageContext.request.contextPath}/HR_management/Organization.do">조직 관리</a>
					<a class="collapse-item" href="${pageContext.request.contextPath}/HR_management/Salary.do">급여 관리</a>
					<a class="collapse-item" href="${pageContext.request.contextPath}/HR_management/EmployeeAttendance.do">근태/휴가 관리</a>
				</div>
			</div></li>
		<!-- Divider -->
		</sec:authorize>
		<hr class="sidebar-divider">
		<!-- Heading -->
		<div class="sidebar-heading">Electronic Approval</div>
		<!-- Nav Item - Pages Collapse Menu -->
		<li class="nav-item"><a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseEA" aria-expanded="true" aria-controls="collapseEA">
				<i class="fas fa-fw fa-folder-open"></i> <span>전자결재</span>
			</a>
			<div id="collapseEA" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
				<div class="bg-white py-2 collapse-inner rounded">
					<a class="collapse-item" href="${pageContext.request.contextPath}/approval/ApprovalHome.do">전자결재 홈</a>
					<a class="collapse-item" href="${pageContext.request.contextPath}/approval/DocWrite.do">기안하기</a>
					<a class="collapse-item" href="${pageContext.request.contextPath}/approval/PersonalDoc.do">개인 문서함</a>
					<a class="collapse-item" href="${pageContext.request.contextPath}/approval/ProgressDoc.do">결재 진행함</a>
					<div class="collapse-divider"></div>
					<sec:authorize access="hasRole('ROLE_HR')">
					<a class="collapse-item" href="${pageContext.request.contextPath}/approval/AddForm.do">양식관리</a>
					</sec:authorize>
				</div>
			</div></li>
	</sec:authorize>		
	
	<!-- Divider -->
	<hr class="sidebar-divider">
	<!-- Heading -->
	<div class="sidebar-heading">Informations</div>
	<!-- Nav Item - Pages Collapse Menu -->
	<li class="nav-item"><a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseInfo" aria-expanded="true" aria-controls="collapseInfo">
			<i class="fas fa-fw fa-users"></i> <span>인사정보</span>
		</a>
		<div id="collapseInfo" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<a class="collapse-item" href="${pageContext.request.contextPath}/HRinfo/Salary.do">급여 정보</a>
				<a class="collapse-item" href="${pageContext.request.contextPath}/HRinfo/Emp.do">직원 목록</a>
				<a class="collapse-item" href="${pageContext.request.contextPath}/HRinfo/Organization_chart.do">회사 조직도</a>
				<a class="collapse-item" href="${pageContext.request.contextPath}/HRinfo/EditMyinfo.do">내 정보 수정하기</a>
			</div>
		</div></li>
	<!-- Divider -->
	<hr class="sidebar-divider">
	</sec:authorize>
	<!-- Sidebar Toggler (Sidebar) -->
	<div class="text-center d-none d-md-inline">
		<button class="rounded-circle border-0" id="sidebarToggle"></button>
	</div>
</ul>
<!-- End of Sidebar -->