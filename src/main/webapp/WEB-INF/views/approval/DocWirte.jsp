<%-- 
    파일명: DocWrite.jsp
    설명: 전자결재 홈 페이지
    작성일: 2020-12-29
    작성자: 박선우
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>SB Admin 2 - Write</title>
<jsp:include page="../inc/HeadLink.jsp"></jsp:include>
<style type="text/css">
h1 {
	text-decoration: underline;
	font-weight: bold;
	text-decoration-color: #ffe561;
	text-decoration-thickness: 5px;
}

.modal-flexbox {
	display: flex;
	flex-direction: row;
	flex-wrap: nowrap;
	justify-content: space-between;
	align-items: center;
}

.flexbox-items {
	max-width: 120px;
	min-height: 50px;
	padding: 1.1rem 1.1rem;
	padding-bottom: 0;
}

#nono {
	color: red;
}

.round {
	border-radius: 10px;
}

.selector {
	border-radius: 20px;
}

.inputbox {
	border: 0px;
	outline: none;
}

.datepicker {
	border-radius: 20px;
	outline: none;
}

.modal-body ul {
	list-style-type: none;
}

.modal-body ul img {
	padding-bottom: 7px;
	padding-right: 7px;
}

.team {
	list-style-image: none;
}

.temp {
	background: hsla(0, 100%, 100%, 0);
	border: none;
}

