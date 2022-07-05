<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 정보</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>

	$(function() {
		closeWindow();
	})
	
	function closeWindow() {
		$('#close').on('click', function() {
			window.close();
		})
	}
	
</script>
<style type="text/css">
	
</style>
</head>
<body>
	
    <form>
        예약번호: ${reservation.reserNo}<br>
        객실번호: ${room.roomNo}<br>
        체크인: ${reservation.reserCheckin}<br>
        체크아웃: ${reservation.reserCheckout}<br>
        예약자 이름: ${member.memberName}<br>
        예약자 아이디: ${member.memberId}<br>
        예약자 전화번호: ${member.memberPhone}<br>
        <input type="button" id="btnModify" value="수정">
        <input type="button" id="close" value="닫기">
    </form>
	
</body>
</html>