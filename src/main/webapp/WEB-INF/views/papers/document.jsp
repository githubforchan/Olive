<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<jsp:include page="../inc/HeadLink.jsp"></jsp:include>
<body>
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
					<c:set var="doc" value="${requestScope.document }" />
					<c:set var="emp" value="${requestScope.emp }" />
					<c:set var="apps" value="${requestScope.apps }" />
					<sec:authentication property="principal" var="user" />
					<div id="hw_dext_default_style" style="font-family: 맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">
						<div style="margin: 0px; padding: 0px; font-family: 맑은 고딕; font-size: 16px; line-height: 1.8;">
							<div style="text-align: right"> 
								<c:if test="${user.username != doc.empno }">
									<c:forEach var="check" items="${ apps}">
										<c:if test="${check.empno == user.username and check.app_Order - doc.curr_Approval ==1}">
											<!-- 현재 승인자 알기위한 input -->
											<input type="text" id="approver" value="${check.ename}" hidden>
											<button class="btn btn-success btn-icon-split approve" value="1">
												<span class="icon text-white-50"> <i class="fas fa-check"></i>
												</span> <span class="text">승인</span>
											</button>
											<button class="btn btn-danger btn-icon-split approve" value="0">
												<span class="icon text-white-50"> <i class="fas fa-trash"></i>
												</span> <span class="text">반려</span>
											</button>
										</c:if>
										<c:if test="${check.app_Order - doc.curr_Approval ==2 }">
											<!-- 다음 승인자 알기위한 input -->
											<input type="text" id="nextApprover" value="${check.empno}" hidden>
										</c:if>
									</c:forEach>
								</c:if>
								<c:if test="${user.username == doc.empno && doc.curr_Approval ==0}">
								<button class="btn btn-danger btn-icon-split cancle delete" value="0">
									<span class="icon text-white-50"> <i class="fas fa-trash"></i>
									</span> <span class="text">삭제하기</span>
								</button>
								</c:if>
							</div>
							<div>
								<h1 style="text-align: center; padding: 5px 0px 0px 5px; font-size: 26px; font-family: 맑은 고딕; line-height: 1.8;">${doc.typeName }</h1>
							</div>
							<div class="list"
								style="margin: 0px; padding: 0px; float: left; font-size: 11pt; width: 272px; color: rgb(103, 103, 103); font-family: 맑은 고딕, Malgun Gothic, dotum, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: -0.4px; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"
							>
								<dl style="margin: 0px; padding: 0px; list-style: none;">
									<dt style="margin: 0px; padding: 0px 0px 0.32cm; float: left; clear: both; width: 106px; font-weight: bold;">문서 번호</dt>
									<dd style="margin: 0px; padding: 0px 0px 0.32cm; float: left; width: 151px; color: rgb(18, 18, 18);">${doc.docno}</dd>
									<dt style="margin: 0px; padding: 0px 0px 0.32cm; float: left; clear: both; width: 106px; font-weight: bold;">기안자</dt>
									<dd style="margin: 0px; padding: 0px 0px 0.32cm; float: left; width: 151px; color: rgb(18, 18, 18);">${doc.ename }</dd>
									<dt style="margin: 0px; padding: 0px 0px 0.32cm; float: left; clear: both; width: 106px; font-weight: bold;">기안 일자</dt>
									<dd style="margin: 0px; padding: 0px 0px 0.32cm; float: left; width: 151px; color: rgb(18, 18, 18);">
										<fmt:formatDate value="${doc.writedate}" pattern="yyyy-MM-dd" />
									</dd>
								</dl>
							</div>
							<div class="approval"
								style="margin: 0px; margin-right: 0px; padding: 0px; padding-left: 70px; float: right; width: 365px; color: rgb(103, 103, 103); font-family: 맑은 고딕, Malgun Gothic, dotum, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: -0.4px; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"
							>
								<table style="border-collapse: collapse; width: 364px; table-layout: fixed; border-width: 1px; border-style: solid; border-color: rgb(89, 89, 89) rgb(102, 102, 102);">
									<colgroup>
										<col>
										<col>
										<col>
										<col>
										<col>
									</colgroup>
									<tbody>
										<tr>
											<c:forEach var="list" items="${apps }">
												<th scope="col"
													style="margin: 0px; padding: 0.08cm 0px; font-size: 11pt; font-family: 맑은 고딕, Malgun Gothic, dotum, sans-serif; height: 25px; font-weight: normal; border-left: 0px; text-align: center; border-right: 1px solid rgb(102, 102, 102); word-break: break-all;"
												>${list.ename }</th>
											</c:forEach>
										</tr>
										<tr>
											<c:forEach var="list" items="${apps }">
												<td class="stamp"
													style="margin: 0px; padding: 0px; font-size: 8pt; font-family: 맑은 고딕, Malgun Gothic, dotum, sans-serif; color: rgb(0, 0, 0); height: 49px; text-align: center; border-top: 1px solid rgb(102, 102, 102); border-left: 1px solid rgb(102, 102, 102); border-bottom: 1px solid rgb(102, 102, 102); border-right: 1px solid rgb(102, 102, 102); line-height: 10pt; word-break: break-all; vertical-align: middle;"
												>
													<c:if test="${list.app_Check==1}">
														<img src="/resources/img/approvalStamp.jpg">
													</c:if>
													<c:if test="${list.app_Check==2}">
														<img src="/resources/img/rejected.png">
													</c:if>
												</td>
											</c:forEach>
										</tr>
										<tr>
											<c:forEach var="list" items="${apps }">
												<td
													style="margin: 0px; padding: 0.08cm 0px; font-size: 8pt; font-family: 맑은 고딕, Malgun Gothic, dotum, sans-serif; color: rgb(0, 0, 0); height: 22px; text-align: center; border-top: 1px solid rgb(102, 102, 102); border-left: 1px solid rgb(102, 102, 102); border-bottom: 1px solid rgb(89, 89, 89); border-right: 1px solid rgb(102, 102, 102); line-height: 10pt; word-break: break-all;"
												>${list.positionname }</td>
											</c:forEach>
										</tr>
									</tbody>
								</table>
							</div>
							<p style="font-family: 맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;"></p>
							<div class="list" style="margin: 0px; padding: 0px; float: left; font-size: 8pt; width: 272px; font-family: 맑은 고딕; line-height: 1.8;">
								<dl style="margin: 0px; padding: 0px; list-style: none;">
									<br>
								</dl>
							</div>
							<p style="font-family: 맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">
								<br>
							</p>
							<br> <br> <br> <br>
							<table style="width: 100%; border-collapse: collapse; border: 1px solid #cdcdcd; margin: 20px 0 0; padding: 0">
								<tbody>
									<tr>
										<td style="padding: 10px 0px; border: 1px solid rgb(205, 205, 205); text-align: center; font-weight: bold; width: 136px;">
											<p style="font-family: 맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">소속</p>
										</td>
										<td colspan="2" style="padding: 10px; border: 1px solid rgb(205, 205, 205); width: 312px;">
											<p style="font-family: 맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">${emp.deptname}</p>
										</td>
										<td style="padding: 10px 0px; border: 1px solid rgb(205, 205, 205); text-align: center; font-weight: bold; width: 143px;">
											<p style="font-family: 맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">직위</p>
										</td>
										<td colspan="2" style="padding: 10px; border: 1px solid rgb(205, 205, 205); width: 378px;">
											<p style="font-family: 맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">${emp.positionname}</p>
										</td>
									</tr>
									<tr>
										<c:if test="${doc.typeCode ne 10}">
											<tr>
												<td style="padding: 10px 0px; border: 1px solid rgb(205, 205, 205); text-align: center; font-weight: bold; width: 136px;">
													<p style="font-family: 맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">기간</p>
												</td>
												<td colspan="5" style="padding: 10px; border: 1px solid rgb(205, 205, 205); width: 852px;">
													<p style="font-family: 맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">
														<fmt:formatDate value="${doc.start}" pattern="yyyy-MM-dd" />
														<c:if test="${doc.typeCode eq 20}">
												~<fmt:formatDate value="${doc.start}" pattern="yyyy-MM-dd" />
														</c:if>
														<c:if test="${doc.typeCode ne 20}">
												~<fmt:formatDate value="${doc.end}" pattern="yyyy-MM-dd" />
														</c:if>
													</p>
												</td>
											</tr>
										</c:if>
									<tr>
										<td style="padding: 10px 0px; border: 1px solid rgb(205, 205, 205); text-align: center; font-weight: bold; width: 136px;">
											<p style="font-family: 맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">제목</p>
										</td>
										<td colspan="5" style="padding: 10px; border: 1px solid rgb(205, 205, 205); width: 852px;">
											<p style="font-family: 맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">${doc.title }</p>
										</td>
									</tr>
									<tr>
										<td colspan="6" style="padding: 0; border: 1px solid #cdcdcd; height: 300px; vertical-align: top">${doc.content }</td>
									</tr>
									<tr>
										<td colspan="6" style="padding-bottom: 0px; padding-left: 10px; border: 1px solid #cdcdcd; height: 50px;">
											<p class="my-auto" style="font-family: 맑은 고딕; font-size: 16px;">
												첨부 파일 :
												<a href="download.do?filename=${doc.filename}" id="filename">${doc.filename }</a>
											</p>
										</td>
									</tr>
									<tr>
										<td colspan="6" style="padding: 10px 0; border: 0;">
											<table style="width: 100%; border-collapse: collapse; margin: 0; padding: 0">
												<tbody>
													<tr>
														<td colspan="3" style="padding: 10px; text-align: center; border: 0;">
															<p style="font-family: 맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">상기 명 본인은 위와 같은 사유로 제출합니다.</p>
														</td>
													</tr>
													<tr>
														<td colspan="3" style="padding: 80px 0 40px; text-align: center; border: 0;">
															<p style="font-family: 맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">
																<fmt:formatDate value="${doc.writedate}" pattern="yyyy-MM-dd" />
															</p>
														</td>
													</tr>
													<tr>
														<td style="padding: 10px; border: 0px; text-align: right; width: 632px;">
															<p style="font-family: 맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">신청인:</p>
														</td>
														<td style="padding: 10px; border: 0px; width: 78px;">
															<p style="font-family: 맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">${doc.ename }</p>
														</td>
														<td style="padding: 10px; border: 0px; width: 67px;">
															<p style="font-family: 맑은 고딕; font-size: 16px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">(인)</p>
														</td>
													</tr>
													<tr>
														<td colspan="3" style="padding: 80px 0 10px; border: 0; font-weight: bold; font-size: 20px; text-align: center">
															<p style="font-family: 맑은 고딕; font-size: 20px; line-height: 1.8; margin-top: 0px; margin-bottom: 0px;">OLIVE</p>
														</td>
													</tr>
												</tbody>
											</table>
										</td>
									</tr>
								</tbody>
							</table>
							<c:if test="${doc.statusCode ==40 }">
								<div class="row">
									<div class='col-xl-12 col-lg-12'>
										<div class="crad border-left-danger shadow mb-4">
											<div class="card-header py-3">
												<h6 class="m-0 font-weight-bold text-danger">사유</h6>
											</div>
											<div class="card-body px-2 py-0 mb-2">
												<c:forEach var="check" items="${ apps}">
													<c:if test="${ check.comment != null}">
												${check.ename } : ${check.comment}
												</c:if>
												</c:forEach>
											</div>
										</div>
									</div>
								</div>
							</c:if>
						</div>
					</div>
				</div>
			</div>
			<jsp:include page="../inc/Footer.jsp"></jsp:include>
			<!-- End of Footer 모듈화 -->
		</div>
		<!-- End of Content Wrapper -->
	</div>
	<!-- Logout Modal-->
	<jsp:include page="/WEB-INF/views/inc/LogOutModal.jsp" />
