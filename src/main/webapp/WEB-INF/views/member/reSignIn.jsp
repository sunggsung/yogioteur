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
	fnReSignIn();
})

function fnReSignIn(){
	$('#resignForm').on('submit', function(e){
		// 비밀번호 정규식 검사
		if(regPw .test($('#memberPw').val()) == false){
			alert('8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.');
			e.preventDefault();
			return false;
		}
		
		// 비밀번호 입력 확인
		else if($('#memberPwConfirm').val() != '' && $('#memberPw').val() != $('#memberPwConfirm').val() ){	
			alert('비밀번호를 확인하세요.');
			e.preventDefault();
			return false;
		} 
		return true;
	})
}

</script>
</head>
<body>

	<jsp:include page="../layout/header.jsp"></jsp:include>

	<h3>다시 찾아 주셔서 감사합니다.</h3>
	
	<div>
		사이트를 이용하기 위해 아래 양식을 작성해주세요.
	</div>
	
	<form id="resignForm" action="${contextPath}/member/reSignIn" method="post">
	
		가입 아이디<br>
		${member.id}<br>
		
		신규 비밀번호<br>
		<input type="password" name="memberPw" id="memberPw"><br>
		
		비밀번호 확인<br>
		<input type="password" id="memberPwConfirm"><br>
		
		가입자명<br>
		<input type="text" name="memberName" value="${member.name}"><br>
		
		이메일<br>
		${member.email.substring(0,3)}***${member.email.substring(member.email.indexOf('@'))}<br>
		
		가입일<br>
		${member.signIn}<br>
		
		탈퇴일<br>
		${member.signOut}<br>
		
		<input type="hidden" name="memberNo" value="${member.memberNo}">
		<input type="hidden" name="memberId" value="${member.id}">
		<input type="hidden" name="memberEmail" value="${member.email}">
		<input type="hidden" name="agreeState" value="${member.agreeState}">		
		<input type="hidden" name="memberPhone" value="${member.memberPhone}">		
		<input type="hidden" name="memberBirth" value="${member.memberBirth}">		
		<br>
		<button>사이트 다시 이용하기</button>
		
	</form>
	
		<jsp:include page="../layout/footer.jsp"></jsp:include>
	
</body>
</html>