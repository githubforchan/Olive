/*
	파일명: searchAndPaging.js
    설명: 인사관리 - 계정 관리 - 게시판 비동기 
    작성일: 2021-01-06
    작성자: 정민찬
*/

$('#excelBtn').on('click', function() {
	let searchType = $('#oldSearchType').val();
	let keyword = $('#oldKeyword').val();
	location.href="/HR_management/EmpTableToExcel.do?searchType="+searchType+"&"+"keyword="+keyword;
});