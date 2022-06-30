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
</head>
<body>
		
	<jsp:include page="../layout/header.jsp"></jsp:include>
			
		<div class="container">
       <h3>예약 확인</h3>
			<table class="reser" border="1">
				<thead>
					<tr>
						<td>예약번호</td>
						<td>객실이름</td>
						<td>회원이름</td>
						<td>체크인날짜</td>
						<td>체크아웃날짜</td>
						<td>예약인원</td>
						<td>예약상태</td>
					</tr>
				</thead>
				<tbody id="confirmReser">
						<tr>
							<td>${reservation.reserNo}</td>
							<td>${reservation.roomNo}</td>
							<td>${loginMember.memberName}</td>
							<td>${reservation.reserCheckin}</td>
							<td>${reservation.reserCheckout}</td>
							<td>${reservation.reserPeople}</td>
							<td>예약상태</td>
						</tr>
				</tbody>
			</table>
    </div>


</body>
</html>