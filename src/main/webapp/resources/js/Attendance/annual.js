// 타임스탬프 값을 년월일로 변환
function Unix_timestamp(t) {
	var date = new Date(t);
	var year = date.getFullYear();
	var month = "0" + (date.getMonth() + 1);
	var day = "0" + (date.getDate());
	var hour = "0" + date.getHours();
	var minute = "0" + date.getMinutes();
	var second = "0" + date.getSeconds();



	return year + "-" + month.substr(-2) + "-" + day.substr(-2) + " " + hour.substr(-2) + ":" + minute.substr(-2) + ":" + second.substr(-2);
}








$('#searchBtn').click(function() {
	let searchType = "";
	let keyword = $('#newKeyword').val();
	if ($('#newSearchType option:selected').val() == "사번") {
		searchType = "empno"
	} else if ($('#newSearchType option:selected').val() == "부서") {
		searchType = "deptname"
	} else if ($('#newSearchType option:selected').val() == "이름") {
		searchType = "ename"
	}
	$.ajax({
		url: "/Annual/analPage.do",
		type: "POST",
		dataType: "JSON",
		data: {
			searchType: searchType,
			keyword: keyword
		},
		success: (data) => {
			insertDatabyAjax(data);
		}
	});
	$('#newKeyword').val("");
})


$(document).on("click", ".page-btn", function() {
	let searchType = $('#oldSearchType').val();
	let keyword = $('#oldKeyword').val();
	let perPageNum = $('#oldPerPageNum').val();
	let page = $(this)[0].text;
	$.ajax({
		url: "/Annual/analPage.do",
		type: "POST",
		dataType: "JSON",
		data: {
			searchType: searchType,
			keyword: keyword,
			perPageNum: perPageNum,
			page: page
		},
		success: (data) => {
			console.log("나옴");
			insertDatabyAjax(data);
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
		url: "/Annual/analPage.do",
		type: "POST",
		dataType: "JSON",
		data: {
			searchType: searchType,
			keyword: keyword,
			perPageNum: perPageNum,
			page: page
		},
		success: (data) => {
			insertDatabyAjax(data);
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
		url: "/Annual/analPage.do",
		type: "POST",
		dataType: "JSON",
		data: {
			searchType: searchType,
			keyword: keyword,
			perPageNum: perPageNum,
			page: page
		},
		success: (data) => {
			insertDatabyAjax(data);
		}
	})
});




function insertDatabyAjax(data) {
	//console.log(data.criteria);
	//console.log(data.list);
	//console.log(data.pagination);

	$('#annualTable').empty();
	let inputListData = "";
	for (let i = 0; i < data.list.length; i++) {
		inputListData += "<tr>"
			+ "<td>" + data.list[i].docno + "</td>"
			+ "<td name="+'empno'+">" + data.list[i].empno + "</td>"
			+ "<td>" + data.list[i].ename + "</td>"
			+ "<td>" + data.list[i].count + "</td>"
			+ "<td>" + Unix_timestamp(Number(data.list[i].startdate)) + "</td>"
			+ "<td>" + Unix_timestamp(Number(data.list[i].enddate))+ "</td>"
			+ "<td><label class="+'userCheck'+"><input class="+'filter'+" type="+'radio'+" name = "+'user'+" ></label></td>"
			+ "</tr>"
	}
	$('#annualTable').html(inputListData);


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
			inputPaginationData += "<li class='page-item page-link'>"
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
			+ "<span aria-hidden='true'>>&raquo;</span>"
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
		
