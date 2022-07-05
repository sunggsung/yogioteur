<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<link href="https://fonts.googleapis.com/css2?family=Charis+SIL:wght@700&family=Kdam+Thmor+Pro&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${contextPath}/resources/css/footer.css">
<link rel="stylesheet" href="${contextPath}/resources/css/header.css">
<script src="https://kit.fontawesome.com/148c1051b1.js" crossorigin="anonymous"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../resources/js/jquery-3.6.0.js"></script>
<style>
	
		
	.roomNo{
		color: black;
		padding: 20px;
		
	}
	
	table{
		
		width: 1200px;
		margin: auto;
	}
	
	.rommNo{
		
		text-align: center;
		
	}
	
	input{
	  margin: 63px;
	  outline: none;
	}
	
	.btn-16 {
	  background: #000;
	  color: #fff;
	  z-index: 1;
	}
	.btn-16:after {
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
	.btn-16:hover:after {
	  top: 0;
	  height: 100%;
	}
	.btn-16:active {
	  top: 2px;
	}

</style>
<script type="text/javascript">

/* var openWin;

function openChild(var roomNo)
{
    // window.name = "부모창 이름"; 
    window.name = "parentForm";
    // window.open("open할 window", "자식창 이름", "팝업창 옵션");
    openWin = window.open("${contextPath}/room/detail?roomNo="+roomNo,
            "childForm", "width=570, height=350, resizable = no, scrollbars = no");    
} */
	
	document.oncontextmenu = function(){return false;}
	
	function goPost() {
		let f = document.createElement('form');
		const chkIn = document.getElementById('chkIn');
		const chkOut = document.getElementById('chkOut');
		const roomNo = document.getElementById('roomNo');
		const roomName = document.getElementById('roomName');
		const roomPrice = document.getElementById('roomPr');
		
		f.appendChild(chkIn);
		f.appendChild(chkOut);		
		f.appendChild(roomNo);		
		f.appendChild(roomName);		
		f.appendChild(roomPrice);		
		
		f.setAttribute('method', 'post');
		f.setAttribute('action', '${contextPath}/reservation/reservationPage');
		document.body.appendChild(f);
		f.submit();
	}
</script>
</head>
		<jsp:include page="../layout/header.jsp"></jsp:include>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
	<table>
			
		<tbody>
			
			<c:forEach items="${roomList}" var="room">
					<tr>
						<td>
						   <input type="hidden" id="roomNo" name="roomNo" value="${room.roomNo}">
						   <a href="${contextPath}/room/detail?roomNo=${room.roomNo}" class="roomNo"><img src="${contextPath}/room/view?roomNo=${room.roomNo}" width="300px"></a>
						   <input type="hidden" id="roomName" name="roomName" value="${room.roomName}">
						   <a href="${contextPath}/room/detail?roomNo=${room.roomNo}" class="roomNo">${room.roomName}</a>
						</td>	
						<td>
						   <input type="hidden" id="roomPr" name="roomPr" value="${room.roomPrice}">
						   <input type="hidden" id="chkIn" name="chkIn" value="${room.roomCheckIn}">
						   <input type="hidden" id="chkOut" name="chkOut" value="${room.roomCheckOut}">	
						   <input type="button" class="custom-btn btn-16" value="${room.roomPrice}KRW" onclick="goPost()">
						</td>
					</tr>
			</c:forEach>
			
		</tbody>
		
	</table>
	
</body>
		<jsp:include page="../layout/footer.jsp"></jsp:include>
</html>
