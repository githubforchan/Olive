jQuery(document).ready(function($) {

	// 엔터 키 막기
	$('#email, #code').keydown(function() {
		if (event.keyCode === 13) {
			event.preventDefault();
		}
	});

	// 인증번호 보내기 클릭 이벤트
	$('#submitBtn').click(() => {
		if (checkEmail($('#email').val())) {
			sendEmail();
			$('#checkEmail').attr('disabled', true);
			$('#submitBtn').attr('disabled', true);
		}
	});

	// 이메일 유효성검사
	function checkEmail(email) {
		const email_Regex = /^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{1,5}$/i;
		let flag = false;

		if (email.trim() === '') {
			console.log("이메일을 입력해주세요.");
		} else if (!email_Regex.test(email)) {
			console.log("올바른 이메일 형식을 입력해주세요.");
		} else {
			flag = true;
		}
		return flag;
	}


	// 이메일 중복 막기 =
	$('#email').keyup(() => {
		checkEmailDB($('#email').val());
	});

	//이메일 인증 시 인증된 이메일 DB 비교 AJAX
	function checkEmailDB(email) {

		$.ajax({
			url: "checkEmail_Pwd.do",
			type: "POST",
			data: { email: $('#email').val() },
			async: false,
			success: (data) => {
				console.log(data);
				console.log(data.ename);
				$('#email').empty();
				if (data == "") {
					$('#checkEmail').empty();
					$('#email').removeClass('invalid-form-control').addClass('valid-form-control');
					$('#checkEmail').append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;사용가능한 이메일입니다.");
					$('#checkEmail').css("color", "white");
					$('#submitBtn').removeClass('btn-secondary').addClass('btn-primary').attr('disabled', false);
				} else if (data != null) {
					$('#checkEmail').empty();
					$('#email').removeClass('valid-form-control').addClass('invalid-form-control');
					$('#checkEmail').append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;이미 사용중인 이메일입니다.");
					$('#checkEmail').css("color", "white");
					$('#submitBtn').removeClass('btn-primary').addClass('btn-secondary').attr('disabled', true);
				}
			},
			error: (xhr) => {
				console.log(xhr.status);
			}
		});

	}

	
	// 이메일 보내기
	function sendEmail() {
		$('.loader').css('visibility', 'visible');
		$('.loader').css('oppacity', '1');
		$.ajax({
			url: "registEmail.do",
			type: "POST",
			data: { email: $('#email').val() },
			success: () => {
				$('.loader').css('visibility', 'hidden');
				$('.loader').css('oppacity', '0');
				swal("인증번호 발송 완료", $('#email').val() + " 이메일로 인증번호가 발송되었습니다.", "success");
				$('#code').attr('readonly', false);

				$('#finalCheck').removeClass('btn-secondary').addClass('btn-primary').attr('disabled', false);
			},
			error: (xhr) => {
				console.log(xhr.status);
			}
		});
	}

	// 코드 유효성검사
	function checkCode(code) {
		let flag = false;

		if (code.trim() === '') {
			swal('인증번호를 입력해주세요.');
		} else if (code.trim().length <= 5) {
			swal('올바른 인증번호를 입력해주세요.');
		} else {
			flag = true;
		}
		return flag;
	}

	// 인증번호 체크
	$('#finalCheck').click(() => {
		if (checkCode($('#code').val())) {

			$.ajax({
				url: "certificate.do",
				type: "POST",
				data: {
					inputCode: $('#code').val(),
					email: $('#email').val()
				},
				success: (isCorrect) => {
					if (isCorrect) {

						swal({
							title: "인증 완료",
							text: $('#email').val() + " 이메일로 인증이 완료되었습니다! 다시 로그인해주세요!",
							icon: "success",
						});

						// 시각적으로 완료되었음을 표시
						$('#finalCheck').removeClass('btn-primary').addClass('btn-secondary').attr('disabled', true);
						$('#submitBtn').removeClass('btn-primary').addClass('btn-secondary').attr('disabled', true);
						$('#email').attr('readonly', true);
						$('#code').attr('readonly', true);

						// 완료되어 페이지 이동 버튼 생성
						let homeBtn = "<button type='button' id='goToWork' class='btn btn-success btn-user btn-block'>다시 로그인하기</button>";
						$('#goToMain').append(homeBtn);

					} else {

						swal("인증 실패", "인증번호를 확인해주세요", "error");
					}
				},
				error: (xhr) => {
					swal("서버 오류", "처음부터 다시 시도하기 바랍니다.", "warning");
				}
			});
		}
	}); // 인증번호 체크

	// 일하러 가기 버튼 : 이메일 인서트, role 부여, 상태코드 20 부여
	$(document).on('click', 'button[id="goToWork"]', () => {
		$.ajax({
			url: "goToWork.do",
			type: "POST",
			data: { email: $('#email').val() },
			success: (url) => {
				location.href = "/" + url;
			},
			error: (xhr) => {
				console.log(xhr.status);
			}
		});
	});



	/////////비밀번호////////////////////
	$('#pwdemail').keyup(() => {
		checkDB($('#pwdemail').val());
	});


	// 비밀번호 재설정 시 인증번호 보내기 클릭 이벤트
	$('#submitBtnPwd').click(() => {
		sendPwdEmail();
		$('#pwdemail').attr('disabled', true);
		$('#submitBtnPwd').attr('disabled', true);
	});

	// 비밀번호 재설정 시 인증된 이메일 DB 비교 AJAX
	function checkDB(email) {


		$.ajax({
			url: "checkEmail_Pwd.do",
			type: "POST",
			data: { email: $('#pwdemail').val() },
			success: (data) => {
				console.log(data);
				console.log(data.ename);
				if (data == "") {
					$('#checkEmail').empty();
					$('#pwdemail').removeClass('valid-form-control').addClass('invalid-form-control');
					$('#checkEmail').append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;인증되지 않은 이메일입니다.");
					$('#checkEmail').css("color", "white");
					$('#submitBtnPwd').removeClass('btn-primary').addClass('btn-secondary').attr('disabled', true);
					
				} else if (data != null) {
					$('#checkEmail').empty();
					$('#pwdemail').removeClass('invalid-form-control').addClass('valid-form-control');
					$('#checkEmail').append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + data.ename + "님 메일함을 확인해주세요.");
					$('#checkEmail').css("color", "white");
					$('#submitBtnPwd').removeClass('btn-secondary').addClass('btn-primary').attr('disabled', false);

				}
			},
			error: (xhr) => {
				console.log(xhr.status);
			}
		});


	}

	// 이메일 보내기
	function sendPwdEmail() {
		$('.loader').css('visibility', 'visible');
		$('.loader').css('oppacity', '1');
		$.ajax({
			url: "registEmail.do",
			type: "POST",
			data: { email: $('#pwdemail').val() },
			success: () => {
				$('.loader').css('visibility', 'hidden');
				$('.loader').css('oppacity', '0');
				swal("인증번호 발송 완료", $('#pwdemail').val() + " 이메일로 인증번호가 발송되었습니다.", "success");
				$('#code').attr('readonly', false);

				$('#pwdfinalCheck').removeClass('btn-secondary').addClass('btn-primary').attr('disabled', false);
			},
			error: (xhr) => {
				console.log(xhr.status);
			}
		});
	}

	// 비밀번호용 인증번호 체크
	$('#pwdfinalCheck').click(() => {
		if (checkCode($('#code').val())) {

			$.ajax({
				url: "certificate.do",
				type: "POST",
				data: {
					inputCode: $('#code').val(),
					email: $('#email').val()
				},
				success: (isCorrect) => {
					if (isCorrect) {

						swal({
							title: "인증 완료",
							text: "이메일 인증이 완료되었습니다!",
							icon: "success",
						});


						// 비밀번호 재설정 페이지
						$('#emailCheckPage').hide();
						$('#setPwdPage').show();
						$('#setpwd').attr('readonly', false);
						$('#setpwdcon').attr('readonly', false);
						$('#setpwdcheck').removeClass('btn-secondary').addClass('btn-primary').attr('disabled', false);


					} else {

						swal("인증 실패", "인증번호를 확인해주세요", "error");
					}
				},
				error: (xhr) => {
					swal("서버 오류", "처음부터 다시 시도하기 바랍니다.", "warning");
				}
			});
		}
	}); // 인증번호 체크


	//비밀번호 확인 체크
	$('#setpwdcon').keyup(function(){
		if($('#setpwd').val()!=$('#setpwdcon').val()){
			$('#checkPwd').text('');
			$('#checkPwd').html("비밀번호가 일치하지 않습니다.");
			$('#checkPwd').css("color", "#eb4034");
		}else{
			$('#checkPwd').text('');
			$('#checkPwd').html("비밀번호가 일치합니다.");
			$('#checkPwd').css("color", "white");
		}
	})
	// 비밀번호 재설정
	$('#setpwdcheck').click(function() {
		console.log()
		console.log($('#pwdemail').val());
		console.log($('#setpwd').val());
		pwd1 = $('#setpwd').val();
		pwd2 = $('#setpwdcon').val();
		//null 값 막기	
		if(pwd1.trim() === '' || pwd2.trim() === ''){
			swal("", "비밀번호를 입력해주세요", "warning");
		}else{
			$.ajax({
			url: "updatePwd.do",
			type: "POST",
			data: {
				email: $('#pwdemail').val(),
				pwd: $('#setpwd').val()
			},
			success: (data) => {
				console.log(data);
				swal({
					title: "인증 완료",
					text: "비밀번호 설정이 완료되었습니다!",
					type: "success",
					timer: 2000,
				}).then(function() {
					location.href = "goToLogin.do";
				});

			},
			error: (xhr) => {
				console.log(xhr.status);
			}
		});

		}
		
	});


});