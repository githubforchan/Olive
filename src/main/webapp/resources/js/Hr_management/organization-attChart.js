//근태현황 검색 - 자동완성
$('#searchBar').autocomplete({
	source: function(request, response) {
		$.ajax({
			url: "/HR_managementRest/searchEmp.do",
			data: {
				ename: $("#searchBar").val()
			},
			type: 'POST',
			success: function(data) {
				console.log(data),
					response(
						$.map(data, function(item) {
							return {
								label: item.ename + " " + item.classname+" / "+item.deptname,
								value: item.empno
							}
						})
					)
			}
		})
	},
	focus: function(event, ui) {	//포커스 가면
		return false;//한글 에러 잡기용도로 사용됨
	}
})

// 근태현황 도넛차트
$("#searchBtn5").click(function() {
	
	// 입맛에 맞게
	$.ajax({
		url: "/HR_managementRest/getAttbyEmpno.do",
		data: {
			empno: $(".ui-autocomplete-input").val()
		},
		type: 'POST',
		success: function(data) {
			var datasetsForchart = new Array;
			var labelsForchart = new Array;
			$.map(data.attrecord, function(item) {
				labelsForchart.push(item.attname)
				datasetsForchart.push(parseInt(item.num))
			chart5(datasetsForchart, labelsForchart);
			var empData = data.empinfo.ENAME+" "+data.empinfo.CLASSNAME +"/" +data.empinfo.DEPTNAME;
			$('#emp').html(empData);
			})
		}
	})
})
var ctx2 = $("#attChart");
function chart5(datasetsForchart, labelsForchart) {
	var chart2 = new Chart(ctx2, {
		type: 'doughnut',
		data: {
			labels: labelsForchart,
			datasets: [{
				data: datasetsForchart,
				backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc'],
				hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf'],
				hoverBorderColor: "rgba(234, 236, 244, 1)"
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
				display: false
			},
			cutoutPercentage: 80
		}
	})
}