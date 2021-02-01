let empno;
document.addEventListener('DOMContentLoaded', function() {

	var calendarEl = document.getElementById('calendar');


	var calendar = new FullCalendar.Calendar(calendarEl,{
			headerToolbar: {
				left: 'prev,next today',
				center: 'title',
				right: 'custom,dayGridMonth,timeGridWeek,timeGridDay,listWeek'
			},
			buttonText: {
				today: '오늘',
				month: '월',
				week: '주',
				day: '일',
				list: '주간 일정표'
			},
			//initialDate : '2020-09-12', // 캘린더 지정날짜로 보이게하기 
			navLinks: true, // can click day/week names to navigate views
			nowIndicator: true,
			weekNumbers: true,
			weekNumberCalculation: 'ISO',
			editable: true,
			selectable: true,
			dayMaxEvents: true, // allow "more" link when too many events
			displayEventTime:false,
			themeSystem: 'bootstrap',
			events: eventFeed
				
		});
		$(document).on('change','.filter', function () {
			empno = $(this).parents().children('td[name=empno]').text();
			console.log("gd"+empno)
			calendar.refetchEvents();
		});	
	calendar.render();
});
var eventFeed = function(info, successCallback,failureCallback) {
		if($("input:radio[name=user]").is(":checked") == true){
			console.log("ㅎ"+empno)
			$.ajax({
			type: "POST",
			url: "/attendance/calendarUserList.do",
			dataType: "json",
			data:{
				empno:empno
			},
			success: function(data) {
				successCallback(data);
				console.log(data);
			},
			error: function(xhr) {
				console.log(xhr.status)
			}
		});
		}else{
		$.ajax({
			type: "GET",
			url: "/attendance/calendarList.do",
			dataType: "json",
			success: function(data) {
				successCallback(data);
				console.log(data);
			},
			error: function(xhr) {
				console.log(xhr.status)
			}
		});
		}
	}
