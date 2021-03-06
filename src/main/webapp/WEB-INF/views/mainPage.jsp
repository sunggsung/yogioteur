<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css2?family=Charis+SIL:wght@700&family=Kdam+Thmor+Pro&display=swap" rel="stylesheet">
<link rel="stylesheet" href="resources/css/footer.css">
<link rel="stylesheet" href="resources/css/header.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<script src="https://kit.fontawesome.com/148c1051b1.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>

<style type="text/css">
	
	body{
		margin: 0;
		font-family: 'Kdam Thmor Pro', sans-serif;
	}
	
	a{
		text-decoration: none;
		color: white;
	}
	
	form{
		
		background: silver;
		
	
	}
	
	.background{
		
		height: 850px;
	
	}
	.searchBar{
		display: flex;
		align-items: center;
		background-color: silver;
	    height: 80px;
		font-size: 25px;
		padding-left: 300px;
		color: white;
		
	}
	
	button {
	  margin: 5px;
	  outline: none;
	}
	.custom-btn {
	  width: 122px;
	  height: 45px;
	  padding: 8px 20px;
	  border: 2px solid #000;
	  font-family: 'Lato', sans-serif;
	  font-weight: 500;
	  font-size: 18px;
	  background: transparent;
	  cursor: pointer;
	  transition: all 0.3s ease;
	  position: relative;
	  display: inline-block;
	}
	
	/* 13 */
	.btn-13 {
	  background: #000;
	  color: #fff;
	  z-index: 1;
	}
	.btn-13:after {
	  position: absolute;
	  content: "";
	  width: 100%;
	  height: 0;
	  bottom: 0;
	  left: 0;
	  z-index: -1;
	  background: #fff;
	  transition: all 0.3s ease;
	}
	.btn-13:hover {
	  color: #000;
	}
	.btn-13:hover:after {
	  top: 0;
	  height: 100%;
	}
	.btn-13:active {
	  top: 2px;
	}
	.btn-14 {
	  background: #000;
	  color: #fff;
	  z-index: 1;
	}
	.btn-14:after {
	  position: absolute;
	  content: "";
	  width: 100%;
	  height: 0;
	  bottom: 0;
	  left: 0;
	  z-index: -1;
	  background: #fff;
	  transition: all 0.3s ease;
	}
	.btn-14:hover {
	  color: #000;
	}
	.btn-14:hover:after {
	  top: 0;
	  height: 100%;
	}
	.btn-14:active {
	  top: 2px;;
	}
	
	.weather_api{
		
		display: flex;
		width: 1300px;
		height: 500px;
		
	}
	
	.image {
		
	}
</style>
</head>
<script type="text/javascript">
	
	//????????? ?????? ?????????
	
	$(function(){
		
		
		 $("#roomCheckIn").datepicker({
			 dateFormat: 'yy/mm/dd'
		    });
		    
		 $("#roomCheckOut").datepicker({
			 dateFormat: 'yy/mm/dd'
		    });
		 
		 fnDate();
		 
		//?????? ????????? ?????????
		$('#f').on('submit', (ev)=>{
			
			if($('#roomCheckIn').val() == '' || $('#roomCheckOut').val() == ''){
				alert('????????? ??????????????????.');
				ev.preventDefault();
		}
			
		})
		
		fnTour();

	})
	
  //??????
  
   function fnDate(){
		
		 $('#roomCheckIn').datepicker('option', 'minDate','0');//???????????? ????????????
		 $('#roomCheckOut').datepicker('option', 'minDate','+1');//??????????????? ???????????? ???????????? ???????????? ????????????
		
	} 
	
	function fnTour(){
		$.ajax({
			url: '${contextPath}/admin/tour',
			type: 'get',
			dataType: 'json',
			success: function(responseText){
				//var items = responseText.response.body.items.item;
				$('#items').empty();
				$.each(responseText, function(i, item){
					var tr = '<tr>';
					tr += '<td>' + item.tm + '</td>';
					tr += '<td>' + item.spotName + '</td>';
					var sky;
					switch(item.sky){
					case 1: sky = '??????'; break;
					case 2: sky = '????????????'; break;
					case 3: sky = '????????????'; break;
					case 4: sky = '??????'; break;
					case 5: sky = '???'; break;
					case 6: sky = '??????'; break;
					case 7: sky = '??????'; break;
					case 8: sky = '???'; break;
					default: sky = '??????';
					}
					tr += '<td>' + sky + '</td>';
					tr += '<td>' + item.th3 + '</td>';
					tr += '<td>' + item.rhm + '%</td>';
					tr += '<td>' + item.pop + '%</td>';
					$('#items').append(tr);
				})
			}
		})
	}
  
  
</script>
<body>

	<jsp:include page="layout/header.jsp"></jsp:include>
	
	<div class="background">
		<img src="resources/image/hotel.jpg" alt="main" width="100%" height="850px">
	</div>
	
	<div class="center">
		
		<form id="f" action="${contextPath}/room/roomList" method="post">
		
		<div class="searchBar">
			
			<div id="checkInOut" style= "padding-left: 200px;">
			CHECK IN/OUT
			<input type="text" id="roomCheckIn" name="roomCheckIn" style="padding-top: 8px;" autocomplete="off">
			~
			<input type="text" id="roomCheckOut" name="roomCheckOut" style="padding-top: 8px;" autocomplete="off">
			</div>	
			&nbsp;&nbsp;	
			<button class="custom-btn btn-13" >??????</button>
			<button class="custom-btn btn-14" type="reset">?????????</button>
		</div>
		
		</form>
		
	</div>
	
	<div class="weather_api">
		<div class="image">
			<img src="resources/image/mainPageImage1.jpg" alt="image1" width="90%" height="300px">
		</div>
		<div class="image">
			<img src="resources/image/mainPageImage2.jpg" alt="image2" width="90%" height="300px">
		</div>
		<div>
			<img src="resources/image/mainPageImage3.jpg" alt="image3" width="90%" height="300px">
			<!-- <table border="1">
				<thead>
					<tr>
						<td>????????????</td>
						<td>????????????</td>
						<td>??????</td>
						<td>??????</td>
						<td>??????</td>
						<td>????????????</td>
					</tr>
				</thead>
				<tbody id="items"></tbody>
			</table> -->
		</div>
	</div>

	<div class="footer">
			<div class="end_title">
				YOGIOTEUR
				<hr>
					<div class="info">
						(???)???????????????
						????????????????????? ???????????? ???????????? 2074 63616
								<nav>
									<ul>
										<li><a href="https://www.facebook.com/"><i class="fa-brands fa-facebook-square"></i></a></li>
										<li><a href="https://twitter.com/"><i class="fa-brands fa-twitter-square"></i></a></li>
										<li><a href="https://www.instagram.com/"><i class="fa-brands fa-instagram"></i></a></li>
									</ul>
								
								</nav>
					</div>
			</div>
		</div>

</body>
</html>