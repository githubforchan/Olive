/*
	파일명: openweatherAPIuse.js
	설명: opeaweathermap.org 날씨API 가공하여 처리하는 스크립트
	작성일: 2020-12-27
	작성자: 백희승
*/

jQuery(document).ready(function($) {
	const preloader = document.querySelector('.preloader');
	
	const fadeEffect = setInterval(function() {
		
		if (!preloader.style.opacity) {
			preloader.style.opacity = 1;
		}
		
		if (preloader.style.opacity > 0) {
			preloader.style.opacity -= 0.05;
		} else {
			clearInterval(fadeEffect);
		}
		
	}, 40);
	
	const cityName = "Seoul";
	const cityId = "1835848";	// 서울 코드
	const myAPIKey = $('#weatherkey').val();	// API Key
	let weatherURL, lat, long;	// API 요청주소, 위도, 경도
	
	
	// Geolocation API 비동기 요청으로 현재 위치를 대략적인 위도,경도로 가져오기	
	const getPosition = function(){
		return new Promise( (resolve, reject) => {
			if (navigator.geolocation) {
				navigator.geolocation.getCurrentPosition(resolve, reject);
			}
		});
	}
	
	// 가져온 위도, 경도로 API 요청 주소 만들기
	function makeURL(position){
		fadeEffect;
		lat = position.coords.latitude;
		long = position.coords.longitude;
		weatherURL = "http://api.openweathermap.org/data/2.5/weather?lat=" + lat + "&lon=" + long + "&appid="+ myAPIKey + "&units=metric";
		return weatherURL;
	}
	
	// 만들어진 API 요청주소로 날씨 JSON 요청
	function getData(_targetURL){
		return new Promise( (resolve, reject) => {
			$.ajax({
				url : _targetURL, 
				type : "GET",
				dataType : "json",
				success : (data) => {	// 수신 성공 시 resolve
					resolve(data);
				},
				error : (xhr) => {		// 수신 실패 시 reject + throw Error
					console.log("STATUS CODE : " + xhr.status + " ERROR");
					reject(new Error("Weather API Request is failed"));
				}
			});
		});
	}
	
	// 날씨에 따라 코드가 있는데, 코드에 따라 아이콘 재보관
	function makeItMove(id){ 
		let iconName = "";
		if(id >= 800){
			switch(id) {
			case 801:
			case 802:
				iconName = "PARTLY_CLOUDY_DAY";
				break;
			case 803:
			case 804:
				iconName = "CLOUDY";
				break;
			default:
				iconName = "CLEAR_DAY";
			}
		}else{
			let division = String(id).substring(0, 1);
			switch(division){
			case "2":
				iconName = "WIND";
				break;
			case "3":
			case "6":
				iconName = "SNOW";
				break;
			case "5":
				iconName = "RAIN";
				break;
			default:
				iconName = "FOG";
			}
		}
		return iconName;
	}
	
	// 받아온 JSON 가공
	function processUI(data){
		let {id, description} = data.weather[0];
		let {temp, feels_like} = data.main;
		//let speed = data.wind.speed;
		let country = data.sys.country;
		let city = data.name;
		
		let skycon = new Skycons({color:"black"});
		
		let UI  = '<div class="today-weather card-opacity">'
				+ '<div class="weather-title">'
				+ "<h6>" + city + ", " + country + "</h6>"
				+ '</div>'
				+ '<div class="weather-content">'
				+ '<canvas id="weather-icon" class="weather-icon" witdh="80" height="80" ></canvas>'
				+ '<p class="weather-comment mb-0">' + description + '</p>'
				+ '</div>'
				+ '<div class="weather-description">'
				+ '<div class="weather-item">'
				+ '<p class="temp-desc">오늘의 온도<br><span class="temp">' + temp.toFixed(1) + '</span>°C</p>'
				+ '</div>'
				+ '<div class="weather-item">'
				+ '<p class="temp-desc">체감 온도<br><span class="temp">' + feels_like.toFixed(1) + '</span>°C</p>'
				+ '</div></div></div>';
		
		$(".weather-here").append(UI);
		
		skycon.set(document.querySelector("#weather-icon"), Skycons[makeItMove(id)]);
		skycon.play();
		
		$('div.card-opacity').ready( function() {
			let wd = document.querySelector('.card-opacity');
			
			let count = 0;
			const fadeInWeather = setInterval( () => {
				wd.style.opacity = count;
				count += 0.05;
				if(wd.style.opacity >= 1){
					clearInterval(fadeInWeather);
				}
			}, 40);
			
			fadeInWeather;
		});
	}

	// 실행 부분
	getPosition()
	.then( (position) => {
		return position;
	})
	.then( makeURL )
	.then( getData )
	.catch( () => {
		console.log("실패 시 UI에 재요청하는 버튼 만들기");
	})
	.then( processUI );
	
	
	
	
});	// 함수 종료

