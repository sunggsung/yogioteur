<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
</script>
</head>
<body>
	
	
	<h1>비회원 로그인</h1>
	<form action="${contextPath}/nonMember/nonMemberLogin" method="post">
		이름 <input type="text" name="nonName" id="nonName" placeholder="이름을 입력해주세요"><br>
		휴대폰 번호 <input type="tel" name="nonPhone" placeholder="휴대폰 번호(- 생략)를 입력해주세요" maxlength="11"><br>
		<button>로그인</button>
	</form>
	
	
</body>
</html>