/**
 * 
 */
$(document).ready(function($) {



	createHeadList();
	getClassList();
	getPositionList();
	// DB에서 가져와 만들어진 option 태그에 이벤트 생성
	$('select[id="head"]').on({
		"change": getDeptList
	});

	$('.datepicker').flatpickr();

	$("#resetBtn").click(function() {
		let empno = $("#empNo").val();
		$.ajax({
			url: "/HR_managementRest/resetAccount.do",
			type: "POST",
			data: { empno: empno },
			success: function(data) {
				location.href = "/HR_management/empEdit.do?empno=" + data;
			},
			error: (xhr) => {
				console.log(xhr.status + " : showHeadQuarters() ERROR");
			}
		});
	})

	$("#retireBtn").click(function() {
		let empno = $("#empNo").val();
		$.ajax({
			url: "/HR_managementRest/retireAccount.do",
			type: "POST",
			data: { empno: empno },
			success: (data) => {
				location.href = "/HR_management/empEdit.do?empno=" + data;
			},
			error: (xhr) => {
				console.log(xhr.status + " : showHeadQuarters() ERROR");
			}
		});
	})

})

$("#head").change(function() {
	$("#headCode").val($("#head").val());
	$("#tempHead").val($('#head option:selected').text());
	$("#deptCode").val($("#dept").val().empty);
	$("#tempDept").val("");
})

$("#dept").change(function() {
	$("#deptCode").val($("#dept").val());
	$("#tempDept").val($('#dept option:selected').text());
})

$("#class").change(function() {
	$("#classCode").val($("#class").val());
	$("#tempClass").val($('#class option:selected').text());
})
$("#position").change(function() {
	$("#positionCode").val($("#position").val());
	$("#tempPosition").val($('#position option:selected').text());
})




function check() {
	if ($('#empNo').val().trim() == "") {
		swal("이름을 입력해주세요.", "warning");

	} else if ($('#headCode').val() == "null") {
		swal("본부를 선택하세요.", "", "warning");

	} else if ($('#deptCode').val() == "null") {
		swal("부서를 선택하세요.", "", "warning");

	} else if ($('#positionCode').val() == "null") {
		swal("직책을 선택하세요.", "", "warning");

	} else if ($('#classCode').val() == "null") {
		swal("직위를 선택하세요.", "", "warning");

	} else {
		editBtn()
	}
	
} // Validation End



function editBtn() {
	$.ajax({
		url: "/HR_managementRest/updateEmp.do",
		type: "POST",
		data: {
			empNo: $("#empNo").val(),
			ename: $("#ename").val(),
			birth: $("#birth").val(),
			hireDate: $("#hireDate").val(),
			leaveDate: $("#leaveDate").val(),
			headcode: $("#headCode").val(),
			deptCode: $("#deptCode").val(),
			positionCode: $("#positionCode").val(),
			classCode: $("#classCode").val()
		},
		success: (data) => {
			swal("수정 완료","","warning");
			location.href = "/HR_management/EmployeeAccount.do";
		},
		error: (xhr) => {
			console.log(xhr.status + " : editBtn() ERROR");
		}
	});
}

// 본부 select > option 뿌려주기
function createHeadList() {
	$.ajax({
		url: "/HR_managementRest/getHead.do",
		type: "POST",
		success: (data) => {
			getHeadList(data);
		},
		error: (xhr) => {
			console.log(xhr.status + " : showHeadQuarters() ERROR");
		}
	});
}

function getHeadList(data) {
	let headQuarters = "<option value='null'>본부 선택</option>";
	data.forEach((element) => {
		headQuarters += "<option value='" + element.headCode + "'>" + element.headName.trim() + "</option>";
	});
	$("#head").append(headQuarters);
}

// class : 부서 가져오기
function getDeptList() {
	$.ajax({
		url: "/HR_managementRest/getDept.do",
		type: "POST",
		data: { headCode: $(head).val() },
		success: (data) => {
			$("#dept").empty();
			let depts = "<option value='null'>" + $("#head option:selected").html() + "본부 소속의 부서 선택</option>";
			data.forEach((element) => {
				depts += "<option value='" + element.deptCode + "'>" + element.deptName.trim() + "</option>";
			});
			$("#dept").append(depts);
		},
		error: (xhr) => {
			console.log(xhr.status + " : makeDeptOptions() ERROR");
		}
	});
}

// class : 직급 가져오기
function getClassList() {
	$.ajax({
		url: "/HR_managementRest/getClass.do",
		type: "POST",
		success: (data) => {
			let classes = "<option value='null'>직위 선택</option>";
			data.forEach((element) => {
				classes += "<option value='" + element.classCode + "'>" + element.className.trim() + "</option>";
			});
			$("#class").append(classes);
		},
		error: (xhr) => {
			console.log(xhr.status + " : getclass() ERROR")
		}
	});
}

// position : 직책 가져오기
function getPositionList() {
	$.ajax({
		url: "/HR_managementRest/getPosition.do",
		type: "POST",
		success: (data) => {
			let positions = "<option value='null'>직책 선택</option>";
			data.forEach((element) => {
				positions += "<option value='" + element.positionCode + "'>" + element.positionName.trim() + "</option>";
			});
			$("#position").append(positions);
		},
		error: (xhr) => {
			console.log(xhr.status + " : getPosition() ERROR")
		}
	});
}
$("#submitBtn").click(check)
