<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<link href="https://fonts.googleapis.com/css2?family=Charis+SIL:wght@700&family=Kdam+Thmor+Pro&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${contextPath}/resources/css/footer.css">
<link rel="stylesheet" href="${contextPath}/resources/css/header.css">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../resources/js/jquery-3.6.0.js"></script>
</head>
<style>
	
	.detailSize{
		
		margin: auto;
		width: 1200px;
	
	}
	
	img{
		
		margin: auto;
		
	}
	
	dl, dd, dt{
		display: inline-block;
		margin: 0;
		padding: 0;
		
	}
	
	dt{
		
		display: block;
		
		
	}
	
	
/* 	dt { 
	
	float: left;
	font-weight: bold;
	
	 } */
	
	.btn-15 {
	  background: #000;
	  color: #fff;
	  z-index: 1;
	}
	.btn-15:after {
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
	.btn-15:hover {
	  color: #000;
	}
	.btn-15:hover:after {
	  top: 0;
	  height: 100%;
	}
	.btn-15:active {
	  top: 2px;
	}

</style>
<script>
	document.oncontextmenu = function(){return false;}
</script>
		<jsp:include page="../layout/header.jsp"></jsp:include>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
	<div class="detailSize">
	
	 <button class="custom-btn btn-15" onclick="history.back()">뒤로가기</button>
		<c:choose>
			<c:when test="${rn.rtNo eq 1}">
				<div>
				<img src="${contextPath}/room/view?roomNo=${rn.roomNo}" width="500px;">
				<h2>${rn.roomName}</h2>
				<span>현대적 세련미와 은은한 불빛이 조화롭게 어우러진 객실로, 비즈니스 여행객과 레저 여행객 모두에게 아늑한 숙박을 제공 합니다.</span>
				<br><br>
				<span>※상기 객실 이미지는 실제 제공되는 객실과 다를 수 있습니다.</span><br>
				<hr>
				<dl>
				<dt >객실타입 :</dt> <dd>${rn.roomTypeDTO.rtType}</dd> 
				<dt>객실 정원수 :</dt> <dd>${rn.roomTypeDTO.rtMax}</dd> 
				<dt>객실 면적 :</dt> <dd>22.8 ㎡</dd> 
				</dl>
				</div>
			</c:when>
			<c:when test="${rn.rtNo eq 2}">
				<div>
				<img src="${contextPath}/room/view?roomNo=${rn.roomNo}" width="500px;">
				<h2>${rn.roomName}</h2>
				<span>현대적 세련미와 은은한 불빛이 조화롭게 어우러진 객실로, 비즈니스 여행객과 레저 여행객 모두에게 아늑한 숙박을 제공 합니다.</span>
				<br><hr>
				<span>※상기 객실 이미지는 실제 제공되는 객실과 다를 수 있습니다.</span><br>
				<dl>
				<dt>객실타입 :</dt> <dd>${rn.roomTypeDTO.rtType}</dd> 
				<dt>객실 정원수 :</dt> <dd>${rn.roomTypeDTO.rtMax}</dd> 
				<dt>객실 면적 :</dt> <dd>30.2 ㎡</dd> 
				</dl>
				</div>
			</c:when>
			<c:when test="${rn.rtNo eq 3}">
				<div>
				<img src="${contextPath}/room/view?roomNo=${rn.roomNo}" width="500px;">
				<h2>${rn.roomName}</h2>
				<span>현대적 세련미와 은은한 불빛이 조화롭게 어우러진 객실로, 비즈니스 여행객과 레저 여행객 모두에게 아늑한 숙박을 제공 합니다.</span>
				<br><hr>
				<span>※상기 객실 이미지는 실제 제공되는 객실과 다를 수 있습니다.</span><br>
				<dl>
				<dt>객실타입 :</dt> <dd>${rn.roomTypeDTO.rtType}</dd> 
				<dt>객실 정원수 :</dt> <dd>${rn.roomTypeDTO.rtMax}</dd> 
				<dt>객실 면적 :</dt> <dd>33.5 ㎡</dd> 
				</dl>
				</div>
			</c:when>
		</c:choose>
		<div class= "rInfo">
			<h3>info</h3>
				<div>
				<dl>
					<dt>라운지</dt>
				<dd><img src="../resources/image/rounge.jpg" width="350px" height="300px"></dd>
				</dl>
				<dl>
				<dt>피트니스센터</dt>
					<dd><img src="../resources/image/gym.jpg" width="350px" height="300px"></dd>
				</dl>				
				</div>
				<div>
				
				<dl>
					<dt>레스토랑</dt>
						<dd><img src="../resources/image/restaurant.jpg" width="350px" height="300px"></dd>
				</dl>
				<dl>
					<dt>야외 수영장</dt>
						<dd><img src="../resources/image/pool.jpg" width="350px" height="300px"></dd>
				</dl>
				 	
				</div>
		</div>
	</div>
</body>
		<jsp:include page="../layout/footer.jsp"></jsp:include>

</html>