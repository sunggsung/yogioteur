<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/admin.css">
</head>
<body>
	<div class="container">
		<div class="grid_item index">
			<h3>관리자 메뉴</h3>
			<a href="${contextPath}/admin/member">회원목록</a>
			<br><br><br><br><br>
			<a href="${contextPath}/admin/reservationList">예약목록</a>
			<br><br><br><br><br>
			<a href="${contextPath}/admin/room">객실목록</a><br>
			<a href="${contextPath}/admin/addRoomPage">객실등록</a><br>
			<a href="${contextPath}/admin/tourPage">API 조회</a> 
		</div>
	</div>
	
</body>
</html>