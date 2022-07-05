<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 화면 해상도에 따라 글자 크기 대응(모바일 대응) -->
<!-- <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"> -->
<!-- jquery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js" integrity="sha256-6XMVI0zB8cRzfZjqKcD01PBsAy3FlDASrlC8SxCpInY=" crossorigin="anonymous"></script>
<!-- fullcalendar CDN -->
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<!-- fullcalendar 언어 CDN -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
<style>

  /* body 스타일 */
/*   html, body {
    overflow: hidden;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  } */
	/* 캘린더 위의 해더 스타일(날짜가 있는 부분) */
	.fc-header-toolbar {
	  padding-top: 1em;
	  padding-left: 1em;
	  padding-right: 1em;
	}
	.container {
	display: flex;
	margin-top: 50px;
	margin-left: 10%;
	margin-right: 10%;
	}
	
	.grid_item {
		text-align: center;
		width: 80%;
	}
	
	.table {
		display: inline-block;
	}
	
	.grid_item.index {
		text-align: center;
		width: 20%;
		background-color: silver;
	}
  
</style>
<script>

	var diaLogOpt = {
		modal:true        //모달대화상자
		,resizable:false  //크기 조절 못하게
		, width : "570px"   // dialog 넓이 지정
		, height : "470px"  // dialog 높이 지정
	};
	
	// 페이지 로드 이벤트
	$(function(){
		// calendar element 취득
		var calendarEl = $('#calendar')[0];
		// full-calendar 생성하기
		var calendar = new FullCalendar.Calendar(calendarEl, {
			height: '600px', // calendar 높이 설정
			//expandRows: true, // 화면에 맞게 높이 재설정
			// 해더에 표시할 툴바
			headerToolbar: {
				left: 'prev,next today',
				center: 'title',
				right: 'dayGridMonth listWeek'
			},
			initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
			//initialDate: '2022-06-29', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
			navLinks: false, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
			editable: true, // 수정 가능?
			selectable: true, // 달력 일자 드래그 설정가능
			nowIndicator: true, // 현재 시간 마크
			dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
			locale: 'ko', // 한국어 설정
			//timeZone: 'Asia/Seoul',
			eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
			  console.log(obj);
			},
			eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
			  console.log(obj);
			},
			eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
			  console.log(obj);
			},
			
			/* select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
				var title = prompt('Event Title:');
				if (title) {
					calendar.addEvent({
						title: title,
						start: arg.start,
						end: arg.end,
						allDay: arg.allDay
					})
				}
				calendar.unselect()
			}, */
			// DB에 저장된 예약 정보들을 조회후 달력에 표시
			events: function(info, successCallback, failureCallback) {
				$.ajax({
					url: '${contextPath}/admin/reserList',
					type: 'GET',
					dataType: 'json',
					success: function(obj) {
						console.log(obj.reservations)
						let arr = [];
						$.each(obj.reservations, function(i, reservation) {
							arr.push({
								title: reservation.roomNo + '번 객실'
								, start: reservation.reserCheckin
								, end : reservation.reserCheckout + (1000 * 60 * 60 * 24) // 체크아웃날짜까지 포함시켜서 표시
								, extendedProps : {
									reserNo: reservation.reserNo
									, reserStatus: reservation.reserStatus
									, reserPeople: reservation.reserPeople
									, reserFood: reservation.reserFood
								},
								allDay : true
							})
						})
						successCallback(arr);
					}
				})
			},  //events
			eventClick: function(info) {
				//alert(info.event.extendedProps.reserNo)
				//open('${contextPath}/admin/reserDetailPage', '', 'width=640, height=480, top=' + popupY + ', left=' + popupX);
				$('#reserNo').val(info.event.extendedProps.reserNo);
	            openChild(info.event.extendedProps.reserNo);
			        
			}
			
		}); //new FullCalendar.Calendar
		
		// 캘린더 랜더링
		calendar.render();
	
	}); //페이지로드이벤트
	
     let childWindow;
     const popupX = (window.screen.width / 2) - 640/2;
	 const popupY = (window.screen.height / 2) - 480/2;
     function openChild(reserNo){
         childWindow = open('${contextPath}/admin/reserDetail?reserNo=' + reserNo
        		 , '', 'width=640, height=480, top=' + popupY + ', left=' + popupX);
     }
     function sendData(){
         childWindow.onload = function(ev){
        	 childWindow.$('#receive_msg').text($('#reserNo').val());
         }
     }
	
</script>
</head>

<body style="padding:30px;">
	
	<!-- calendar 태그 -->
	<div id="calendar-container" class="container">
		<jsp:include page="index.jsp"></jsp:include>
		<div id="calendar" class="grid_item"></div>
	</div>
	
	<h1 id="receive_msg"></h1>
    <form>
        <input type="hidden" id="reserNo" value="">
    </form>
	
</body>
</html>