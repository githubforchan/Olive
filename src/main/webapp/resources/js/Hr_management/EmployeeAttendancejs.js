/*
	파일명: searchAndPaging.js
    설명: 인사관리 - 직원 근태 휴가 관리 
    작성일: 2021-01-012
    작성자: 박채연 
*/

// 타임스탬프 값을 년월일로 변환
function Unix_timestamp(t) {
	var date = new Date(t);
	var year = date.getFullYear();
	var month = "0" + (date.getMonth() + 1);
	var day = "0" + date.getDate();
	var hour = "0" + date.getHours();
	var minute = "0" + date.getMinutes();
	var second = "0" + date.getSeconds();

	return year + "-" + month.substr(-2) + "-" + day.substr(-2) + " " + hour.substr(-2) + ":" + minute.substr(-2) + ":" + second.substr(-2);
}


$(document).on("click", ".editBtn", function() {

	$('.comBtn').show();
	$('.comBtn').addClass("btn btn-primary");
	$('.editBtn').hide();
	$('.checkBtn').hide();
	console.log("Hi");
	//$('#annListTable td')
	//var checkBtn = $(this);
	var editBtn = $(this);
	var tr = editBtn.parent().parent();
	var td = tr.children();
	var no = td.eq(0).text();

	var html = td.eq(2).html();
	console.log(html);
	var input = $('<input type="text" id="annual" name="annual"/>');
	input.val(html);
	$(td.eq(2)).html(input);

	$('.comBtn').on('click', function() {
		var tr = $(this).parent().parent();
		var td = tr.children();
		var empno = td.eq(0).html();
		var annual = $('#annual').val();
		console.log(empno);
		console.log(annual);


		$.ajax({
			url: "/HR_managementRest/updateAnnual.do",
			type: "POST",
			data: {
				empno: empno,
				annual: annual
			},
			success: (data) => {
				location.href = data;
			}, error: function(error) {
				console.log(error);
			}
		});
	});
});

//퇴근처리 수정
$(document).on("click", '.attBtn', function() {
	var tr = $(this).parent().parent();
	var td = tr.children();
	var empno = td.eq(0).html();
	var start = td.eq(2).html();
	console.log(empno);
	console.log(start);

	$.ajax({
		url: "/HR_managementRest/updateAttRecord.do",
		type: "POST",
		data: {
			empno: empno,
			starttime: start
		},
		success: (data) => {
			console.log(data);
			location.href = data;
		}, error: function(error) {
			console.log(error);
		}
	});

});





//휴가관리 이력 모달
$(document).on("click", ".checkBtn", function() {
	var checkBtn = $(this);
	var tr = checkBtn.parent().parent();
	var td = tr.children();
	var empno = td.eq(0).text();

	$('#annBody').empty();
	$.ajax(
		{
			type: "POST",
			url: "/HR_managementRest/getAnnualList.do",
			data: { empno: empno },
			success: (data) => {
				var html = "";
				console.log(data);

				if ((Array.isArray(data)) && data.length === 0) {
					html += "<tr><td colspan=7><h3>연차사용 내역이 존재하지 않습니다.</h3>"
					$('#annBody').append(html)
				}
				for (let i = 0; i < data.length; i++) {
					let writedate = moment(data[i].writedate).format("YYYY-MM-DD");
					console.log(writedate);
					let enddate = moment(data[i].enddate).format("YYYY-MM-DD");
					let startdate = moment(data[i].startdate).format("YYYY-MM-DD");
					let typename = data[i].typename.substring(0, 2);

					html += "<tr>"
						+ "<td>" + data[i].empno + "</td>"
						+ "<td>" + data[i].ename + "</td>"
						+ "<td>" + typename + "</td>"
						+ "<td>" + writedate + "</td>"
						+ "<td>" + startdate + "</td>"
						+ "<td>" + enddate + "</td>"
						+ "<td>" + data[i].timediff + "</td>"
						+ "</tr>"

					$('#annBody').append(html)

				}

				$('#EmpModal').modal('show');
			},
			error: function(error) {
				console.log(error);
			}
		}
	);
});



//근태관리 비동기
$('#searchBtn').click(function() {
	let searchType = "";
	let keyword = $('#newKeyword').val();
	if ($('#newSearchType option:selected').val() == "사번") {
		searchType = "EMPNO"
	} else if ($('#newSearchType option:selected').val() == "부서") {
		searchType = "DEPTNAME"
	} else if ($('#newSearchType option:selected').val() == "이름") {
		searchType = "ENAME"
	}
	$.ajax({
		url: "/HR_managementRest/getAttList.do",
		type: "POST",
		dataType: "JSON",
		data: {
			searchType: searchType,
			keyword: keyword
		},
		success: (data) => {
			insertDatabyAjax1(data);
		}
	});
	$('#newKeyword').val("");
})


