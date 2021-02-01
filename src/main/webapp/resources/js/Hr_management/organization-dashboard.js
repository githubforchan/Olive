var randomScalingFactor = function() {
	return Math.round(Math.random() * 2000000)
};
var barChartData;

jQuery(document).ready(function($) {
$('#collapseHRM').addClass('show');
		$('#collapseHRM').prev().removeClass('collapsed');
		$('#collapseHRM').prev().children().css("color","#fff");
	
	// 연도별 총 근속사원 수 현황 : 라인차트 실행부
	getLineChartData()
	.then(appendLineChart);
	
	// 부서별 근속사원 수 현황 : 파이차트 실행부
	getPieChartData()
	.then(appendPieChart);
	
	function getLineChartData(){
		return new Promise( (resolve, reject) => {
			$.ajax({
				url : "/HR_managementRest/getLineChartData.do", 
				type : "POST",
				success : (data) => {	// 수신 성공 시 resolve
					//console.log(">EmpCountByYear	::년도별 총 사원");
					console.log(data);
					//console.log(">labelList		::년도(라벨)");
					//console.log(data.labelList);
					// console.log(">hireResult::년도별 입사인원");
					// console.log(data.hireResult);
					// console.log(">leaveResult::년도별 퇴사인원");
					// console.log(data.leaveResult);
					resolve(data);
				},
				error : (xhr) => {		// 수신 실패 시 reject + throw Error
					console.log("STATUS CODE : " + xhr.status + " ERROR");
					reject(new Error("Chart Data Request is failed"));
				}
			});
		});
	}
	
	function appendLineChart(data) {
		var ctx = document.getElementById('employees-chart').getContext('2d');
		var stackedBar = new Chart(ctx, {
			type: 'line',
			data: {
				labels: data.labelList,
				datasets: [{
					label: '총 사원 수(명)',
					backgroundColor: "rgba(255, 201, 14, 0.5)",
					borderColor: "#FF7071",
					data: data.EmpCountByYear,
					lineTension: 0
				}]
			},
			options: {
				legend: {
				display: false
				},
				gridLines: {
					color: "rgb(234, 236, 244)",
					zeroLineColor: "rgb(234, 236, 244)",
					drawBorder: false,
					borderDash: [2],
					zeroLineBorderDash: [2]
				},
				maintainAspectRatio: false,
				layout: {
					padding: {
						left: 10,
						right: 25,
						top: 25,
						bottom: 0
					}
				},
				scales: {
					xAxes: [{
						stacked: true
					}],
					yAxes: [{
						stacked: true
					}]
				}
			},
			tooltips: {
				titleMarginBottom: 10,
				titleFontColor: '#6e707e',
				titleFontSize: 14,
				backgroundColor: "rgb(255,255,255)",
				bodyFontColor: "#858796",
				borderColor: '#dddfeb',
				borderWidth: 1,
				xPadding: 15,
				yPadding: 15,
				displayColors: false,
				caretPadding: 10
			},
			legend: {
				display: false
			}
		})
	}
	
	function getPieChartData() {
		return new Promise( (resolve, reject) => {
			$.ajax({
				url : "/HR_managementRest/getPieChartData.do", 
				type : "POST",
				success : (data) => {	// 수신 성공 시 resolve
					console.log(data.deptList);
					console.log(data.countList);
					resolve(data);
				},
				error : (xhr) => {		// 수신 실패 시 reject + throw Error
					console.log("STATUS CODE : " + xhr.status + " ERROR");
					reject(new Error("Chart Data Request is failed"));
				}
			});
		});
	}
	
	function appendPieChart(data) {
		var pieCtx = document.getElementById('groupedDept-chart').getContext('2d');
		var pieData = { 
				labels: data.deptList, 
				datasets: [ { 
					data: data.countList, 
					backgroundColor: [ "#f79546", "#9bba57", "#4f81bb", "#5f497a", "#a94069", "#ff5f34"], 
					hoverBorderColor: "rgba(0, 0, 0, 0.7)",
					hoverBorderWidth: 1
				}] 
		};
		var pie = new Chart(pieCtx, {
			type : "pie",
			data : pieData,
			options: {
				gridLines: {
					color: "rgb(234, 236, 244)",
					zeroLineColor: "rgb(234, 236, 244)",
					drawBorder: false,
					borderDash: [2],
					zeroLineBorderDash: [2]
				},
				maintainAspectRatio: false,
				layout: {
					padding: {
						left: 10,
						right: 0,
						top: 0,
						bottom: 0
					}
				},
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
					display: true,
					position: "right",
					fontSize: 14,
					padding: 40
				},
				pieceLabel: { 
					mode:"label", 
					position:"outside", 
					fontSize: 14, 
					fontStyle: 'bold' 
				},
				cutoutPercentage: 80
			}
		});
	}
	
	
});