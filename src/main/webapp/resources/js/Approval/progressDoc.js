/**
  파일명: progressDoc.js
  설명: 문서 결재 함  
  작성일: 2021-01-08    
  작성자: 박선우 
 */
//결재할 문서 바뀌는 부분  
$(function() {
	$('#collapseEA').addClass('show');
	$('#collapseEA').prev().removeClass('collapsed');
	$('#collapseEA').prev().children().css("color","#fff");
	
	function createTable(data) {
		$('#appBody').empty();
		console.log(data);
		$.each(data.pagingList, (index, item) => {
			let writetime = new Date(item.writedate);
			let apptime = new Date(item.app_date);
			console.log(apptime);
			console.log("typecode:" + item.typeCode);
			let html = '<tr><td>' + item.docno + '</td>';
			if (item.app_Check == '0' || item.app_check == null) {
				html += '<td>대기</td>';
			} else {
				html += '<td>완료</td>';
			}
			html += '<td><a href="viewDocument.do?docno=' + item.docno + '&typeCode=' + item.typeCode + '" name="document">' + item.title + '</a>\
					</td>\
						<td>'+ item.ename + '</td>\
						<td>'+ item.typename + '</td>\
						<td>'+ writetime.getFullYear() + '-' + ('0' + (writetime.getMonth() + 1)).slice(-2) + '-' + ('0' + writetime.getDate()).slice(-2) + '</td>';

			if (!isNaN(apptime.getFullYear())) {
				html += '<td>' + apptime.getFullYear() + '-' + ('0' + (apptime.getMonth() + 1)).slice(-2) + '-' + ('0' + apptime.getDate()).slice(-2) + '</td>';
			} else {
				html += '<td>-</td>';
			}
			html +=
				'<td>\
						<div class="progress">\
						<div class="progress-bar" role="progressbar" style="width:'+ (100 * item.curr_Approval / item.total_Approval) + '%;" aria-valuenow="' + item.curr_Approval + '" aria-valuemin="0" aria-valuemax="' + item.total_Approval + '">' + item.curr_Approval + '/' + item.total_Approval + '</div>\
						</div>\
						</td>\
						</tr>';
			$('#appBody').append(html);

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
			if (data.pagination.next ==true) {
				inputPaginationData += "<li class='page-item'>"
					+ "<a class='page-link page-btn-next' href='#' aria-label='Next'>"
					+ "<span aria-hidden='true'>&raquo;</span>"
					+ "<span class='sr-only'>Next</span>"
					+ "</a></li>"
			}
			$('#pagination').html(inputPaginationData);
			$('#oldSearchType2').val(data.criteria.searchType2);
			$('#oldKeyword2').val(data.criteria.keyword2);

			$('#oldSearchType').val(data.criteria.searchType);
			$('#oldKeyword').val(data.criteria.keyword);
			$('#oldperPageNum').val(data.criteria.perPageNum);
			$('#oldPage').val(data.criteria.page);
		});

	}

	$('.doc').on("click", function() {
		$('#searching').css("display","block");
		if($(this).val()!=50){
			$('#searching').css("display","none");
		}
		let html = '';
		$.ajax({
			url: "/approval/getArrangedAppList.do",
			dataType: "json",
			mehtod: "POST",
			contentType: "application/json; charset=utf-8",
			data: {
				statusCode: $(this).val()
			},
			success: function(data) {
				createTable(data)

			}


		});

		console.log(html);
	});

	$('#app_ref').on("click", function() {
		console.log("상태코드" + $(this).val());
		let html = '';
		$.ajax({
			url: "/approval/getArrangedAppListRef.do",
			dataType: "json",
			mehtod: "POST",
			contentType: "application/json; charset=utf-8",
			data: {
				statusCode: $(this).val()
			},
			success: function(data) {
				createTable(data)
			}
		});
	});

	$(document).on("click", ".page-btn", function() {
		let searchType = $('#oldSearchType').val();
		let keyword = $('#oldKeyword').val();
		let searchType2 = $('#oldSearchType2').val();
		let keyword2 = $('#oldKeyword2').val();
		let perPageNum = $('#oldPerPageNum').val();  
		let page = $(this)[0].text;

		$.ajax({
			url: "/approval/getArrangedAppListAjax.do",
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
		let perPageNum = parseInt($('#oldPerPageNum').val()-1);
		let page = $(this)[0].text;

		console.log(page);
		$.ajax({
			url: "/approval/getArrangedAppListAjax.do",
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
		let perPageNum = parseInt($('#oldPerPageNum').val()+1);
		let page = $(this)[0].text;

		console.log(page);
		$.ajax({
			url: "/approval/getArrangedAppListAjax.do",
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


	
	

})