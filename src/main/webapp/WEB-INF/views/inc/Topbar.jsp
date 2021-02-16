<%-- 
    파일명: Topbar.jsp
    설명: 사원 로그인 시 프로필사진, 알람 노출 모듈화 페이지
    작성일: 2020-12-26
    작성자: 백희승
--%>
<%-- 
    파일명: Topbar.jsp
    수정사항: 알람페이지 추가
    작성일: 2020-12-31
    작성자: 정민찬
--%>
<!-- 
/*
	파일명:Topbar.jsp
	설명: 출/퇴근 기능추가 
	수정일 : 2020-01-07
	작성자 : 심재형 
*/
 -->
<%-- 
    파일명: Topbar.jsp
    수정사항: 알람기능 추가
    작성일: 2020-01-09
    작성자: 박선우
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/inc/HeadLink.jsp"></jsp:include>
<!-- Topbar -->
<nav class="navbar navbar-expand navbar-light bg-white topbar topbar-cst mb-4 static-top shadow">
	<!--  Sidebar Toggle (Topbar)-->
	<button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
		<i class="fa fa-bars"></i>
	</button>
	<!-- Topbar Navbar -->
	<ul class="navbar-nav ml-auto">
	<li class="nav-item my-auto">
	<div class="clock mx-4" id="clock"></div>
	</li>
		<li class="nav-item dropdown no-arrow "><a class="nav-link dropdown-toggle" id="attBtn" href="#" id="work" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-fingerprint" style="size: 9x; color:red;" ></i>
			</a>
			<div class="dropdown-menu dropdown-menu-right  shadow animated--grow-in" aria-labelledby="sear=Dropdown">
				
				<div class="input-group">
					<div class="input-group-append nom">
						<button class="dropdown-item toggletoggle btn-nom" id="startWork" >&nbsp;출근하기</button>
						<button class="dropdown-item toggletoggle btn-nom" id="endWork" style="display:none">&nbsp;퇴근하기</button>
					</div>
				</div>
				
			</div></li>
			
		
		<!-- 알람 -->
		<li class="nav-item dropdown no-arrow mx-1"><a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-bell fa-fw"></i>
				<!-- Counter - Alerts -->
				<span class="badge badge-danger badge-counter" id="counter"></span>
			</a> <!-- Dropdown - Alerts -->
			<div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown">
				<h6 class="dropdown-header">Alerts Center</h6>
				<div id="alarmlist"></div>
				<a class="dropdown-item text-center small text-gray-500 showmore" href="${pageContext.request.contextPath}/Alrams.do">Show All Alerts</a>
			</div>
		</li>
		<div class="topbar-divider d-none d-sm-block"></div>
		<sec:authentication property="name" var="LoginUser" />
		<!-- Nav Item - User Information -->
		<li class="nav-item dropdown no-arrow"><a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<span class="mr-2 d-none d-lg-inline text-gray-600 small" id="empinfo"> </span>
				<img class="img-profile rounded-circle" id="empimg" src="" onerror="this.src='/resources/img/undraw_profile_1.svg'">
			</a> <!-- Dropdown - User Information -->
			<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
				<a class="dropdown-item" href="/HRinfo/EditMyinfo.do">
					<i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> My Page
				</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
					<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i> Logout
				</a>
			</div></li>
	</ul>
</nav>
<div class="alarm"></div>
<input id="alcount" value="" hidden>
<style>
.cbody {
	padding-top: 5px;
	padding-bottom: 5px;
}

.alarm {
	position: absolute;
	width: 300px;
	top: 10px;
	left: 15rem;
}
@media screen and (max-width:768px){
	.alarm {
	position: absolute;
	width: 300px;
	top: 10px;
	left: 11rem;
}
}

@media screen and (max-width:685px){
	.alarm {
	position: absolute;
	width: 40%;
	top: 10px;
	left: 11rem;
}
}
@media screen and (max-width:580px){
	.alarm {
	position: absolute;
	width: 38%;
	top: 10px;
	left: 5rem;
}
}
@media screen and (max-width:490px){
	.alarm {
	position: absolute;
	width: 38%;
	top: 10px;
	left: 5rem;
}
}
.nom{
	margin: 0 auto !important;
}
.btn-nom{
	margin: 0 !important;
}
</style>
<link href='/resources/css/topWork.css' rel='stylesheet' />
<!-- End of Topbar -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- 날짜 변환 관련 CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.0/moment.min.js"></script>
<!-- SweetAlert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
setInterval(()=>{
	date();
},1000);

