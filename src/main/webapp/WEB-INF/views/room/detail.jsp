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
<script>
	
</script>
<body>
	<h1>상세보기</h1>
		
		<c:choose>
			<c:when test="${rn.rtNo eq 1}">
				<div>
				${rn.roomName}
				</div>
			</c:when>
			<c:when test="${rn.rtNo eq 2}">
				<div>
				${rn.roomName}
				</div>
			</c:when>
			<c:when test="${rn.rtNo eq 3}">
				<div>
				${rn.roomName}
				</div>
			</c:when>
		</c:choose>
	
	
</body>
</html>