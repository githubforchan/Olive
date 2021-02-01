
function uploadProcess() {
	var form = new FormData(document.getElementById('uploadForm'));
	console.log(form);
	if (check()) {
		$.ajax({
			url: "/HR_managementRest/uploadExcelFile.do",
			data : form,
			processData: false,
			contentType: false,
			type: "POST",
			success: function(data) {
				if (data == true) {
					alert("모든 데이터가 업로드 되었습니다.");
					location.href = "/HR_management/Salary.do";
				} else {
					alert("업로드 실패...")
				}
			},
			error: function(err) {
				console.log(err.status);
				alert("업로드 실패....제출 양식을 확인해주세요");
			}
		})
	}
}

function check() {
	var fileName = $("#excelFile").val().split("\\")[2];
	console.log(fileName);
	if (fileName == "" || fileName == null) {
		alert("파일을 선택해주세요.");
		return false;
	} else if (!checkFileType(fileName)) {
		alert("엑셀 파일만 업로드 가능합니다.");
		return false;
	} else {return true;}
}

function checkFileType(fileName) {
	return (fileName.indexOf("xls") > -1) ? true : false
}

