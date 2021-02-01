jQuery(document).ready(function($) {

	$('#attBtn').on("click",function(){
		$.ajax({
			type: "POST"
			, url: "/attendance/isPunchedIn.do"
			, success: function(data) {
				if(data === null || data === ""){	// 미출근 상태 : 출근 버튼 활성화
					toggleAttBtn(data, true);
				}else{ 								// 출근 처리됨 : 퇴근 버튼 활성화
					toggleAttBtn(data, false);
				}
			}
		});
	});
	
	function toggleAttBtn(data, flag){
		if(flag){
			$('#startWork').css('display', 'block');
			$('#endWork').css('display', 'none');
		}else {
			$('#startWork').css('display', 'none');
			$('#endWork').css('display', 'block');
		}
	}
	
	// 출근 전 확인
	$('#startWork').click(function(e) {
		e.stopPropagation();
		$.ajax({
			type: "POST"
			, url: "/attendance/isPunchedIn.do"
			, success: function(data) {
				if(typeof data == "undefined" || data === null || data === ""){	// 미출근 시 출근처리
					startWork();
				}else{ 								// 이미 출근 처리됨을 알림
					swal("이미 처리됨", propperTime(data.start) + " 부로 이미 처리되었습니다.", "info");
				}
			}
		});
	});
	
	// 퇴근 전 확인
	$('#endWork').click(function(e) {
		e.stopPropagation();
		$.ajax({
			type: "POST"
			, url: "/attendance/isPunchedIn.do"
			, success: function(data) {
				console.log("퇴근 확인 콘솔");
				console.log(data);
				console.log(data.start);
				console.log("퇴근데이터 undifined 확인");
				console.log(typeof data.end);
				console.log(typeof data.end == "undefined");
				if(typeof data.start == "undefined" || data.start === null || data.start === ""){
					swal("처리 불가", "출근 처리가 되지 않았습니다. 부서 내 관리자에게 문의바랍니다.", "warning");
				}else {
					if(typeof data.end == "undefined" || data.end === null || data.end === ""){
						swal({
							title: "퇴근하시겠습니까?",
							icon: "warning",
							buttons: true,
							dangerMode: true,
						}).then((end) => {
							if (end) {
								endWork();
							}
						});
					}else {
						swal({
							title: "퇴근시간을 갱신하시겠습니까?",
							text: "이미 " + propperTime(data.end) + " 부로 퇴근처리가 완료되었습니다.\n 퇴근시간을 덮어쓰시겠습니까?",
							icon: "warning",
							buttons: true,
							dangerMode: true,
						}).then((end) => {
							if (end) {
								endWork();
							}
						});
					}
				}
			}
		});
	});
	
	// 출근하기
	function startWork(){
		$.ajax({
			type: "POST"
			, url: "/attendance/startWork.do"
			, success: function(data) {
				swal("출근 처리됨", propperTime(data.start) + " 부로 출근 처리되었습니다.", "success");
			}
		});
	}
	
	// 퇴근하기
	function endWork(){
		$.ajax({
			type: "POST",
			url: "/attendance/endWork.do",
			success: function(data) {
				swal("퇴근 처리됨", propperTime(data.end) + " 부로 퇴근 처리되었습니다.", "success");
			}
		});
	}
	
	// TimeStamp 변환
	function propperTime(timeStamp){
		let date = new Date(timeStamp);
		
		//let year = date.getFullYear().toString().slice(-2);
		//let month = ("0" + (date.getMonth() + 1)).slice(-2);
		//let day = ("0" + date.getDate()).slice(-2);
		let hour = ("0" + date.getHours()).slice(-2);
		let minute = ("0" + date.getMinutes()).slice(-2);
		//let second = ("0" + date.getSeconds()).slice(-2); 
		
		return hour + "시 " + minute + "분";
	}
	
});