</body>
<!-- 모든 스크립트 모듈화 -->
<jsp:include page="../inc/BottomLink.jsp"></jsp:include>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="/resources/js/Approval/document.js"></script>
<script type="text/javascript">
function approve(app) {
    $.ajax({
        url: "approve.do",
        type: "POST",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(app),
        success: function(data) {
            location.href=data;
        }
    })
}
function checkAndApprove(check){
	
	return new Promise((resolve,reject)=>{
		
		
		});
	
}
$(function() {
    $('.approve').on("click",function() {
    	let color=''; //승인이면 'primary' 반려면 'danger'
        let checkApp;
        let app = {
            docno: ${doc.docno},
            empno: ${user.username},
            app_Check: 2,
        };
        let nextProtocol = {
				cmd : "next",
				docWriter:"${doc.ename }",
				approver: $('#approver').val(),
				docTitle:"${doc.title}",
				nextApprover: $('#nextApprover').val(),
				color : "success",
				docno:"${doc.docno}",
        		};
        if ($(this).val() == 1) {
            app.app_Check = 1;
            color="primary";
            swal({
                title: "승인 하시겠습니까?",
                text: "",
                icon: "success",
                buttons: {0:"취소",1:"승인"}
            }).then((result) => {
               if (result == 1){
         		websocket.send(JSON.stringify(appProtocol));
         		websocket.send(JSON.stringify(nextProtocol));
                approve(app)
                };
                
            });
        } else {
            color="danger";
            swal({
                title: "반려 하시겠습니까?",
                text: "",
                icon: "warning",
                content: {
                    element: "input",
                    attributes: {
                        placeholder: "사유를 적어 주세요"
                    }
                },
                buttons: ["취소하기", "반려하기"],
                dangerMode: true,
            }).then((value) => {
                if(value!='' && value != null){
                app["comment"] = value;
                console.log(app);
         		websocket.send(JSON.stringify(appProtocol));
         		

                approve(app);


                }else if(value ==''){
					swal({title:'사유를 작성해 주세요.',icon:"warning"}); 
                 }else{
                	 swal({title:'취소 되었습니다.',icon:"warning"});
                     }
            });
       	 }
		console.log(app);
        let appProtocol = {
				cmd : "App",
				docno:"${doc.docno}",
				docWriter : "${doc.empno}",
				docTitle :"${doc.title}",
				approver : $('#approver').val(),
				nextApprover : $('#nextApprover').val(),
				color: color
				}
		
					
		
    	});

	$('.delete').on("click",function(){
		swal({
            title: "삭제 하시겠습니까?",
            text: "",
            icon: "warning",
            buttons: ["취소하기", "삭제하기"],
            dangerMode: true,
        }).then((value) => {
           	console.log(value);
            if(value!='' && value != null){
            	 $.ajax({
         			url:"deleteDoc.do",
         			data:{docno:${doc.docno}},
         			success:function(data){
         				location.href=data;
         				}
         			}); 
            }else{
            	 swal({title:'취소 되었습니다.',icon:"warning"});
                 }
        });
		
	})
	
				
        
 	//승인이든 반려를 누르면 다음사람과 기안자에게 문자가 가야함 
    //근데 승인을 누르면 기안자와 다음사람에게 반려를 누르면 기안자에게만 알람이 가야함
    //기안자에게는 무조건 가야함
    
    
	
});
</script>
</html>