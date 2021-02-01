<!-- 
    파일명 : EditMyinfo.jsp
    설명 : 인사정보 - 내정보 수정 페이지
    작성일 : 2020-12-29
    작성자 : 박채연
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>Emp</title>

<!-- 스타일시트, CDN 모듈화 -->
<jsp:include page="/WEB-INF/views/inc/HeadLink.jsp"></jsp:include>
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
h1 {
	text-decoration: underline;
	font-weight: bold;
	text-decoration-color: #ffe561;
	text-decoration-thickness: 5px;
}

#saveBtn {
	display: none;
}

#alert {
	display: none;
}

.scroll {
	max-height: 70vh;
	overflow-y: auto;
}

/* 		테이블 수정 필요 !  */
table {
	padding: 30px 30px;
	margin-top: 30px;
	margin-bottom: 20px;
	width: 80%;
}

table td {
	padding: 12px 15px;
	vertical-align: middle;
}

table tr {
	text-align: left;
	font-size: 18px;
}

table tr td:first-child {
	width: 30%;
	color: #96a2af;
}

table tr td:last-child {
	width: 100%;
	border-bottom: 1px solid #ddd;
	color: #384a5e;
	font-family: IBMPlexSansKR-SemiBold;
	font-style: normal;
	font-weight: normal;
}

.title {
	text-decoration: underline;
	font-weight: bold;
	text-decoration-color: #ffe561;
	text-decoration-thickness: 5px;
	font-size: 22px;
	color: #3e5165;
}

/* profile file */
#profile_img_upload {
	width: 0.1px;
	height: 0.1px;
	opacity: 0;
	overflow: hidden;
	position: absolute;
	z-index: -1;
}

#profile_img_upload+label {
	border: 1px solid #d9e1e8;
	background-color: #fff;
	color: #2b90d9;
	border-radius: 2rem;
	padding: 8px 17px 8px 17px;
	font-weight: 500;
	font-size: 15px;
	box-shadow: 1px 2px 3px 0px #f2f2f2;
	outline: none;
}