$(document).on("click", ".page-btn", function() {
	let searchType = $('#oldSearchType').val();
	let keyword = $('#oldKeyword').val();
	let perPageNum = $('#oldPerPageNum').val();
	let page = $(this)[0].text;
	console.log(perPageNum);
	console.log(page);
	$.ajax({
		url: "/HR_managementRest/getAttList.do",
		type: "POST",
		dataType: "JSON",
		data: {
			searchType: searchType,
			keyword: keyword,
			perPageNum: perPageNum,
			page: page
		},
		success: (data) => {
			insertDatabyAjax1(data);
		}
	})
});

$(document).on("click", ".page-btn-prev", function() {
	let searchType = $('#oldSearchType').val();
	let keyword = $('#oldKeyword').val();
	let perPageNum = $('#oldPerPageNum').val();
	let page = ($('#oldPage').val() - 1);
	console.log(page);
	$.ajax({
		url: "/HR_managementRest/getAttList.do",
		type: "POST",
		dataType: "JSON",
		data: {
			searchType: searchType,
			keyword: keyword,
			perPageNum: perPageNum,
			page: page
		},
		success: (data) => {
			insertDatabyAjax1(data);
		}
	})
});

$(document).on("click", ".page-btn-next", function() {
	let searchType = $('#oldSearchType').val();
	let keyword = $('#oldKeyword').val();
	let perPageNum = $('#oldPerPageNum').val();
	let page = (parseInt($("#oldPage").val()) + 1);
	console.log(page);
	$.ajax({
		url: "/HR_managementRest/getAttList.do",
		type: "POST",
		dataType: "JSON",
		data: {
			searchType: searchType,
			keyword: keyword,
			perPageNum: perPageNum,
			page: page
		},
		success: (data) => {
			insertDatabyAjax1(data);
		}
	})
});





