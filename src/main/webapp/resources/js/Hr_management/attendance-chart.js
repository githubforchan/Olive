/**
 * 
 */
$(document).ready(function() {
	console.log("시작");
	$.ajax({
		url: "/HR_managementRest/getAttGroupByDept.do",
		data: {
			deptName: "인사팀"
		},
		dataType: "JSON",
		type: 'POST',
		success: function(data) {
			console.log(data);
			chart(data);
		}
	})
})

var ctx = $("#attChartForDept");
function chart(data) {

	var chart = new Chart(ctx, {
		type: 'line',
		data: {
			labels: data.labels,
			datasets: [{
				label:"인사팀",
				data: data.인사팀,
				fill: false,
				lineTension: 0,
				hoverBorderColor: "rgb(242,166,54)",
				borderColor:"rgba(242,166,54,.5)"
			}, {
				data: data.사업팀,
				label : "사업팀",
				fill: false,
				lineTension: 0,
				hoverBorderColor: "rgb(39,79,76)",
				borderColor:"rgba(39,79,76,.5)"
			}, {
				data: data.마케팅팀,
				label : "마케팅팀",
				fill: false,
				lineTension: 0,
				hoverBorderColor: "rgb(40,161,130)",
				borderColor:"rgba(40,161,130,.5)"
			}, {
				data: data.개발팀,
				label:"개발팀",
				fill: false,
				lineTension: 0,
				hoverBorderColor: "rgb(206,29,22)",
				borderColor:"rgba(206,29,22,.5)"
			}, {
				data: data.운영팀,
				label:"운영팀",
				fill: false,
				lineTension: 0,
				hoverBorderColor: "rgb(63,114,175)",
				borderColor :"rgba(63,114,175,.5)"
			},{
				data: data.회계팀,
				label:"회계팀",
				fill : false,
                lineTension : 0,
				hoverBorderColor: "rgb(22, 199, 154)",
				borderColor:"rgba(22, 199, 154,.5)"
			}]
		},
		options: {
			maintainAspectRatio: false,
			tooltips: {
				backgroundColor: "rgb(255,255,255)",
				bodyFontColor: "#858796",
				borderColor: '#dddfeb',
				borderWidth: 1,
				xPadding: 15,
				yPadding: 15,
				displayColors: false,
				caretPadding: 10,
			},
			legend: {
				display: true
			}
		}
	})
}