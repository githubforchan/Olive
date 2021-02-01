function priceToString(price) {
	return price.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}
$(document).ready(function() {
	$.ajax({
		url: "/HR_managementRest/getSalChartDataForDept.do",
		type: "POST",
		success: function(data) {
			let labelsForchart1 = new Array;
			let datasetsForchart1 = new Array;
			for (let i = 0; i < data.length; i++) {
				labelsForchart1.push(data[i].dept)
				datasetsForchart1.push(data[i].total)
			}
			getSalChartDataForDept(labelsForchart1, datasetsForchart1);
		}
	})
	$.ajax({
		url: "/HR_managementRest/getSalChartDataForClass.do",
		type: "POST",
		success: function(data) {
			let labelsForchart2 = new Array;
			let datasetsForchart2 = new Array;
			for (let i = 0; i < data.length; i++) {
				labelsForchart2.push(data[i].class)
				datasetsForchart2.push(data[i].total)
			}
			getSalChartDataForClass(labelsForchart2, datasetsForchart2);
		}
	})
})

function getSalChartDataForDept(labelsForchart1, datasetsForchart1) {
	let ctx = $("#salChartForDept");
	var getSalChartDataForDept = new Chart(ctx, {
		type: 'bar',
		data: {
			labels: labelsForchart1,
			datasets: [
				{
					label: "평균 급여",
					backgroundColor: [
						"rgba(242,166,54,.5)",
						"rgba(39,79,76,.5)",
						"rgba(40,161,130,.5)",
						"rgba(206,29,22,.5)",
						"rgba(242,166,54,.5)",
						"rgba(39,79,76,.5)",
						"rgba(40,161,130,.5)",
						"rgba(206,29,22,.5)"
					],
					borderColor: [
						"rgb(242,166,54)",
						"rgb(39,79,76)",
						"rgb(40,161,130)",
						"rgb(206,29,22)",
						"rgb(242,166,54)",
						"rgb(39,79,76)",
						"rgb(40,161,130)",
						"rgb(206,29,22)"
					],
					hoverBackgroundColor: [
						"rgb(242,166,54)",
						"rgb(39,79,76)",
						"rgb(40,161,130)",
						"rgb(206,29,22)",
						"rgb(242,166,54)",
						"rgb(39,79,76)",
						"rgb(40,161,130)",
						"rgb(206,29,22)"
					],
					borderWidth: 1,
					data: datasetsForchart1
				}
			]
		},
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
					right: 25,
					top: 25,
					bottom: 0
				}
			},
			legend: {
				display: false
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
				caretPadding: 10,
				callbacks: {
					label: function(tooltipItem, data) {
						return tooltipItem.yLabel.toFixed(1).replace(/\d(?=(\d{3})+\.)/g, '$&,') + "원";
					}
				}
			}, scales: {
				yAxes: [{
					ticks: {
						beginAtZero: true   // minimum value will be 0.
					}
				}]
			}
		}
	})
}

function getSalChartDataForClass(labelsForchart2, datasetsForchart2) {
	let ctx = $("#salChartForClass");
	var getSalChartDataForClass = new Chart(ctx, {
		type: 'bar',
		data: {
			labels: labelsForchart2,
			datasets: [
				{
					label: "평균 급여",
					backgroundColor: [
						"rgba(242,166,54,.5)",
						"rgba(39,79,76,.5)",
						"rgba(40,161,130,.5)",
						"rgba(206,29,22,.5)",
						"rgba(242,166,54,.5)",
						"rgba(39,79,76,.5)",
						"rgba(40,161,130,.5)",
						"rgba(206,29,22,.5)"
					],
					borderColor: [
						"rgb(242,166,54)",
						"rgb(39,79,76)",
						"rgb(40,161,130)",
						"rgb(206,29,22)",
						"rgb(242,166,54)",
						"rgb(39,79,76)",
						"rgb(40,161,130)",
						"rgb(206,29,22)"
					],
					hoverBackgroundColor: [
						"rgb(242,166,54)",
						"rgb(39,79,76)",
						"rgb(40,161,130)",
						"rgb(206,29,22)",
						"rgb(242,166,54)",
						"rgb(39,79,76)",
						"rgb(40,161,130)",
						"rgb(206,29,22)"
					],
					borderWidth: 1,
					data: datasetsForchart2
				}
			]
		},
		options: {
			scales: {
				yAxes: [{
					ticks: {
						beginAtZero: true   // minimum value will be 0.
					}
				}]
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
			legend: {
				display: false
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
				caretPadding: 10,
				callbacks: {
					label: function(tooltipItem, data) {
						return tooltipItem.yLabel.toFixed(1).replace(/\d(?=(\d{3})+\.)/g, '$&,') + "원";
					}
				}
			}
		}
	})
}