function insertDatabyAjax1(data) {
	console.log(data.list);
	console.log("결과 값");
	$('#attListTable').empty();
	let inputListData = "";
	for (let i = 0; i < data.list.length; i++) {

		let starttime = moment(data.list[i].starttime).format("YYYY-MM-DD hh mm ss");
		let endtime = moment(data.list[i].endtime).format("YYYY-MM-DD hh mm ss");
		inputListData += "<tr>";
		inputListData += "<td>" + data.list[i].empno + "</td>";
		inputListData += "<td>" + data.list[i].ename + "</td>";
		inputListData += "<td>" + Unix_timestamp(Number(data.list[i].starttime)) + "</td>";
		if(data.list[i].endtime == null){
			inputListData += "<td>" + "</td>";	
		}else{
			inputListData += "<td>" + Unix_timestamp(Number(data.list[i].endtime)) 	+ "</td>";

		}

		inputListData += "<td>" + data.list[i].attname + "</td>";
		if (data.list[i].attname != '정상') {
			inputListData += "<td><button class='attBtn btn btn-primary'>정상처리</button></td>"
		} else {
			inputListData += "<td></td>"
		}
		inputListData += "</tr>";


	}
	$('#attListTable').html(inputListData);
	console.log("여기");
	console.log(inputListData);

	$('#pagination').empty();
	let inputPaginationData = "";
	if (data.pagination.prev == true) {
		inputPaginationData += "<li class='page-item'>"
			+ "<a class='page-link page-btn-prev' href='#' aria-label='Previous'>"
			+ "<span aria-hidden='true'>&laquo;</span>"
			+ "<span class='sr-only'>Previous</span>"
			+ "</a></li>"
	}
	for (let i = data.pagination.startPage; i <= data.pagination.endPage; i++) {
		if (i == data.criteria.page) {
			inputPaginationData += "<li class='page-item page-link paging-background'>"
				+ "<b>"
				+ i + "</b></li>"
		} else {
			inputPaginationData += "<li class='page-item'>"
				+ "<a class='page-link page-btn' href='#'>" + i
				+ "</a></li>"
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



//휴가관리 비동기
$('#searchBtn2').click(function() {
	let searchType = "";
	let keyword = $('#newKeyword2').val();
	if ($('#newSearchType2 option:selected').val() == "사번") {
		searchType = "EMPNO"
	} else if ($('#newSearchType2 option:selected').val() == "부서") {
		searchType = "DEPTNAME"
	} else if ($('#newSearchType2 option:selected').val() == "이름") {
		searchType = "ENAME"
	}
	$.ajax({
		url: "/HR_managementRest/getAnnList.do",
		type: "POST",
		dataType: "JSON",
		data: {
			searchType: searchType,
			keyword: keyword
		},
		success: (data) => {
			console.log("HI");
			console.log(data);
			insertDatabyAjax2(data);
		}
	});
	$('#newKeyword2').val("");
})


$(document).on("click", ".page-btn2", function() {
	let searchType = $('#oldSearchType2').val();
	let keyword = $('#oldKeyword2').val();
	let perPageNum = $('#oldPerPageNum2').val();
	let page = $(this)[0].text;
	console.log(perPageNum);
	console.log(page);
	$.ajax({
		url: "/HR_managementRest/getAnnList.do",
		type: "POST",
		dataType: "JSON",
		data: {
			searchType: searchType,
			keyword: keyword,
			perPageNum: perPageNum,
			page: page
		},
		success: (data) => {
			console.log("durl");
			console.log(data);
			insertDatabyAjax2(data);
		}
	})
});

$(document).on("click", ".page-btn-prev2", function() {
	let searchType = $('#oldSearchType2').val();
	let keyword = $('#oldKeyword2').val();
	let perPageNum = $('#oldPerPageNum2').val();
	let page = ($('#oldPage2').val() - 1);
	console.log(page);
	$.ajax({
		url: "/HR_managementRest/getAnnList.do",
		type: "POST",
		dataType: "JSON",
		data: {
			searchType: searchType,
			keyword: keyword,
			perPageNum: perPageNum,
			page: page
		},
		success: (data) => {
			insertDatabyAjax2(data);
		}
	})
});



$(document).on("click", ".page-btn-next2", function() {
	let searchType = $('#oldSearchType2').val();
	let keyword = $('#oldKeyword2').val();
	let perPageNum = $('#oldPerPageNum2').val();
	let page = (parseInt($("#oldPage2").val()) + 1);
	console.log(page);
	$.ajax({
		url: "/HR_managementRest/getAnnList.do",
		type: "POST",
		dataType: "JSON",
		data: {
			searchType: searchType,
			keyword: keyword,
			perPageNum: perPageNum,
			page: page
		},
		success: (data) => {
			insertDatabyAjax2(data);
		}
	})
});




function insertDatabyAjax2(data) {
	console.log(data.criteria);
	console.log(data.list);
	console.log(data.pagination);
	console.log(data.list[0].empno);
	console.log(data.list[0].startdate);
	$('#annListTable').empty();
	let inputListData = "";
	for (let i = 0; i < data.list.length; i++) {
		inputListData += "<tr>"
			+ "<td>" + data.list[i].empno + "</td>"
			+ "<td>" + data.list[i].ename + "</td>"
			+ "<td>" + data.list[i].annual + "</td>"
			+ "<td>" + data.list[i].COUNT + "</td>"
			+ "<td>" + data.list[i].DIFF + "</td>"
			+ "<td><input type='button' class='checkBtn btn btn-primary' value='목록' />"
			+ "<input type='button' class='editBtn btn btn-primary' value='수정' />"
			+ "<input type='button' class='comBtn' value='완료' />"
			+ "</td>"
			+ "</tr>"
	}
	$('#annListTable').html(inputListData);


	$('#pagination2').empty();
	let inputPaginationData = "";
	if (data.pagination.prev == true) {
		inputPaginationData += "<li class='page-item'>"
			+ "<a class='page-link page-btn-prev2' href='#' aria-label='Previous'>"
			+ "<span aria-hidden='true'>&laquo;</span>"
			+ "<span class='sr-only'>Previous</span>"
			+ "</a></li>"
	}
	for (let i = data.pagination.startPage; i <= data.pagination.endPage; i++) {
		if (i == data.criteria.page) {
			inputPaginationData += "<li class='page-item page-link paging-background'>"
				+ "<b>"
				+ i + "</b></li>"
		} else {
			inputPaginationData += "<li class='page-item'>"
				+ "<a class='page-link page-btn2' href='#'>" + i
				+ "</a></li>"
		}
	}
	if (data.pagination.next == true) {
		inputPaginationData += "<li class='page-item'>"
			+ "<a class='page-link page-btn-next2' href='#' aria-label='Next'>"
			+ "<span aria-hidden='true'>&raquo;</span>"
			+ "<span class='sr-only'>Next</span>"
			+ "</a></li>"
	}
	$('#pagination2').html(inputPaginationData);


	$('#oldSearchType2').val(data.criteria.searchType);
	$('#oldKeyword2').val(data.criteria.keyword);
	$('#oldperPageNum2').val(data.criteria.perPageNum);
	$('#oldPage2').val(data.criteria.page);
}


