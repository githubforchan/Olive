// 타임스탬프 값을 년월일로 변환
function Unix_timestampDate(t) {
	var date = new Date(t);
	var year = date.getFullYear();
	var month = "0" + (date.getMonth() + 1);
	var day = "0" + date.getDate();


	return year + "-" + month.substr(-2) + "-" + day.substr(-2);
}


function Unix_timestampTime(t) {
	var date = new Date(t);
	var hour = "0" + date.getHours();
	var minute = "0" + date.getMinutes();
	var second = "0" + date.getSeconds();


	return  hour.substr(-2) + ":" + minute.substr(-2) + ":" + second;
}




$('#searchBtn').click(function() {
	let searchType2 = "";
	let keyword2 = $('#newKeyword').val();
	if ($('#newSearchType option:selected').val() == "사번") {
		searchType2 = "empno"
	} else if ($('#newSearchType option:selected').val() == "이름") {
		searchType2 = "ename"
	} else if ($('#newSearchType option:selected').val() == "본부") {
		searchType2 = "headname"
	} else if ($('#newSearchType option:selected').val() == "부서") {
		searchType2 = "deftname"
	}
	$.ajax({
		url: "/attendance/attPage.do",
		type: "POST",
		dataType: "JSON",
		data: {
			searchType2: searchType2,
			keyword2: keyword2
		},
		success: (data) => {
			$('#oldSearchType2').val(searchType2);
			$('#oldKeyword2').val(keyword2);
			insertDatabyAjax(data);
		}
	});
	$('#newKeyword').val("");
})


$(document).on("click", ".page-btn", function() {
	let searchType2;
	let keyword2;
	if( $('#oldSearchType2').val() === null || $('#oldSearchType2').val().trim() === "" ){
		searchType2 = $('#oldSearchType').val();
		keyword2 = $('#oldKeyword').val();
	}else {
		searchType2 = $('#oldSearchType2').val();
		keyword2 = $('#oldKeyword2').val();
	}
	let perPageNum = $('#oldPerPageNum').val();
	let page = $(this)[0].text;
	$.ajax({
		url: "/attendance/attPage.do",
		type: "POST",
		dataType: "JSON",
		data: {
			searchType2: searchType2,
			keyword2: keyword2,
			perPageNum: perPageNum,
			page: page
		},
		success: (data) => {
			console.log(data);

			insertDatabyAjax(data);
		}
	})
});

$(document).on("click", ".page-btn-prev", function() {
	let searchType2;
	let keyword2;
	if( $('#oldSearchType2').val() === null || $('#oldSearchType2').val().trim() === "" ){
		searchType2 = $('#oldSearchType').val();
		keyword2 = $('#oldKeyword').val();
	}else {
		searchType2 = $('#oldSearchType2').val();
		keyword2 = $('#oldKeyword2').val();
	}
	let perPageNum = $('#oldPerPageNum').val();
	let page = ($('#oldPage').val()-1);	
	console.log(page);
	$.ajax({
		url: "/attendance/attPage.do",
		type: "POST",
		dataType: "JSON",
		data: {
			searchType2: searchType2,
			keyword2: keyword2,
			perPageNum: perPageNum,
			page: page
		},
		success: (data) => {
			console.log(data);
			insertDatabyAjax(data);
		}
	})
});

$(document).on("click", ".page-btn-next", function() {
	let searchType2;
	let keyword2;
	if( $('#oldSearchType2').val() === null || $('#oldSearchType2').val().trim() === "" ){
		searchType2 = $('#oldSearchType').val();
		keyword2 = $('#oldKeyword').val();
	}else {
		searchType2 = $('#oldSearchType2').val();
		keyword2 = $('#oldKeyword2').val();
	}
	let perPageNum = $('#oldPerPageNum').val();
	let page = (parseInt($("#oldPage").val())+1);
	console.log(page);
	$.ajax({
		url: "/attendance/attPage.do",
		type: "POST",
		dataType: "JSON",
		data: {
			searchType2: searchType2,
			keyword2: keyword2,
			perPageNum: perPageNum,
			page: page
		},
		success: (data) => {

			insertDatabyAjax(data);
		}
	})
});




