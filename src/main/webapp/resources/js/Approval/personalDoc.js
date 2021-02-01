/**
  파일명: personalDoc.js
  설명: 내가올린 기안서  
  작성일: 2021-01-08    
  작성자: 박선우 
 */
$(function() {
	var today = new Date();

	$('#collapseEA').addClass('show');
	$('#collapseEA').prev().removeClass('collapsed');
	$('#collapseEA').prev().children().css("color","#fff");
	
	console.log(today);


	$('.doc').on("click", function() {
		console.log($(this).val());

		$.ajax({
			url: "/approval/getArrangedDocList.do",
			dataType: "json",
			mehtod: "get",
			contentType: "application/json; charset=utf-8",
			data: {
				statusCode: $(this).val(),
			},
			success: function(data) {
				createTable(data);

			}
		})

	});

	$(document).on("click", ".page-btn", function() {
		let searchType = $('#oldSearchType').val();
		let keyword = $('#oldKeyword').val();
		let searchType2 = $('#oldSearchType2').val();
		let keyword2 = $('#oldKeyword2').val();
		let perPageNum = $('#oldPerPageNum').val();
		let page = $(this)[0].text;

		$.ajax({
			url: "/approval/getArrangedDocListAjax.do",
			type: "POST",
			dataType: "JSON",
			data: {
				searchType: searchType,
				keyword: keyword,
				searchType2: searchType2,
				keyword2: keyword2,
				perPageNum: perPageNum,
				page: page

			},
			success: (data) => {
				createTable(data);
			}
		})
	});

	$(document).on("click", ".page-btn-prev", function() {
		let searchType = $('#oldSearchType').val();
		let keyword = $('#oldKeyword').val();
		let searchType2 = $('#oldSearchType2').val();
		let keyword2 = $('#oldKeyword2').val();
		let perPageNum = parseInt($('#oldPerPageNum').val()) - 1;
		let page = $(this)[0].text;

		console.log(page);
		$.ajax({
			url: "/approval/getArrangedDocListAjax.do",
			type: "POST",
			dataType: "JSON",
			data: {
				searchType: searchType,
				keyword: keyword,
				searchType2: searchType2,
				keyword2: keyword2,
				perPageNum: perPageNum,
				page: page
			},
			success: (data) => {
				createTable(data);
			}
		})
	});

	$(document).on("click", ".page-btn-next", function() {

		let searchType = $('#oldSearchType').val();
		let keyword = $('#oldKeyword').val();
		let searchType2 = $('#oldSearchType2').val();
		let keyword2 = $('#oldKeyword2').val();
		let perPageNum = parseInt($('#oldPerPageNum').val() + 1);
		let page = $(this)[0].text;

		console.log(page);
		$.ajax({
			url: "/approval/getArrangedDocListAjax.do",
			type: "POST",
			dataType: "JSON",
			data: {
				searchType: searchType,
				keyword: keyword,
				searchType2: searchType2,
				keyword2: keyword2,
				perPageNum: perPageNum,
				page: page
			},
			success: (data) => {
				createTable(data);
			}
		})
	});


	function createTable(data) {
		$('#docBody').empty();
		console.log(data);

		$.each(data.pagingList, (index, item) => {
			let time = moment(item.writedate).format("YYYY-MM-DD");
			

			let html = '<tr><td>' + item.docno + '</td>\
						<td>'+ time + '</td>\
			<td><a href="viewDocument.do?docno='+ item.docno+'">'+ item.title+'</a></td>\
			<td>'+ item.ename + '</td>\
			<td>'+ item.typename+ '</td>\
			<td><div class="row">\
			<div class="col-md-7 px-0 mx-0">\
			<div class="progress">\
			<div class="progress-bar" role="progressbar" style="width:'+ (100 * item.curr_Approval / item.total_Approval)  + '%;"\
			aria-valuenow="'+ item.curr_Approval  + '" aria-valuemin="0">' + item.curr_Approval +   '/' + item.total_Approval  + '</div>\
			</div>\
			</div>\
			<div class="col-md-4 px-0 mx-0">'+item.statusname+'</div></div></td></tr>';		
			$('#docBody').append(html);

			$('#pagination').empty();
			let inputPaginationData = "";
			if (data.pagination.prev == true) {
				inputPaginationData += "<li class='page-item'>"
					+ "<a class='page-link page-btn-prev' href='#' aria-label='Previous'>"
					+ "<span aria-hidden='true'>&laquo;</span>"
					+ "<span class='sr-only'>Previous</span>"
					+ "</a></li>";
			};
			for (let i = data.pagination.startPage; i <= data.pagination.endPage; i++) {
				if (i == data.criteria.page) {
					inputPaginationData += "<li class='page-item page-link'>"
						+ "<b>"
						+ i + "</b></li>";
				} else {
					inputPaginationData += "<li class='page-item'>"
						+ "<a class='page-link page-btn' href='#'>"+i
						+ "</a></li>";
				};
			};
			if (data.pagination.next == true) {
				inputPaginationData += "<li class='page-item'>"
					+ "<a class='page-link page-btn-next' href='#' aria-label='Next'>"
					+ "<span aria-hidden='true'>&raquo;</span>"
					+ "<span class='sr-only'>Next</span>"
					+ "</a></li>"
			};
			$('#pagination').html(inputPaginationData);
			$('#oldSearchType2').val(data.criteria.searchType2);
			$('#oldKeyword2').val(data.criteria.keyword2);
			$('#oldSearchType').val(data.criteria.searchType);
			$('#oldKeyword').val(data.criteria.keyword);
			$('#oldperPageNum').val(data.criteria.perPageNum);
			$('#oldPage').val(data.criteria.page);
		});

	};




});