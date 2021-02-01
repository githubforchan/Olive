/* 
	파일명: NewsAPI.js
	설명: news script 스크립트
	작성일: 2020-12-30
	작성자: 정민찬
 */
 	
 	
	function getNewsData() {
		$.ajax({
			url: "getNewsData.do",
			contentType: "application/json;charset:UTF-8",
			success: function(data) {
				
				news(data);
			},
			error: function(err) {
				console.log(err.status);
			}
		});
	}
	
	
	function news(data){	
		let arr = [];
		for(var i=0; i<(data.items.length/2); i++){
			arr[i] = "<a href='"
					+data.items[i*2].link
					+"'>"
					+data.items[i*2].title
					+"</a>"
					+data.items[i*2].pubDate.substr(0,16)
					+"<br> &nbsp;"
					+data.items[i*2].description
					+"<br>"
					+"<br><a href='"
					+data.items[i*2+1].link
					+"'>"
					+data.items[i*2+1].title
					+"</a> &nbsp;"
					+data.items[i*2+1].pubDate.substr(0,16)
					+"<br>"
					+data.items[i*2+1].description
					+"<br><br>"
			console.log(arr[i]);		
		}
		$("#news1").html(arr[0]);
		$("#news2").html(arr[1]);
		$("#news3").html(arr[2]);
		$("#news4").html(arr[3]);
		$("#news5").html(arr[4]);
		
	}
	getNewsData();
	
	
	// Activate Carousel
  $("#myCarousel").carousel({interval:2000});
    