function insertDatabyAjax(data) {
	console.log(data.criteria);
	console.log(data.list);
	console.log(data.pagination);
	console.log(data.auth);
	$('#attListTable').empty();
	let inputListData = "";
	
	for (let i = 0; i < data.list.length; i++) {
		inputListData += "<tr>"
			+"<td>" + Unix_timestampDate(Number(data.list[i].starttime))+"</td>"
			+ "<td name='empno'>" + data.list[i].empno + "</td>"
			+ "<td>" + data.list[i].ename + "</td>"
			+ "<td>" + data.list[i].deptname + "</td>";
		
		if(data.list[i].starttime == null){
			inputListData += "<td>" + "</td>";	
		}else{ 
			inputListData += "<td>" + Unix_timestampTime(Number(data.list[i].starttime)) 	+ "</td>";
		}
		if(data.list[i].endtime == null){
			inputListData += "<td>" + "</td>";	
		}else{
			inputListData += "<td>" + Unix_timestampTime(Number(data.list[i].endtime)) 	+ "</td>";
		}
			
		
			for(let i=0; i<data.auth.length; i++){
				if(data.auth[i].authority == "ROLE_MANAGER"){
			inputListData += "<td><label class="+'userCheck'+"><input class="+'filter'+" type="+'radio'+" name = "+'user'+" ></label></td>";;
				}
			}
		}

			inputListData += "</tr>";
	$('#attListTable').html(inputListData);


	$('#pagination').empty();
	let inputPaginationData = "";
	if (data.pagination.prev == true) {
		inputPaginationData += "<li class='page-item'>"
			+ "<a class='page-link page-btn-prev' href='#' aria-label='Previous'>"
			+ "<span aria-hidden='true'>&laquo;</span>"
			+ "<span class='sr-only'>Previous</span>"
			+ "</a></li>"
	}
	for(let i=data.pagination.startPage; i<=data.pagination.endPage; i++){
	    if(i == data.criteria.page){
		        inputPaginationData += "<li class='page-item page-link'>"
									+ "<b>"
									+i +"</b></li>"
					    }else{
					        inputPaginationData += "<li class='page-item'>"
													+ "<a class='page-link page-btn' href='#'>" +i
													+"</a></li>"
		} 
	}	
	if (data.pagination.next == true) {
		inputPaginationData += "<li class='page-item'>"
			+ "<a class='page-link page-btn-next' href='#' aria-label='Next'>"
			+ "<span aria-hidden='true'>&raquo;</span>"
			+ "<span class='sr-only'>Next</span>"
			+ "</a></li>"
	}
	$('#pagination').html(inputPaginationData);


	$('#oldSearchType').val(data.criteria.searchType);
	$('#oldKeyword').val(data.criteria.keyword);
	$('#oldperPageNum').val(data.criteria.perPageNum);
	$('#oldPage').val(data.criteria.page);
}

$('#collapseAtt').addClass('show');
$('#collapseAtt').prev().removeClass('collapsed');
$('#collapseAtt').prev().children().css("color","#fff");
		

// 근태현황 : 근무시간 및 연장근무시간 pie chart

//Progress Bar 근태 툴팁 표시 및 파이차트
$(document).ready(function(){
	  $('[data-toggle="tooltip"]').tooltip();   
	  
	  let rh = Number($('.regularHour').text().trim()) * 60;
	  let rm = Number($('.regularMinute').text().trim());
	  let oh = Number($('.overHour').text().trim()) * 60;
	  let om = Number($('.overMinute').text().trim());
	  
	  const STIPULATED_TIME_PER_MINUTE = 52 * 60 ;	// 규정 근로시간(52시간)을 분(X 60)으로 환산
	  
	  let regularWorkPcnt = Number((((rh + rm) / STIPULATED_TIME_PER_MINUTE) * 100).toFixed(1));	// 규정 근무시간 내 근무한 시간
	  let overWorkPcnt = Number((((oh + om) / STIPULATED_TIME_PER_MINUTE) * 100).toFixed(1));	// 연장 근무 시간
	  let totalWorkPcnt = Number((100 - (Number(regularWorkPcnt) + Number(overWorkPcnt))).toFixed(1));		// 총 규정 근무시간(52시간) 내 잔여 근무가능 시간
	  
	  Highcharts.chart('pie', {
	  	  chart: {
	  		  zoomType: 'y',
	  		  plotBackgroundColor: null,
	  		  plotBorderWidth: null,
	  		  plotShadow: false,
	  		  type: 'pie'
	  	  },
	  	  title: {
	  		  text: '총<br>근무시간<br>(%)',
	  	      align: 'center',
	  	      verticalAlign: 'middle',
	  	      y: 20
	  	  },
	  	  tooltip: {
	  	    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
	  	  },
	  	  plotOptions: {
	  		  pie: {
	  		         dataLabels: {
	  		            enabled: true,
	  		            distance: 10,
	  		            style: {
	  		               fontWeight: 'bold',
	  		               color: 'white',
	  		               textShadow: '0px 1px 1px black'
	  		            }
	  		         },
	  		         startAngle: 0,
	  		         endAngle: 0,
	  		         center: ['50%', '50%']
	  		      }
	  	  },
	  	  series: [{
	  	      type: 'pie',
	  	      name: '근무시간',
	  	      innerSize: '60%',
	  	      data: [{
	  		    	  name : '정규 근무',
	  		    	  y: regularWorkPcnt,
	  		    	  sliced: true,
	  		    	  selected: false,
	  		    	  color: '#64dd17'
	  	      	},
	  	      	{
	  		    	  name : '연장 근무',
	  		    	  y: overWorkPcnt,
	  		    	  sliced: false,
	  		    	  selected: false,
	  		    	  color: '#8500CD'
	  	      	},
	  	      	{
	  		    	  name : '잔여근무',
	  		    	  y: totalWorkPcnt,
	  		    	  sliced: false,
	  		    	  selected: false,
	  		    	  color: '#f5f5f5'
	  	      	}
	  	      ]
	  	  }],
	  	  exporting: false,
	  	  credits: {
	  		  enabled: false
	  	  }
	  	  
	  });

});


