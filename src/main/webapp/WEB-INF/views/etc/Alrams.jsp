<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>Project_HR</title>
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
				<sec:authentication property="name" var="LoginUser" />
				<!-- Begin Page Content -->
				<div class="container-fluid">
					<!-- Page Heading -->
					<div class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">대쉬보드</h1>
						<a href="#" id="readAll" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">전체 읽음 표시</a>
					</div>
					<div id="alarmWrapper">
						
					</div>
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- End of Main Content -->
			<!-- Footer 모듈화 -->
			<jsp:include page="/WEB-INF/views/inc/Footer.jsp"></jsp:include>
			<!-- End of Footer 모듈화 -->
		</div>
		<!-- End of Content Wrapper -->
	</div>
	<!-- End of Page Wrapper -->
	<!-- 모든 스크립트 모듈화 -->
	<jsp:include page="/WEB-INF/views/inc/BottomLink.jsp"></jsp:include>
	<script src="/resources/js/skycons.js"></script>
	<!-- 무한 스크롤링 -->
	<script type="text/javascript">
	let page = 0;
	
	$(function(){  //페이지가 로드되면 데이터를 가져오고 page를 증가시킨다.
	     getList(page);
	     page++;
	}); 

	$(window).scroll(function(){
		console.log('windowScrollTop:'+$(window).scrollTop());
		console.log('documentHeight:'+$(document).height());
		console.log('windowHeight:'+$(window).height());
		console.log($(document).height()-$(window).height());
		if($(window).scrollTop() >= $(document).height() - $(window).height()){
			console.log('sjsj');
			getList(page);
			page++;
		} 
	});

	function getList(page){
		$.ajax({
			type : 'POST',
			dataType : 'json',
			data : {
				index : page,
				empno: ${LoginUser}
				},
			url : '/alarm/alarmlist.do',
			success : function(data){
				if(data.length!=0){
					let now = moment()
					console.log(now);
				$.each(data,(index,item)=>{
					let docno = item.content.split('(')[1].split(')')[0];
					let alarmtime = moment(item.alarmTime).format('YYYY-MM-DD'+" "+'HH:mm');
					let diff = Math.floor(moment.duration(now.diff(alarmtime)).asMinutes());
					let timediff = (diff>60) ? Math.floor(moment.duration(now.diff(alarmtime)).asHours())+"시간 전" : diff+"분 전"; 
					let html='<div class="row">\
						<div class="col-12 mb-4 alist">';
						if(item.alarmCheck==false){
						html+='<div class="card border-left-'+item.color+' shadow h-100 py-2"\
									style="background-color: #f2ffff">';
							}else{
						html +='<div class="card border-left-'+item.color+' shadow h-100 py-2">';
							}
						html+='<div class="card-body">\
								<div class="row no-gutters align-items-center">\
									<div class="col mr-2">\
										<div class="text-m font-weight-bold text-'+item.color+' text-uppercase mb-1">\
												ALARM - '+alarmtime+'</div>\
										<div class="h5 mb-0 font-weight-bold text-gray-800">'+item.content+'</div>\
									</div>\
									<div class="col-auto text-secondary">'+timediff+'\
								</div>\
								</div>\
							</div>\
					</div>\
					<input type="text" hidden name="docno" value='+docno+'>\
					<input type="text" hidden name="alarmno" value='+item.alarmno+'>\
				</div>\
			</div>';
				$('#alarmWrapper').append(html);	
				
					})
				if(data.length<=4){
					html='<div class="text-center text-secondary mx-auto"> 더 이상 알람이 없습니다 </div>';
					$('#alarmWrapper').append(html);
					}	
				}
			},error:function(e){
				if(e.status == 300){
					alert("데이터를 가져오는데 실패");
				}
			}
		})

		$('#readAll').on("click",function(){
			$.ajax({
				url:"/alarm/readAllAlarm.do",
				data:{empno:${LoginUser}},
				type :'POST',
				success:function(data){
					location.href=data;
					}
				

				})

			})
			

		
			
	}
	</script>
</body>
</html>