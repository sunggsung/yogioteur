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
		fnPwCheck();
		fnPwConfirm();
		fnEmailAuth();
		fnToUpperCase();
		fnChangePw();
	})
	
	let pwPass = false;
	function fnPwCheck(){
		$('#memberPw').on('keyup', function(){
			let regPw = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,12}$/; 
			if(regPw.test($('#memberPw').val())==false){
				$('#pwMsg').text('영문 소문자, 숫자, 특수문자 포함 8~12자로 입력해주세요.').addClass('dont').removeClass('ok');
				pwPass = false;
			} else {
				$('#pwMsg').text('사용 가능한 비밀번호입니다.').addClass('ok').removeClass('dont');
				pwPass = true;
			}
		})
	}
	
	let rePwPass = false;
	function fnPwConfirm(){
		$('#memberRePw').on('keyup', function(){
			if($('#memberRePw').val() != '' && $('#memberPw').val() != $('#memberRePw').val()){
				$('#rePwMsg').text('비밀번호를 확인하세요.').addClass('dont').removeClass('ok');
				rePwPass = false;
			} else {
				$('#rePwMsg').text('');
				rePwPass = true;
			}
		})
	}
	
	function fnIdEmailCheck(){
		return new Promise(function(resolve, reject){
			let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+(\.[a-zA-Z]{2,}){1,2}$/;
			if(regEmail.test($('#memberEmail').val())==false){
				alert('잘못된 형식의 이메일입니다.');
				return;
			}
			$.ajax({
				url: '${contextPath}/member/idEmailCheck',
				type: 'get',
				data: 'memberId=' + $('#memberId').val() + '&memberEmail=' + $('#memberEmail').val(),
				dataType: 'json',
				success: function(obj){
					if(obj.findMember != null){ 
						resolve();
					} else {
						reject(401);  
					}
				}
			})
		})
	}
	
	function fnEmailAuth(){
		$('#btnGetAuthCode').on('click', function(){
			fnIdEmailCheck()
				.then(function(){
					$.ajax({
						url: '${contextPath}/member/sendAuthCode',
						type: 'get',
						data: 'memberEmail=' + $('#memberEmail').val(),
						dataType: 'json',
						success: function(obj){  
							alert('인증코드를 발송했습니다. 이메일을 확인하세요.');
							fnVerifyAuthCode(obj.authCode);  
						},
						error: function(){
							alert('인증코드 발송이 실패했습니다.');
						}
					})
				}).catch(function(errorCode){
					alert('예외코드[' + errorCode + '] 회원 정보를 찾을 수 없습니다.');
				})
		})
	}
	
	let authCodePass = false;
	function fnVerifyAuthCode(authCode){
		$('#btnVerifyAuthCode').on('click', function(){
			if($('#authCode').val() == authCode){
				alert('인증되었습니다.');
				$('.authArea').css('display', 'none');
				$('.changeArea').css('display', 'block');
				authCodePass = true;
			} else {
				alert('인증에 실패했습니다.');
				authCodePass = false;
			}
		})
	}
	
	function fnToUpperCase(){
		$('#authCode').on('keyup', function(){
			$('#authCode').val($('#authCode').val().toUpperCase());
		})
	}
	
	function fnChangePw(){
		$('#findPwForm').on('submit', function(event){
			if(pwPass == false || rePwPass == false){
				alert('비밀번호를 확인하세요.');
				event.preventDefault();
				return false;
			}
			else if(authCodePass == false){
				alert('이메일 인증을 받아야 합니다.');
				event.preventDefault();
				return false;
			}
			return true;
		})
	}
	
</script>
<style>
	.changeArea {
		display: none;
	}
	.dont {
		color: red;
	}
	.ok {
		color: blue;
	}
	.InputArea {
		display: block;
		position: relative;
		margin: 0;
		width: 100%;
		height: 51px;
		border: solid 1px #dadada;
		padding: 10px 110px 10px 14px;
		box-sizing: border-box;
		vertical-align: top;
	}
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
    	height: 300px;
    	margin: 110px auto;
    	padding: 60px 50px 51px;
    	border: 1px solid #dadada;
    }
    .title {
       	width: 100%;
       	height: 30px;
       	margin: 0 auto 20px;
       	text-align: center;
    }
    .content {
    	margin: 10px 0;
    }
     .InputArea {
		display: block;
		position: relative;
		margin: 20px 0;
		width: 100%;
		height: 51px;
		border: solid 1px #dadada;
		padding: 10px 110px 10px 14px;
		box-sizing: border-box;
		vertical-align: top;
	}
     .box {
		border: 0 none;
		display: block;
		width: 100%;
		height: 30px;
		outline: none;
	 }
     .boxes {
		height: 20px;
		width: 60%;
		border: solid 1px #dadada;
		outline: none;
	 }
	.button_box {
         margin-top: 20px;
         text-align: center;
         border-top: 1px solid #f2f2f5;
         font-size: 14px;
     }
     .button_box > a {
         display: inline-block;
         padding: 19px 18px 0;
         color: #333;
     }
     .btn_find {
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
</style>
</head>
<body>
		
	<jsp:include page="../layout/header.jsp"></jsp:include>
		
		<div class="join" >
			<form id="findPwForm" action="${contextPath}/member/findPw" method="post">
			<div class="authArea">
				<h3 class="title">비밀번호 찾기</h3>
					<div class="text">
						<p>본인확인 후 비밀번호를 다시 설정할 수 있습니다.</p>
					</div>
					<div class="InputArea">	
						<input type="text" name="memberId" id="memberId" class="box" placeholder="아이디">
					</div>
					<div class="find_box">
						<div class="InputArea">
							<input type="text" id="memberEmail" class="boxes" placeholder="이메일">
							<input type="button" value="인증번호받기" id="btnGetAuthCode">
						</div>
							<span id="emailMsg"></span>
						<div class="InputArea">
							<input type="text" id="authCode" class="boxes" placeholder="인증코드를 입력하세요">
							<input type="button" value="인증하기" id="btnVerifyAuthCode">
						</div>
						<div class="button_box">
							<a href="${contextPath}/member/loginPage">로그인</a> |
							<a href="${contextPath}/member/findIdPage">아이디찾기</a>
						</div>
					</div>
			</div>
				<div class="changeArea">
					<h3 class="title">비밀번호 재설정</h3>
						<div class="InputArea">
							<input type="password" name="memberPw" id="memberPw" class="box" placeholder="새 비밀번호">
						</div>
						<span id="pwMsg"></span>
						<div class="InputArea">
							<input type="password" id="memberRePw" class="box" placeholder="새 비밀번호 확인">
						</div>
							<span id="rePwMsg"></span>
						<button class="btn_find">확인</button>
				</div>
			</form>
		</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>

</body>
</html>