<!-- 
    파일명 : Organization_chart.jsp
    설명 : 조직도 페이지
    작성일 : 2020-12-28
    작성자 : 박채연
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>Organization_chart</title>
<!-- 스타일시트, CDN 모듈화 -->
<jsp:include page="/WEB-INF/views/inc/HeadLink.jsp"></jsp:include>
<style>
h1{
	text-decoration: underline;
	font-weight: bold;
	text-decoration-color: #ffe561;
	text-decoration-thickness: 5px;
}
.highcharts-figure, .highcharts-data-table table {
	min-width: 2000px;
	max-width: 2000px;
	margin: 1em auto;
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
					<h1 class="h3 mb-2 text-gray-800">인사정보</h1>
					<!-- Content Row -->
					<div class="row">
						<div class="col-xl-12 col-lg-12">
							<!-- Area Chart -->
							<div class="card shadow mb-4 mt-5">
								<div class="card-header py-3">
									<div class="form-group col-md-2 mb-0">
										<button id="open" class="form-control">
										펼치기 
										</button>
											
									</div>
								</div>
								<div class="row justify-content-end mx-5"></div>
								<div class="card-body" id="org-chart">
									<figure class="highcharts-figure">
										<div id="container"></div>
										<p class="highcharts-description"></p>
									</figure>
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
	<!-- 추가 script -->
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	<script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/modules/sankey.js"></script>
	<script src="https://code.highcharts.com/modules/organization.js"></script>
	<script src="https://code.highcharts.com/modules/exporting.js"></script>
	<script src="https://code.highcharts.com/modules/accessibility.js"></script>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<style>
.highcharts-figure, .highcharts-data-table table {
	min-width: 360px;
	margin: 1em auto;
}

.highcharts-data-table table {
	font-family: Verdana, sans-serif;
	border-collapse: collapse;
	border: 1px solid #EBEBEB;
	margin: 10px auto;
	text-align: center;
	width: 100%;
	max-width: 500px;
}

.highcharts-data-table caption {
	padding: 1em 0;
	font-size: 1.2em;
	color: #555;
}

.highcharts-data-table th {
	font-weight: 600;
	padding: 0.5em;
}

.highcharts-data-table td, .highcharts-data-table th,
	.highcharts-data-table caption {
	padding: 0.5em;
}

.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even)
	{
	background: #f8f8f8;
}

.highcharts-data-table tr:hover {
	background: #f1f7ff;
}

#container h4 {
	text-transform: none;
	font-size: 14px;
	font-weight: normal;
}

#container p {
	font-size: 13px;
	line-height: 16px;
}

@media screen and (max-width: 600px) {
	#container h4 {
		font-size: 2.3vw;
		line-height: 3vw;
	}
	#container p {
		font-size: 2.3vw;
		line-height: 3vw;
	}
}
</style>
	<script type="text/javascript">
	    //ajax
	    $('#open').click(function(){
	        var select = $(this).val();
	        console.log(select);

					        console.log(empdata);
					        console.log(emplist);


					      //Highchart 시작  ------------ 
							Highcharts.chart('container',{
							chart : {
								height : 600,
								inverted : true
							},
							title : {
								text : 'Olive'
							},
							keys: ['from', 'to'],
							accessibility : {
								point : {
									descriptionFormatter : function(point) {
										var nodeName = 
											point.toNode.name, 
											nodeId = point.toNode.id, 
											nodeDesc = nodeName === nodeId ? nodeName
												: nodeName + ', ' + nodeId, 
											parentDesc = point.fromNode.id;
										
										return point.index + '. ' + nodeDesc
												+ ', reports to ' + parentDesc
												+ '.';
									}
								}
							} ,
							series : [ {
								type : 'organization',
								name : 'Olive',
								keys : [ 'from', 'to' ],
								data : empdata,
								levels : [ {
									level : 1,
									color : '#980104'
								}, {
									level : 2,
									color : '#359154'
								},{
									level : 3,
									color : 'orange'
								} ],
								nodes : emplist,
								colorByPoint : false,
								color : '#007ad0',
								dataLabels : {
									color : 'white'
								},
								borderColor : 'white',
								nodeWidth : 40
							} ],
							tooltip : {
								outside : true
							},
							exporting : {
								allowHTML : true,
								sourceWidth : 100,
								sourceHeight : 100
							}

						});
						        
						
	    });
					        
	  	
///////////////////////////////////////
var empdata = [];
/* google.charts.load('current', {packages:["orgchart"]});
google.charts.setOnLoadCallback(drawChart); */
var emplist = [];
	
		
		 
function createFirstTree(){
	
	return new Promise((resolve,reject)=>{
		
	$.ajax({
	url:"organization.do",
	 dataType: "json",
	 contentType: "application/json; charset=utf-8",
	success:function(responsedata){
		$.each(responsedata,(index,item)=>{
			console.log(item);
			if(item.positionname=='팀원'){
			empdata[empdata.length] = [item.deptname,item.ename];
			 emplist[emplist.length] = {
				      id: item.ename,
				      name:item.ename,
				      title:item.positionname,
				      image: "/resources/img/undraw_profile.svg"
				      
				    };
 
				}else if(item.positionname=='팀장'){
					empdata[empdata.length] = [item.headname, item.deptname];
					 emplist[emplist.length] = {
						      id: item.deptname,
						      name:item.ename,
						      title:item.deptname,
						      image: "/resources/img/undraw_profile.svg",
						   	   layout: 'hanging'
						    }; 
					}else if(item.positionname=='본부장'){
						empdata[empdata.length] = ["OLIVE", item.headname];
						emplist[emplist.length] = {
							      id: item.headname,
							      name:item.ename,
							      title:item.headname,
							      image: "/resources/img/undraw_profile.svg"
							    }; 
						}
				})
			resolve();
			}
		});

	});
};



createFirstTree();

$('#collapseInfo').addClass('show');
$('#collapseInfo').prev().removeClass('collapsed');
$('#collapseInfo').prev().children().css("color","#fff");

  							
		
		
		
		

			
							
						
						

    



      
   </script>
</body>
</html>