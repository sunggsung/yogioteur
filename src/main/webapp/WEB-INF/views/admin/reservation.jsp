<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../resources/js/jquery-3.6.0.js"></script>
<script>

	$(function(){
		
	})
	
</script>
<link rel="stylesheet" href="../resources/css/admin.css">
</head>
<body>
	
	<div class="container">
		<jsp:include page="index.jsp"></jsp:include>
		
		<div class="grid_item reservation">
			<h3>예약 목록</h3>
			<table class="table">
				<thead>
					<tr>
						<td>순번</td>
						<td>객실번호</td>
						<td>체크인날짜</td>
						<td>체크아웃날짜</td>
						<td>인원수</td>
					</tr>
				</thead>
				<tbody id="reservations">
					<c:forEach var="reservation" items="${reservations}">
						<tr>
							<td>${reservation.reserNo}</td>
							<td>${reservation.roomNo}</td>
							<td>${reservation.reserCheckin}</td>
							<td>${reservation.reserCheckout}</td>
							<td>${reservation.reserPeople}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
	</div>

</body>
</html>