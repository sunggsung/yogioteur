<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<jsp:include page="../layout/header.jsp"></jsp:include>
	
	예약번호
	
	이름 <input type="text" name="name" id="name" value="${loginMember.memberName}" readonly><br>
	연락처 <input type="text" name="tel" id="tel" value="${loginMember.memberPhone}" readonly><br>
	
	요금 상세 정보
	
	옵션 금액
	부가 금액
	총 금액	
		
	<jsp:include page="../layout/footer.jsp"></jsp:include>
	
</body>
</html>