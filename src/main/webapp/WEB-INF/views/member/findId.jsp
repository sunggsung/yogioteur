<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.findIdArea > a {
		color : black;
	}
</style>
<script src="../resources/js/jquery-3.6.0.js"></script>
<script>
	
	$(function(){
		fnFindId();
	})
	
	function fnFindId(){
		$('#findIdForm').on('submit', function(e){
			if($('#memberName').val() == '' || $('#memberEmail').val() == ''){
				alert('이름과 이메일을 입력해주세요.');
				e.preventDefault();
				return;
			}
			let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+(\.[a-zA-Z]{2,}){1,2}$/;  
			if(regEmail.test($('#memberEmail').val())==false){
				alert('잘못된 형식의 이메일입니다.');
				$('#memberEmail').focus();
				return false;
			}
		})
	}
</script>
<style>
	form > a {
		text-decoration: none;
		color: gray;	
		font-size: 30px;
	}
	.button_box > a {
		color : #333;
		text-decoration: none;
	}
    * {
    	padding: 0;
    	margin: 0;
    }
    .join {
    	width: 390px;
    	margin: 110px auto;
    	padding: 60px 50px 51px;
    	border: 1px solid #dadada;
    }
    .title {
       	width: 100%;
       	height: 40px;
       	margin: 0 auto 30px;
       	text-align: center;
    }
    .content {
    	margin: 10px 0;
    }
    .find_box {
        display: block;
        height: 48px;
        margin-bottom: 6px;
        border: 1px solid #d7d7d7;
        position: relative;
    }
	.find_box > input {
         width: 350px;
         height: 17px;
         padding: 16px 19px 15px;
         font-size: 14px;
         font-weight: bold;
         color: #333;
         outline: none;
         border: none;
         position: absolute;
        }
     .btn_findId {
         display: block;
         height: 50px;
         width: 390px;
         background-color: black;
         font-size: 14px;
         font-weight: bold;
         color: #fff;
         letter-spacing: -0.5px;
         text-align: center;
         line-height: 51px;	
     }
	.button_box {
         margin-top: 30px;
         text-align: center;
         border-top: 1px solid #f2f2f5;
         font-size: 14px;
     }
     .button_box > a {
         display: inline-block;
         padding: 19px 18px 0;
         color: #333;
     }
</style>
</head>
<body>
	
	<jsp:include page="../layout/header.jsp"></jsp:include>
	
	<div class="join" >
		<form id="findIdForm" action="${contextPath}/member/findId" method="post">
		<h3 class="title">아이디 찾기</h3>
			<div class="content">
				<div class="find_box">
					<input type="text" name="memberName" id="memberName" placeholder="이름"><br>
				</div>
				<div class="find_box">
					<input type="text" name="memberEmail" id="memberEmail" placeholder="이메일"><br>
				</div>
			</div>
				<button class="btn_findId">확인</button> 
		</form>
		<div class="button_box">
			<a href="${contextPath}/member/findPwPage">비밀번호 찾기</a> |
			<a href="${contextPath}/member/agreePage">회원가입</a>
		</div>
	</div>
	
	<jsp:include page="../layout/footer.jsp"></jsp:include>
	

</body>
</html>