.allemp {
	overflow: auto;
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
					<c:set var="emp" value="${requestScope.emp }" />
					<!-- Page Heading -->
					<div class="row d-flex flex-row justify-content-between">
					<h1 class="h3 ml-3 text-gray-800">전자결재</h1>
						<div class=" justify-content-between">
							<div class="row">
								<p class="mt-1 mb-0" id="nono"></p>
								<button id="cancle" class="btn btn-danger btn-icon-split my-auto mx-2">
									<span class="icon text-white-50"> <i class="fas fa-trash"></i>
									</span> <span class="text">취소 하기</span>
								</button>
							
								<button id="submit" class="btn btn-success btn-icon-split mx-2">
									<span class="icon text-white-50"> <i class="fas fa-check"></i>
									</span> <span class="text">기안 하기</span>
								</button>
								<button id="preview" class="btn btn-primary btn-icon-split mx-2" data-toggle="modal" data-target="#previewModal">
									<span class="icon text-white-50"> <i class="fas fa-check"></i>
									</span> <span class="text">미리 보기</span>
								</button>
							</div>
						</div>
					</div>
					<form action="" method="post" enctype="multipart/form-data" id="form">
						<div class="card shadow py-0 bg-white my-4">
							<div class="card-header pt-3 pb-0 d-flex flex-row align-items-center">
								<div class=" mt-0 mb-2 py-0 col-xl-2">
									<div class=" py-2 px-0">
										<div class="text-center text-primary">문서 번호</div>
										<div class="mx-auto w-100">
											<input type="text" class="selector text-center w-100" id="docno" name="docno" readonly>
										</div>
									</div>
								</div>
								<div class=" mt-0 mb-2  py-0 col-xl-2">
									<div class=" py-2 px-0">
										<div class="text-center text-primary">문서종류</div>
										<div class="mx-auto w-100">
											<select class="px-auto mx-auto w-100 selector" id="selector" name="typeCode" style="text-align-last: center">
												<c:forEach var="list" items="${requestScope.docType}">
													<option value="${list.typeCode}">${list.typename}</option>
												</c:forEach>
											</select>
										</div>
									</div>
								</div>
								<c:set var="formlist" value="${requestScope.formList }" />
								<div class=" mt-0 mb-2 py-0 col-xl-2" style="display: block" id="doc">
									<div class="py-2 px-0">
										<div class="text-center text-primary">일반 문서 종류</div>
										<select class="px-auto mx-auto w-100 selector" id="doc_form" style="text-align-last: center">
											<option>선택하세요</option>
											<c:forEach var="form" items="${formlist }">
												<option value="${form.formName}">${form.formName}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
							<div class="container-fluid">
								<div class="container-fluid">
									<div class="row">
										<div class="col-xl-2 mx-auto my-4">
											<a data-toggle="modal" data-target="#approverModal" class="btn btn-secondary btn-icon-split w-100" id="approval">
												<span class="text">결재선 추가하기</span>
											</a>
										</div>
										<div class="card my-auto py-0 mx-auto col-xl-2">
											<div class="card-body py-2 px-0">
												<div class="text-center text-primary">이름</div>
												<div class="text-md mt-1 text-center">
													<input type="text" class="inputbox text-center w-100" value="${emp.ename }" id="ename" readonly>
												</div>
											</div>
										</div>
										<div class="card my-auto py-0 mx-auto  mx-1 col-xl-2">
											<div class="card-body py-2 px-0">
												<div class="text-center text-primary">직책</div>
												<div class="text-md mt-1 text-center">
													<input type="text" class="inputbox text-center w-100" value="${emp.positionname }" id="headname" readonly>
												</div>
											</div>
										</div>
										<div class="card my-auto py-0 mx-auto col-xl-2">
											<div class="card-body py-2 px-0">
												<div class="text-center text-primary">부서</div>
												<div class="text-md mt-1 text-center">
													<input type="text" class="inputbox text-center w-100" value="${emp.deptname }" id="deptname" readonly>
												</div>
											</div>
										</div>
										<div class="card my-auto py-0  mx-auto mx-1 col-xl-2">
											<div class="card-body py-2 px-0">
												<div class="text-center text-primary">사번</div>
												<sec:authentication property="name" var="LoginUser" />
												<sec:authorize access="isAuthenticated()">
													<div class="text-md mt-1 text-center">
														<input type="text" class="inputbox text-center w-100" value="${LoginUser}" id="empno" name="empno" readonly>
													</div>
												</sec:authorize>
											</div>
										</div>
										<div class="card my-auto py-0 mx-auto col-xl-2">
											<div class="card-body py-2 px-0">
												<div class="text-center text-primary">작성일자</div>
												<c:set var="time" value="${requestScope.time}" />
												<div class="text-md mt-1 text-center">
													<input type="text" class="inputbox text-center w-100" value="${time}" id="writedate" name="writedate" readonly>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-11 mx-auto">
								<div class="card-body justify-content-center mt-3">
									<div class="row">
										<div class="table-responsive py-auto">
											<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
												<table class="table table-bordered dataTable my-0" id="dataTable" cellspacing="0" role="grid" aria-describedby="dataTable_info">
													<tbody class="text-center">
														<tr style="height: 25px;">
															<td scope="col" rowspan="4" colspan="1" style="width: 20%; padding-top: 60px;">승인</td>
															<td scope="col" rowspan="1" colspan="1" style="width: 20%;">결재자 1</td>
															<td scope="col" rowspan="1" colspan="1" style="width: 20%;">결재자 2</td>
															<td scope="col" rowspan="1" colspan="1" style="width: 20%;">결재자 3</td>
															<td scope="col" rowspan="1" colspan="1" style="width: 20%;">결재자 4</td>
														</tr>
														<tr style="height: 35px;">
															<td rowspan="2">
																<input class="inputbox text-center apps" id="app1" type="text" readonly>
																<input class="inputbox text-center" id="app1_id" name="approvers" type="text" hidden>
															</td>
															<td rowspan="2">
																<input class="inputbox text-center apps" id="app2" type="text" readonly>
																<input class="inputbox text-center" id="app2_id" name="approvers" type="text" hidden>
															</td>
															<td rowspan="2">
																<input class="inputbox text-center apps" id="app3" type="text" readonly>
																<input class="inputbox text-center" id="app3_id" name="approvers" type="text" hidden>
															</td>
															<td rowspan="2">
																<input class="inputbox text-center apps" id="app4" type="text" readonly>
																<input class="inputbox text-center" id="app4_id" name="approvers" type="text" hidden>
															</td>
														</tr>
														<tr style="height: 35px;"></tr>
														<tr>
															<td rowspan="1"></td>
															<td rowspan="1"></td>
															<td rowspan="1"></td>
															<td rowspan="1"></td>
														</tr>
													</tbody>
												</table>
											</div>
											<br> <span>참조자</span>
											<div id="referrer" class=" border-bottom border-secondary"></div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-11 mx-auto" id="duration"></div>
							<div class="card my-2 py-2   mr-auto mx-auto col-md-11">
								<div class="justify-content-center mx-2">
									<div style="width: 100%;">
										<span class="text-lg" style="width: 20%;">제목 :</span>
										<input class="mx-4 inputbox" type="text" name="title" id="title" style="width: 80%;" />
									</div>
								</div>
							</div>
							<div class="card my-2 py-2 mr-auto mx-auto col-md-11 col-md-10" id="drop">
								<div class="justify-content-center mx-2">
									<div class="col-md-12 mx-auto mt-3" id="file_add">
										<p class="mt-4" style="text-align: center;">Drag file Or Click to add files</p>
									</div>
									<div id="thumbnails" class="col-md-12 row mr-0 ml-0 mb-3"></div>
								</div>
							</div>
							<div class="my-2 mx-auto col-md-12">
								<div class="justify-content-cente0 mx-2">
									<textarea id="summernote" name="content"></textarea>
								</div>
							</div>
							<input type="file" id="file" name="file" value="" multiple hidden>
						</div>
					</form>
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- End of Main Content -->
			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/inc/Footer.jsp"></jsp:include>
			<!-- End of Footer -->
		</div>
		<!-- End of Content Wrapper -->
	</div>
	<!-- End of Page Wrapper -->
	<!-- 미리보기 모달 -->
	<div class="modal fade" id="previewModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl overflow-auto" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">미리보기</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">X</span>
					</button>
				</div>
				<div class="modal-body " id="preview-modal-body"></div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 결재선 지정 모달 -->
	<div class="modal fade" id="approverModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg overflow-auto" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="ModalLabel">결재선 추가하기</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">X</span>
					</button>
				</div>
				<div class="modal-body" id="approver-modal-body">
					<div class="horizontalTree mb-2 col-mb-12 d-flex" style="height: 500px;">
						<div class="col-md-5 mx-auto border border-secondary h-100 round allemp">
							<ul style="padding-left: 10px;">
								<div class="mt-4" id="jstree_div"></div>
							</ul>
						</div>
						<div class="col-md-5 mx-auto">
							<div class="col-md-12 mt-0 mb-2" style="height: 60%;">
								<div class="mt-0 mb-0">결재자</div>
								<div class="col-md-12 mx-auto border border-secondary round" style="height: 80%;">
									<div id="approverList"></div>
								</div>
								<button class="btn btn-sm mt-1 btn-primary" id="add_approver">추가하기</button>
							</div>
							<div class="col-md-12 mt-1 mb-0" style="height: 35%;">
								<div class="mt-0 mb-0 ">참조자</div>
								<div class="col-md-12 mx-auto border border-secondary round" style="height: 80%;">
									<div id="referrerList"></div>
								</div>
								<button class="btn btn-sm mt-1 btn-primary" id="add_referrer">추가하기</button>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-circle btn-success" id="applybtn" type="button" data-dismiss="modal">
						<i class="fas fa-check"></i>
					</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 결재선 지정 모달 -->
	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top">
		<i class="fas fa-angle-up"></i>
	</a>
	</div>
	<!-- Logout Modal-->
	<jsp:include page="/WEB-INF/views/inc/LogOutModal.jsp" />
	<!-- 모든 스크립트 모듈화 -->
	<jsp:include page="../inc/BottomLink.jsp"></jsp:include>
</body>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script type="text/javascript">
var approverList =[];	
var referrerList =[];
function deletefromapp(me){
	$(me).parents('a.jstree-anchor').remove();
	approverList.splice(approverList.indexOf($(me).parents('a.jstree-anchor').text()),2);
	console.log(approverList.indexOf($(me).parents('a.jstree-anchor').text()));
};
function deletefromrim(me){
	$(me).parents('a.jstree-anchor').remove();
	referrerList.splice(referrerList.indexOf($(me).parents('a.jstree-anchor').text()),2);
};
function getMaxDocno(typeCode){

	console.log(typeCode);
	$.ajax({
		url:"getMaxDocno.do",
		type:"POST",
		data:{typeCode:typeCode},
		success:function(data){
			console.log(data);
			let first = new Date();
			first = first.getFullYear()+""
			console.log(first.substring(2,4));
			
			let last = data.substring(data.length-3);
			
			 if(last.length==0){
				last = "000";
				}else if(last.length<3){
					for(let i = 0; i<3-last.length; i++){
						typeCode +="0";
						};
					} 
			docno = (parseInt(first.substring(2,4)+typeCode+last)+1);
			console.log(docno);
			$('#docno').val(docno)
			},error: function(data){
				console.log(data.responseText);
				}
		});
}
$(function() {
getMaxDocno(10);
	$('#collapseEA').addClass('show');
	$('#collapseEA').prev().removeClass('collapsed');
	$('#collapseEA').prev().children().css("color","#fff");
	
	var $drop=$('#drop');
	var uploadFiles=[];
	var data = [];

	function createFirstTree(){
		
		return new Promise((resolve,reject)=>{
			
		$.ajax({
		url:"getAllEmpList.do",
		 dataType: "json",
		 contentType: "application/json; charset=utf-8",
		success:function(responsedata){
			console.log(responsedata);
			$.each(responsedata,(index,item)=>{
				data[index] = {"id":item.empNo, "parent":"department"+item.deptCode, "text":item.ename,"icon":"/resources/img/user.jpg"}
					})
				resolve();
				}
			});
	
		});
	};	
	function createSecondTree(){
		return new Promise((resolve,reject)=>{
			$.ajax({
				url:"getAllDeptList.do",
				 dataType: "json",
				 contentType: "application/json; charset=utf-8",
				success:function(responsedata){
					console.log(responsedata);
					$.each(responsedata,(index,item)=>{
						data[data.length] = {"id":"department"+item.deptCode, "parent":"headquter"+item.headCode, "text":item.deptName, "icon":"/resources/img/dept.jpg"}
						})
						resolve();
					}
				});
			});
	}
	
	function createFinalTree(){
		return new Promise((resolve,reject)=>{
			$.ajax({
				url:"getAllHeadList.do",
				 dataType: "json",
				 contentType: "application/json; charset=utf-8",
				success:function(responsedata){
					console.log(responsedata);
					$.each(responsedata,(index,item)=>{
						data[data.length] = {"id":"headquter"+item.headCode, "parent":"#", "text":item.headName,"icon":"/resources/img/head.jpg"}
						})
						resolve();
					}
				});
	
			});
		
	}
	createFirstTree()
	 .then(createSecondTree)
	 .then(createFinalTree)
	 
 $('#submit').on("click",()=>{
	 	$('#nono').empty();
		 console.log($('#app1_id').val())
		 
		 if(approverList[0] ==null){
				let html = '결재자를 최소 1명이상 선택해 주세요';
				$('#nono').append(html);
			 }else if($('#title').val() ==null ||  $('#title').val() == ''){
				let html = '제목을 입력해 주세요';
				$('#nono').append(html);
	 		}else{	
				let protocol = {
						cmd : "next",
						docWriter : "${emp.ename }",
						nextApprover : approverList[1][0].id.split('_')[0],
						docno:$('#docno').val(),
						color: "success",
						docTitle:$('#title').val()
						}
				
		 		websocket.send(JSON.stringify(protocol));

				$('#form').submit();


				 }
		
	 })

		$('#applybtn').on("click",()=>{
				console.log(approverList);
				$('.apps').val('');
				for(let i=1; i<(approverList.length/2)+1; i++){
						
						$('#app'+i).val(approverList[i*2-2]);
						console.log($('#app'+i).val());
						$('#app'+i+'_id').val(approverList[i*2-1][0].id.split('_')[0]);
						
						console.log($('#app'+i+'_id').val());
					}
					$('#referrer').empty();
			
				for(let j=1; j< (referrerList.length/2)+1; j++){
					let html = '<input type=text value="'+referrerList[j*2-1][0].id.split('_')[0]+'" id=referrer'+j+' name=referrers hidden ><span>'+referrerList[j*2-2]+'<span>&nbsp &nbsp';
					$('#referrer').append(html);
					console.log(referrerList[j*2-1][0].id.split('_')[0]);
				}
			}); 
			
		
			
		 
		$('#approval').on("click",()=>{
			
			console.log(data.length);
			console.log(typeof data);
		
			$('#jstree_div').jstree({
			"core":{
			"check_callback" : true,
			"themes" : { 
				"theme" : "default",
				"dots":false 
				
				},
			 "data":data
				
		 	}	
			
			}
		)
		});  
		
		
 
		
		$('#add_approver').on("click",()=>{
			
			let clickedapp = $('div#jstree_div a.jstree-clicked').clone();
			let buttonapp = '<button class="temp" onclick="deletefromapp(this)"><img class="false" src="/resources/img/false.png"></button>';
			let approver = clickedapp.append(buttonapp);
			if(!isNaN(parseInt(clickedapp[0].id.split('_')[0])) ){

				if(!approverList.includes(clickedapp.text())){
				approverList.push(clickedapp.text());
				approverList.push(clickedapp);
				console.log(clickedapp[0].id.split('_')[0]);
				};
				$('#approverList').empty();
				for(let i=1; i<approverList.length; i+=2){
					$('#approverList').append(approverList[i]);
				}
			
			}
		});
		
		
		$('#add_referrer').on("click",()=>{
			let clicked = $('div#jstree_div a.jstree-clicked').clone();
			let button = '<button class="temp" onclick="deletefromrim(this)"><img class="false" src="/resources/img/false.png"></button>';
			let referrer = clicked.append(button);

			if(!isNaN(parseInt(clicked[0].id.split('_')[0])) ){
			if(!referrerList.includes(clicked.text())){
				console.log("clicked:"+clicked);
			referrerList.push(clicked.text());
			referrerList.push(clicked);
			};
			$('#referrer').empty();
			for(let i=1; i<referrerList.length; i+=2){
				console.log(referrerList[i]);
				$('#referrerList').append(referrerList[i]);
			}
			}
		});
			
			
	
	
		$('#preview').on("click",()=>{
			$('#preview-modal-body').empty();
			let type = $('#selector').val().split(' ');
			let html='<div id="hw_dext_default_style"\
				style="font-family:   맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">\
			<div\
				style="margin: 0px; padding: 0px; font-family:   맑은 고딕; font-size: 16px; line-height: 1.8;">\
				<h1\
					style="text-align: center; padding: 30px 0px; font-size: 26px; font-family:   맑은 고딕; line-height: 1.8;">'+$('#selector option:selected').text()+'</h1>\
				<p>\
					\
				</p>\
				<div class="list"\
					style="margin: 0px; padding: 0px; float: left; font-size: 11pt; width: 272px; color: rgb(103, 103, 103); font-family:   맑은 고딕 ,   Malgun Gothic , dotum , sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: -0.4px; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">\
					<dl style="margin: 0px; padding: 0px; list-style: none;">\
						<dt\
							style="margin: 0px; padding: 0px 0px 0.32cm; float: left; clear: both; width: 106px; font-weight: bold; color: rgb(18, 18, 18);">문서\
							번호</dt>\
						<dd\
							style="margin: 0px; padding: 0px 0px 0.32cm; float: left; width: 151px; color: rgb(18, 18, 18);"></dd>\
						<dt\
							style="margin: 0px; padding: 0px 0px 0.32cm; float: left; clear: both; width: 106px; font-weight: bold; color: rgb(18, 18, 18);">기안\
							부서</dt>\
						<dd\
							style="margin: 0px; padding: 0px 0px 0.32cm; float: left; width: 151px; color: rgb(18, 18, 18);">'+$('#deptname').val()+'</dd>\
						<dt\
							style="margin: 0px; padding: 0px 0px 0.32cm; float: left; clear: both; width: 106px; font-weight: bold; color: rgb(18, 18, 18);">기안자</dt>\
						<dd\
							style="margin: 0px; padding: 0px 0px 0.32cm; float: left; width: 151px; color: rgb(18, 18, 18);">'+$('#ename').val()+'</dd>\
						<dt\
							style="margin: 0px; padding: 0px 0px 0.32cm; float: left; clear: both; width: 106px; font-weight: bold; color: rgb(18, 18, 18);">기안\
							일자</dt>\
						<dd\
							style="margin: 0px; padding: 0px 0px 0.32cm; float: left; width: 151px; color: rgb(18, 18, 18);">'+$('#writedate').val()+'</dd>\
					</dl>\
				</div>\
				<div class="approval"\
					style="margin: 0px; padding: 0px; float: right; width: 365px; color: rgb(103, 103, 103); font-family:   맑은 고딕 ,   Malgun Gothic , dotum , sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: -0.4px; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">\
					<h2\
						style="margin: 0px; padding: 0px 0px 0.2cm; font-size: 8pt; color: rgb(18, 18, 18);">결재선</h2>\
					<table\
						style="border-collapse: collapse; width: 364px; table-layout: fixed; border-width: 1px; border-style: solid; border-color: rgb(89, 89, 89) rgb(102, 102, 102);">\
						<colgroup>\
							<col>\
							<col>\
							<col>\
							<col>\
							<col>\
						</colgroup>\
						<tbody>\
							<tr>\
								<th scope="col"\
									style="margin: 0px; padding: 0px; font-size: 8pt; font-family:   맑은 고딕 ,   Malgun Gothic , dotum , sans-serif; color: rgb(0, 0, 0); height: 25px; font-weight: normal; border-left: 0px; word-break: break-all;">'+$('#app1').val()+'</th>\
								<th scope="col"\
									style="margin: 0px; padding: 0px; font-size: 8pt; font-family:   맑은 고딕 ,   Malgun Gothic , dotum , sans-serif; color: rgb(0, 0, 0); height: 25px; font-weight: normal; border-left: 1px solid rgb(102, 102, 102); word-break: break-all;">'+$('#app2').val()+'\
									</th>\
								<th scope="col"\
									style="margin: 0px; padding: 0px; font-size: 8pt; font-family:   맑은 고딕 ,   Malgun Gothic , dotum , sans-serif; color: rgb(0, 0, 0); height: 25px; font-weight: normal; border-left: 1px solid rgb(102, 102, 102); word-break: break-all;">'+$('#app3').val()+'\
									</th>\
								<th scope="col"\
									style="margin: 0px; padding: 0px; font-size: 8pt; font-family:   맑은 고딕 ,   Malgun Gothic , dotum , sans-serif; color: rgb(0, 0, 0); height: 25px; font-weight: normal; border-left: 1px solid rgb(102, 102, 102);  border-right:1px solid rgb(102,102,102); word-break: break-all;">'+$('#app4').val()+'\
									</th>\
							</tr>\
							<tr>\
								<td class="stamp"\
									style="margin: 0px; padding: 0px; font-size: 8pt; font-family:   맑은 고딕 ,   Malgun Gothic , dotum , sans-serif; color: rgb(0, 0, 0); height: 49px; text-align: center; border-top: 1px solid rgb(102, 102, 102); border-left: 0px; border-bottom: 1px solid rgb(102, 102, 102); line-height: 10pt; word-break: break-all; vertical-align: middle;"><p>\
										<br>\
									</p></td>\
								<td class="stamp"\
									style="margin: 0px; padding: 0px; font-size: 8pt; font-family:   맑은 고딕 ,   Malgun Gothic , dotum , sans-serif; color: rgb(0, 0, 0); height: 49px; text-align: center; border-top: 1px solid rgb(102, 102, 102); border-left: 1px solid rgb(102, 102, 102); border-bottom: 1px solid rgb(102, 102, 102); line-height: 10pt; word-break: break-all; vertical-align: middle;"><p>\
										<br>\
									</p></td>\
								<td class="stamp"\
									style="margin: 0px; padding: 0px; font-size: 8pt; font-family:   맑은 고딕 ,   Malgun Gothic , dotum , sans-serif; color: rgb(0, 0, 0); height: 49px; text-align: center; border-top: 1px solid rgb(102, 102, 102); border-left: 1px solid rgb(102, 102, 102); border-bottom: 1px solid rgb(102, 102, 102); line-height: 10pt; word-break: break-all; vertical-align: middle;"><p>\
										<br>\
									</p></td>\
								<td class="stamp"\
									style="margin: 0px; padding: 0px; font-size: 8pt; font-family:   맑은 고딕 ,   Malgun Gothic , dotum , sans-serif; color: rgb(0, 0, 0); height: 49px; text-align: center; border-top: 1px solid rgb(102, 102, 102); border-left: 1px solid rgb(102, 102, 102); border-bottom: 1px solid rgb(102, 102, 102); border-right:1px solid rgb(102,102,102); line-height: 10pt; word-break: break-all; vertical-align: middle;"><p>\
										<br>\
									</p></td>\
							</tr>\
							<tr>\
								<td\
									style="margin: 0px; padding: 0.08cm 0px; font-size: 8pt; font-family:   맑은 고딕 ,   Malgun Gothic , dotum , sans-serif; color: rgb(0, 0, 0); height: 22px; text-align: center; border-top: 1px solid rgb(102, 102, 102); border-left: 0px; border-bottom: 1px solid rgb(89, 89, 89); line-height: 10pt; word-break: break-all;"></td>\
								<td\
									style="margin: 0px; padding: 0.08cm 0px; font-size: 8pt; font-family:   맑은 고딕 ,   Malgun Gothic , dotum , sans-serif; color: rgb(0, 0, 0); height: 22px; text-align: center; border-top: 1px solid rgb(102, 102, 102); border-left: 1px solid rgb(102, 102, 102); border-bottom: 1px solid rgb(89, 89, 89); line-height: 10pt; word-break: break-all;">\
										<br>\
									</td>\
								<td\
									style="margin: 0px; padding: 0.08cm 0px; font-size: 8pt; font-family:   맑은 고딕 ,   Malgun Gothic , dotum , sans-serif; color: rgb(0, 0, 0); height: 22px; text-align: center; border-top: 1px solid rgb(102, 102, 102); border-left: 1px solid rgb(102, 102, 102); border-bottom: 1px solid rgb(89, 89, 89); line-height: 10pt; word-break: break-all;"></td>\
								<td\
									style="margin: 0px; padding: 0.08cm 0px; font-size: 8pt; font-family:   맑은 고딕 ,   Malgun Gothic , dotum , sans-serif; color: rgb(0, 0, 0); height: 22px; text-align: center; border-top: 1px solid rgb(102, 102, 102); border-left: 1px solid rgb(102, 102, 102); border-bottom: 1px solid rgb(89, 89, 89); border-right:1px solid rgb(102,102,102);  line-height: 10pt; word-break: break-all;"></td>\
							</tr>\
						</tbody>\
					</table>\
				</div>\
				<p\
					style="font-family:   맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">\
					<meta charset="utf-8">\
					&nbsp;\
				</p>\
				<div class="list"\
					style="margin: 0px; padding: 0px; float: left; font-size: 8pt; width: 272px; font-family:   맑은 고딕; line-height: 1.8;">\
					<dl style="margin: 0px; padding: 0px; list-style: none;">\
						<br>\
					</dl>\
				</div>\
				<p\
					style="font-family:   맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">\
					<br>\
				</p>\
				<br>\
				<br>\
				<br>\
				<br>\
				<table\
					style="width: 100%; border-collapse: collapse; border: 1px solid #cdcdcd; margin: 20px 0 0; padding: 0">\
					<tbody>\
						<tr>\
							<td\
								style="padding: 10px 0px; border: 1px solid rgb(205, 205, 205); text-align: center; font-weight: bold; width: 136px;"><p\
									style="font-family:   맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">소속</p>\
							</td>\
							<td colspan="2"\
								style="padding: 10px; border: 1px solid rgb(205, 205, 205); width: 312px;"><p\
									style="font-family:   맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">\
									'+$('#deptname').val()+'\
								</p></td>\
							<td\
								style="padding: 10px 0px; border: 1px solid rgb(205, 205, 205); text-align: center; font-weight: bold; width: 143px;"><p\
									style="font-family:   맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">직위</p>\
							</td>\
							<td colspan="2"\
								style="padding: 10px; border: 1px solid rgb(205, 205, 205); width: 378px;"><p\
									style="font-family:   맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">\
									'+$('#headname').val()+'\
								</p></td>\
						</tr>\
						<tr>\
							<td\
								style="padding: 10px 0px; border: 1px solid rgb(205, 205, 205); text-align: center; font-weight: bold; width: 136px;"><p\
									style="font-family:   맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">제목</p>\
							</td>\
							<td colspan="5"\
								style="padding: 10px; border: 1px solid rgb(205, 205, 205); width: 852px;"><p\
									style="font-family:   맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">\
									'+$("#title").val()+'</p></td></tr>';
						if($('#selector').val()=='40' || $('#selector').val()=='30'){
							
							
						html+='<tr>\
							<td\
								style="padding: 10px 0px; border: 1px solid rgb(205, 205, 205); text-align: center; font-weight: bold; width: 136px;"><p\
									style="font-family:   맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">기간</p>\
							</td>\
							<td colspan="5"\
								style="padding: 10px 0px; border: 1px solid rgb(205, 205, 205); width: 852px;"><p\
									style="font-family:   맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">'+$('#start').val()+'\
									 ~ '+$('#end').val()+'</p></td>\
						</tr>';
						};
					
						html +=	'<tr>\
							<td colspan="6"\
								style="padding: 10px 0; border: 1px solid #cdcdcd; text-align: center; font-weight: bold;"><p\
									style="font-family:   맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">\
									<br>\
								</p></td>\
						</tr>\
						<tr>\
							<td colspan="6"\
								style="padding:0px; border: 1px solid #cdcdcd; height: 300px; vertical-align: top"><p\
									style="font-family:   맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">\
									'+$('#summernote').summernote("code")+'\
								</p></td>\
						</tr>\
						<tr>\
							<td colspan="6" style="padding: 10px 0; border: 0;"><table\
									style="width: 100%; border-collapse: collapse; margin: 0; padding: 0">\
									<tbody>\
										<tr>\
											<td colspan="3"\
												style="padding: 10px; text-align: center; border: 0;"><p\
													style="font-family:   맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">상기\
													명 본인은 위와 같은 사유로 제출합니다.</p></td>\
										</tr>\
										<tr>\
											<td colspan="3"\
												style="padding: 80px 0 40px; text-align: center; border: 0;"><p\
													style="font-family:   맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">'+$('#writedate').val()+'\
													</p></td>\
										</tr>\
										<tr>\
											<td\
												style="padding: 10px; border: 0px; text-align: right; width: 632px;"><p\
													style="font-family:   맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">신청인:</p>\
											</td>\
											<td style="padding: 10px; border: 0px; width: 78px;"><p\
													style="font-family:   맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">\
													'+$('#ename').val()+'\
												</p></td>\
											<td style="padding: 10px; border: 0px; width: 67px;"><p\
													style="font-family:   맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">(인)</p>\
											</td>\
										</tr>\
										<tr>\
											<td colspan="3"\
												style="padding: 80px 0 10px; border: 0; font-weight: bold; font-size: 20px; text-align: center"><p\
													style="font-family:   맑은 고딕; font-size: 20px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">OLIVE</p>\
											</td>\
										</tr>\
									</tbody>\
								</table></td>\
						</tr>\
					</tbody>\
				</table>\
			</div>\
		</div>';
					$('#preview-modal-body').append(html);
			});
		
		$(document).on("click",".datepicker",(e)=>{
			e.preventDefault();
		$('#start').datepicker({
			minDate:0,
			dateFormat:"yy-mm-dd",
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			onClose:function(){
				$('#end').datepicker({
					dateFormat:"yy-mm-dd",
					minDate:new Date($('#start').val()+''),
					dayNamesMin: ['일', '월', '화', '수', '목', '금', '토']			
	
					})
				}
			});
		});
		
		
		$('#selector').on("change",()=>{
			getMaxDocno($('#selector').val());
			let typename=$('#selector option:selected').text();
			console.log(typename);
			$('#summernote').summernote("code",'');
			$('#duration').empty();
			let html='';
			if($('#selector').val()!='10' ){
				$('#doc').css("display","none");
				
				html = '<div class="card my-2 py-0   mr-auto mx-auto col-xl-11"><div class="card-body py-2">'+
				'<div class="row no-gutters align-items-center"><div class="col mx-auto"><div class=" text-center font-weight-bold text-primary text-uppercase mb-1">'+
				' 기간</div><div class="row px-auto"><div class="mx-auto mb-0 font-weight-bold text-gray-800">	<input type="text" class="datepicker text-center" id="start" name="start" width="276" readonly>';
				
				if( $('#selector').val()!='20'){ 
				html+= '<span class="mx-2">~</span><input type="text" class="datepicker text-center" name="end" id="end" width="276" readonly>';
				};
				if($('#selector').val() =='30'){
				html+= '<div class="text-center mt-2"><span>남은 연차 : </span><span>'+ '${emp.annual - emp.usedAnnual}' +'일</span><br><span>선택 일수</span><span id="diff"></span></div></div></div></div></div></div></div>';
					}
				$('#duration').append(html);
			$.ajax({
				url:"selectSpecialForm.do",
				data:{typename:typename},
				type:"POST", 
				success:function(data){
					console.log(data);
					$('#summernote').summernote("code",data.typename);
					
					}

				});
			}else{
				$('#doc').css("display","block");
				
				}
		});
		
		
		$('#summernote').summernote( {
			maxheight: 400,
			minHeight: 300,
			lang: "ko-KR",	
			placeholder: '최대 2048자까지 쓸 수 있습니다',
			codemirror: { // codemirror options
	    	theme: 'monokai'
    		
    		
	  		}
		});
		
		$('#doc_form').on("change",()=>{
			let formname=$('#doc_form option:selected').text();
			console.log(formname);
			$.ajax({
				url:"selectForm.do",
				data:{formname:formname},
				type:"POST",
				success:function(data){
					console.log(data);
					$('#summernote').summernote("code",data.formname);
					
					}

				});


				})



		$(document).on("change","#end",function(){
			$('#diff').empty();
			let startdate = new Date($('#start').val());
			let enddate = new Date($('#end').val());
			let diffday = (enddate-startdate)/(1000*60*60*24)+1;
			let html = " : "+diffday+'일';
			if(diffday> '${emp.annual - emp.usedAnnual}'){
				html += '<br>사용하실 수 있는 연차수를 초과 했습니다.';
				$('#diff').css("color","red"); 								
				}
			$('#diff').append(html);
			})
			
			
			
		
		
		$drop.on("dragenter",function(e){
			$(this).addClass('drag-over');
		}).on("dragleave",function(e){
			$(this).removeClass('drag-over');
		}).on("dragover",function(e){
			e.stopPropagation();
			e.preventDefault();
		}).on("drop",function(e){
			var file= e.originalEvent.dataTransfer.files;
			e.preventDefault();
	   		$("input[type='file']")
	        .prop("files", file)  // put files into element
	        .closest("form")
	        .submit();  // autosubmit as well
			$(this).removeClass('drag-over');
			console.log(file);
			thumbnail(file);
		});
		
		
		
		function thumbnail(files){
	
			$('#thumbnails').empty();
			preview(files[0],files.length-1);
			console.log(files);
			
		}
		function preview(file,idx){
			let reader = new FileReader();
			reader.onload =(function(f,idx){
					return function(e){
						console.log(f);
						var div = 
							'<div class="row mx-2">\
								<div class="my-auto">'+f.name+'</div>\
								<button class="btn btn-circle btn-sm btn-danger mx-2 close" >\
								<i class="fas fa-trash"></i>\
								</button>\
							</div>';
							$('#thumbnails').append(div);
					};
			})(file,idx);
			reader.readAsDataURL(file);
		}
		
		
	
		$('#thumbnails').on("click",".close",function(e){
			e.preventDefault();
			var $target = $(e.target);
			var idx=$target.attr('data-idx');
			/* uploadFiles[idx].upload='disable'; */
			$target.parent().parent().remove();
			
		})
		
		
		$('#file_add').click(function() {
		    console.log('fileadd');
		    $("#file").click();
		});
		var input = document.querySelector('input[name="file"]');
	    input.addEventListener('change',(function(e){
	    	
	    	var file = input.files;
	        console.log($("#file").val());
	    	thumbnail(file);
	        $("#file").val();
	    	console.log(file);
			
			
		}));

	    $('#cancle').on("click",function(){
	    	location.href='/approval/ApprovalHome.do';
	    })
	    	



});
	
</script>
</html>