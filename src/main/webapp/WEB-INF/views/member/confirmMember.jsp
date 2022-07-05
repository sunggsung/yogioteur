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
//비밀번호 정규식
$(function(){
		fnPwCheck();
		fnConfirm();
	})
	$('#confirmPwForm').on('submit', function(e){
		if($('#memberId').val() == ''){
			alert('아이디를 입력하세요.');
			e.preventDefault();
			return false;
		}
		if($('#memberPw').val() == ''){
			alert('비밀번호를 입력하세요.');
			e.preventDefault();
			return false;
		}
	})
	
	
	
</script>
<style>
	.dont {
		color: red;
	}
	.ok {
		color: blue;
	}
</style>
</head>
<body>
		
	<jsp:include page="../layout/header.jsp"></jsp:include>
		
		<form id="confirmPwForm" action="${contextPath}/member/signOut">
		<h3>회원 인증</h3>
		<p>
		<strong>정보를 안전하게 보호하기 위해 비밀번호를 다시 한 번 확인합니다.</strong>
		비밀번호가 타인에게 노출되지 않도록 항상 주의해주세요.
		</p>
			아이디 : ${loginMember.memberId}
			비밀번호 : <input type="password" name="memberPw" id="memberPw"><br>
			<input type="hidden" name="memberId" value="${loginMember.memberId}">
			<button>확인</button>
			<input type="button" value="취소" onclick="location.href='${contextPath}/'">
		</form>

</body>
</html>