#profile_img_upload:focus+label, #profile_img_upload+label:hover {
	cursor: pointer;
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
					<h1 class="h3 mb-4 text-gray-800">인사정보</h1>



					<div class="row justify-content-center">
						<!-- <div class="container rounded bg-white mt-5"> -->
						<div class="card shadow py-2 bg-white my-5" style="width: 80%;">
							<c:set var="emp" value="${emp}" />

							<div class="row justify-content-center">
								<div class="col-md-5 border-right my-auto">

									<div
										class="d-flex flex-column align-items-center text-center p-3">
										<img id="preview" class="mt-5 rounded-circle"
											src="/resources/upload/${emp.PIC}" width="120"
											onerror="this.src='/resources/img/undraw_profile_1.svg'">




										<span class="font-weight-bold mt-3">${emp.EMPNO}</span> <span
											class="font-weight-bold mt-3">${emp.ENAME}</span>
										<h1></h1>
										<div class="mt-5 text-center"></div>

										<button id="editBtn" class="btn btn-primary profile-button">Edit
											Profile</button>
										<button id="saveBtn" class="btn btn-primary profile-button">Save
											Profile</button>
									</div>

								</div>
								<div class="col-md-7 ">
									<div class="p-5 scroll">

										<p class="title">인사정보</p>
										<table id="hr_info" class="mb-5">

											<tbody>
												<tr>
													<td>본부</td>
													<td>${emp.HEADNAME}</td>
												</tr>
												<tr>
													<td>부서</td>
													<td>${emp.DEPTNAME}</td>
												</tr>
												<tr>
													<td>직위</td>
													<td>${emp.CLASSNAME}</td>
												</tr>
												<tr>
													<td>직책</td>
													<td>${emp.POSITIONNAME}</td>
												</tr>
												<tr>
													<td>입사일</td>
													<td>${emp.HIREDATE}</td>
												</tr>
											</tbody>
										</table>

										<p class="title">개인정보</p>
										<div id="personal">
											<table id="personal_info">

												<tbody>
													<tr>
														<td>사번</td>
														<td>${emp.EMPNO}</td>
													</tr>
													<tr>
														<td>이름</td>
														<td>${emp.ENAME}</td>
													</tr>
													<tr>
														<td>이메일</td>
														<td>${emp.EMAIL}</td>
													</tr>
													<tr>
														<td>휴대전화</td>
														<td>${emp.PHONE}</td>
													</tr>
													<tr>
														<td>집주소</td>
														<td>${emp.ADDRESS}</td>
													</tr>
												</tbody>
											</table>
											<!-- input 수정 폼 -->
											<form id="editform" name="editform"
												action="<%=request.getContextPath()%>/HRinfo/updateMyInfo.do"
												method="POST" enctype="multipart/form-data">
												<div class="form-group row">
													<div class="col-md-10">
														<input type="file" id="profile_img_upload" name="file"
															class="file" accept="image/*"> <label
															for="profile_img_upload"><i
															class="far fa-file-image"></i>&nbsp;Profile Image</label>
													</div>
												</div>
												<input name="empNo" id="empNo" type="text"
													class="form-control" placeholder="사번" value="${emp.EMPNO}"
													hidden> <input name="ename" id="ename" type="text"
													class="form-control" placeholder="이름" value="${emp.ENAME}"
													hidden>
												<div class="form-group row mt-4">
													<div class="col-md-10">
														<p>비밀번호</p>
														<input name="pwd" id="pwd" type="text"
															class="form-control" placeholder="새 비밀번호">
														<div id="alert" class="alert alert-danger">비밀번호는 필수입력값입니다.</div>
													</div>

												</div>
												<div class="form-group row mt-4">
													<div class="col-md-10">
														<p>이메일</p>
														<input name="email" id="email" type="text"
															class="form-control" placeholder="이메일"
															value="${emp.EMAIL}">
													</div>

												</div>

												<div class="form-group row mt-4">
													<div class="col-md-10">
														<p>휴대전화</p>
														<input name="phone" id="phone" type="text"
															class="form-control" placeholder="휴대전화"
															value="${emp.PHONE}">
													</div>
												</div>

												<div class="form-group row mt-4">
													<div class="col-md-10">
														<p class="mb-0">주소</p>
														<button type="button" class="btn"
															onclick="sample2_execDaumPostcode()">
															<i class="fa fa-map-marker-alt"></i>
														</button>
														<input name="address" id="address" type="text"
															class="form-control" placeholder="주소"
															value="${emp.ADDRESS}">
													</div>
												</div>
											</form>

											<!-- 주소폼 -->
											<div id="layer"
												style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
												<img
													src="//t1.daumcdn.net/postcode/resource/images/close.png"
													id="btnCloseLayer"
													style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1"
													onclick="closeDaumPostcode()" alt="닫기 버튼">
											</div>


										</div>

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
	<!-- Logout Modal-->
	<jsp:include page="/WEB-INF/views/inc/LogOutModal.jsp" />
	
	<!-- End of Footer 모듈화 -->
	<!-- 모든 스크립트 모듈화 -->
	<jsp:include page="/WEB-INF/views/inc/BottomLink.jsp"></jsp:include>
	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>


	$(document).ready(function(){
		$('#collapseInfo').addClass('show');
		$('#collapseInfo').prev().removeClass('collapsed');
		$('#collapseInfo').prev().children().css("color","#fff");
		$('#editform').hide();
		
		//$('#pic').hide();
		var edit = false;
		$('#editBtn').click(function(){
			if(edit == false){
				$(this).hide();
				$('#personal_info').empty();
				//$('.form-control').attr('readonly', false);
				//$('#pic').show(); 
				$('#editform').show();
				$('#saveBtn').show();
				edit = true;

				$.ajax({
					url: "/HRinfo/Emp.do",
					type: "POST",
					dataType:  "JSON",
					data: {
						searchType: searchType,
						keyword: keyword
					},
					success: (data) => {
						insertDatabyAjax(data);
					},error : function(error){
						console.log(error);
					}
				});

			}
		}); 

		$('#saveBtn').click(function(){
			if($('#pwd').val() == ""){
				$('#alert').show();
			}else{
				$('#editform').submit();
			}
			
		}); 
	}); 


	/* 주소 */
	// 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
             
                var addr = ''; // 주소 변수

                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                document.getElementById("address").value = addr;
       

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
	</script>
</body>

</html>