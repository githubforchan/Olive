/*
	파일명: validationBeforeInsert.js
	설명: 계정 관리 >> 사원 신규 등록 유효성 검사 + 부서 코드 select
	작성일: 2021-01-02
	작성자: 백희승
*/
jQuery(document).ready(function($) {

	$('.datepicker').flatpickr();

	// DB에서 가져온 본부, 직책, 직위 보여주기
	showHeadQuarters();
	getPosition();
	getClass();

	// 본부 select > option 뿌려주기
	function showHeadQuarters() {
		$.ajax({
			url: "/HR_managementRest/getHead.do",
			type: "POST",
			success: (data) => {
				makeHQOptions(data);
			},
			error: (xhr) => {
				console.log(xhr.status + " : showHeadQuarters() ERROR");
			}
		});
	}

	function makeHQOptions(data) {
		let headQuarters = "<option value='null'>본부를 선택해주세요</option>";
		data.forEach((element) => {
			headQuarters += "<option value='" + element.headCode + "'>" + element.headName.trim() + "</option>";
		});
		$("#head").append(headQuarters);
	} // 본부 select > option 뿌려주기


	// DB에서 가져와 만들어진 option 태그에 이벤트 생성
	$('select[id="head"]').on({
		"change": makeDeptOptions
	});

	function makeDeptOptions() {
		$.ajax({
			url: "/HR_managementRest/getDept.do",
			type: "POST",
			data: { headCode: $(this).val() },
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
	} // DB에서 가져와 만들어진 option 태그에 동적 이벤트 생성



	// class : 직위 가져오기
	function getClass() {
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
	function getPosition() {
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

	// 생년월일 = 초기비밀번호
	$("#birth").on("propertychange change keyup paste input", function() {
		let currVal = $(this).val();
		let pwd = currVal.substring(0,4)+currVal.substring(5,7)+currVal.substring(8,10);
		console.log(pwd)
		$("#pwd").val(pwd);
	});

	// 중복 empno 유효성 검사
	$('#empNo').keyup(() => {
		if ($('#empNo').val() == "") {
			$('#checkEmpNo').empty();
			return;
		}
		$.ajax({
			url: "/HR_managementRest/checkEmpNo.do",
			data: { empNo: $('#empNo').val() },
			type: "POST",
			success: (data) => {
				$('#checkEmpNo').empty();

				if (data == "") {
					$('#checkEmpNo').append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + $('#empNo').val() + " : 사용 가능합니다.");
					$('#checkEmpNo').css("color", "green");
				} else if (data != null) {
					$('#checkEmpNo').append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + data.empNo + " : 이미 존재합니다.");
					$('#checkEmpNo').css("color", "red");
				}
			},
			error: (xhr) => {
				alert(xhr.status + " : ERROR");
			}
		});

	}); // 중복 empno 유효성 검사

	// Validation Start
	$('#submitBtn').click(empSubmit);

	function empSubmit() {
		const dateReg = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;

		if ($('#ename').val().trim() === "") {
			swal("이름을 입력해주세요.", "warning");

		} else if (!dateReg.test($('#birth').val())) {
			swal("생년월일을 정확히 입력해주세요.", "예) 1992-02-03", "warning");

		} else if (!dateReg.test($('#hireDate').val())) {
			swal("입사 날짜를 정확히 입력해주세요.", "예) 2020-03-05", "warning");

		} else if ($('#head').val() === "null") {
			swal("본부를 선택하세요.", "", "warning");

		} else if ($('#dept').val() === "null") {
			swal("부서를 선택하세요.", "", "warning");

		} else if ($('#position').val() === "null") {
			swal("직책을 선택하세요.", "", "warning");

		} else if ($('#class').val() === "null") {
			swal("직위를 선택하세요.", "", "warning");

		} else {
			swal({
				title: "입력한 사원을 등록하시겠습니까?",
				icon: "info",
				buttons: true,
				dangerMode: true,
			})
				.then((confirm) => {
					if (confirm) {
						$("#newEmpForm").submit();
					}
				});
		}
	} // Validation End
});

$("#hireDate,#head,#dept").change(function() {
	const date = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
	let hireDateValue = $('#hireDate').val();
	let headValue = $('#head').val();
	let deptValue = $('#dept').val();
	let empno = (hireDateValue.substring(2, 4) + hireDateValue.substring(5, 7) + headValue.substring(0, 1) + deptValue.substring(0, 1));

	if ((!date.test(hireDateValue) || (headValue === "null") || (deptValue === "null"))) {
		return;
	}
	$.ajax({
		url: "/HR_managementRest/createEmpno.do",
		data: {
			empno: empno
		},
		type: "POST",
		success: (data) => {
			console.log(data);
			$('#empNo').val(data);
		},
	});
});

$('#collapseHRM').addClass('show');
		$('#collapseHRM').prev().removeClass('collapsed');
		$('#collapseHRM').prev().children().css("color","#fff");
		