let count =0;
function date(){
	let date = new Date();
	let year = date.getFullYear();
	let month = date.getMonth()+1;
	let day = date.getDate();
	let week = new Array('일','월','화','수','목','금','토');
	let minutes = date.getMinutes() <10 ? "0"+date.getMinutes() : date.getMinutes();
	let hours = (date.getHours() >=12) ? date.getHours()-12 : date.getHours();
	let AMPM = (date.getHours() >=12) ? "PM " : "AM "
	let seconds = date.getSeconds() <10 ? "0"+date.getSeconds() : date.getSeconds();
	jb('#clock').text(year+"년 "+month+"월 "+day+"일 "+"("+week[date.getDay()]+") "+AMPM+hours+" : "+minutes+" : "+seconds); 
	
}



function connect(){

	websocket = new WebSocket('ws://13.209.211.229:8090/alarm.do');
	websocket.onopen =(evt) =>{
		
	};
	websocket.onclose =(evt) =>{
	}; 
	
	websocket.onmessage=(evt)=>{
			writeMsg(evt)	
		getCount();
	}
	
}
var i=1;
function writeMsg(evt){
	let html = JSON.parse(evt.data);
	let alarmTime = moment(html.alarmTime).format('YYYY-MM-DD'+" "+'HH:mm');
	let content =
		'<div class="card border-left-'+html.color+' shadow">\
		<div class="cbody card-body">\
			<div class="row no-gutters align-items-center">\
				<div class="col-auto">\
					<img src="/resources/img/speech-bubble.png">\
				</div>\
				<div class="col ml-4">\
					<div class="text-xs font-weight-bold text-'+html.color+' text-uppercase mb-1">ALARM  &nbsp;'+alarmTime+'</div>\
					<div class="h6 mb-0 font-weight-bold text-gray-700">'+html.content+'</div>\
				</div>\
			</div>\
		</div>\
	</div>';

	jb('.alarm').append(content);
	setTimeout(()=>{
		jb('.alarm').empty();
		},5000);

	let count = jb('#alcount').val();
	console.log(jb('#alcount').val());
	jb('#counter').empty();
	jb('#counter').append(parseInt(count)+1);
	jb('#counter').show();	

}


function disconnect(){
	websocket.close();
}
$.noConflict();
var jb= jQuery;
jb(document).ready(function() {
	
	var empno = ${LoginUser}+"";
	console.log(empno);
	jb.ajax({
		url:"/HRinfo/searchByEmpno.do",
		type:"POST",
		data:{empno:empno},
		success:function(data){
			var img = data.PIC;
			html=data.ENAME+' ('+data.DEPTNAME+') '+data.POSITIONNAME;
			jb('#empinfo').append(html);
			jb('#empimg').attr('src','/resources/upload/'+img);
			}
		
	});
	connect();

	function getCount(){
	jb.ajax({
		url:"/alarm/alarmCount.do",
		type:"POST",
		data:{empno:${LoginUser}},
		success:function(data){
			console.log(data);
			jb('#counter').empty();
			jb('#counter').append(data);
			jb('#alcount').val(data);

			if(data==0){
				jb('#counter').hide();
			}
			}
		});
		}
	getCount();

	jb('#alertsDropdown').on("click",function(){
		jb('#alarmlist').empty();
		jb.ajax({
			url:"/alarm/alarmlist.do",
			type:"POST",
			data:{
				empno:${LoginUser},
				index:0
				},
				
			success:function(data){

				console.log(data);
				jb.each(data,(index,item)=>{
					let docno = item.content.split('(')[1].split(')')[0];
					let content = (item.content.length>20) ? item.content.substr(0,27) +"..." : item.content
					let alarmTime = moment(item.alarmTime).format('YYYY-MM-DD'+" "+'HH:mm');
					let html ='<div class="dropdown-item d-flex align-items-left card border-left-'+item.color+' alist">\
					<input type="text" hidden name="docno" value='+docno+'>\
					<input type="text" hidden name="alarmno" value='+item.alarmno+'>\
					<div>\
					<div class="small text-gray-500">'+alarmTime+'</div>\
					<span class="font-weight-bold">'+content+'</span>\
						</div>\
						</div>';
				jb('#alarmlist').append(html);
				
				})
				
					
				
				}
				

			});


	}); 

	
		jb(document).on("click",".alist",function(){
			//console.log(this.children('input[name="alarmno"]').val() );
			alarmno=jb(this).children('input[name="alarmno"]').val();
			let docno = jb(this).children('input[name="docno"]').val();
			
			console.log("alarmno:"+alarmno);
			alaRead(alarmno)
			.then((resolve)=>{
				if(docno!=null){
					console.log("docno:"+docno);
					location.href="/approval/viewDocument.do?docno="+docno;
				}
			})
			
		});

		function alaRead(alarmno){
			return new Promise((resolve,reject)=>{
			jb.ajax({
				url:"/alarm/readAlarm.do",
				type:"POST",
				data:{alarmno:alarmno},
				success:function(){
				
					}
					
				});
				resolve('done');

			}) 
		}
		console.log(jb('#counter').text());

		
		
})
	
</script>