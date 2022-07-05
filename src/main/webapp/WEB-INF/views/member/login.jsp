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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js" integrity="sha512-3j3VU6WC5rPQB4Ld1jnLV7Kd5xr+cq9avvhwqzbH/taCRNURoeEpoPBK9pDyeukwSxwRPJ8fDgvYXd6SkaZ2TA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
		
	$(function(){
		fnLogin();	
		fnRememberId();
	})
	function fnLogin(){
	
		$('#Loginform').on('submit', function(e){
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
			if($('#rememberId').is(':checked')){			
				$.cookie('rememberId', $('#memberId').val());		
			} else{
				$.cookie('rememberId', '');					
			}
			return true;
		})
	}
	function fnRememberId(){
		let rememberId = $.cookie('rememberId');
		if(rememberId !=''){	
			$('#memberId').val(rememberId);
			$('#rememberId').prop('checked', true);
		} else {				
			$('#memberId').val('');
			$('#rememberId').prop('checked', false);
		}
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
    .text {
    	text-align: center;
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
    .login_box {
        display: block;
        height: 48px;
        margin-bottom: 6px;
        border: 1px solid #d7d7d7;
        position: relative;
    }
	.login_box > input {
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
     .btn_login {
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
	
        <div class="join">
       		<form id="Loginform" action="${contextPath}/member/login" method="post">
				<a href="${contextPath}/">
					<h2 class="title">YOGIOTEUR</h2>
				</a>
				<div class="text">
				   <p><strong>아이디와 비밀번호를 입력해 주시기 바랍니다.</strong></p>
				   <p>YOGIOTEUR 호텔 회원이되시면 회원만을 위한 다양한 서비스와 혜택을 받으실 수 있습니다.</p>
				</div>
				<input type="hidden" name="url" value="${url}">
				<div class="content">
					<div class="login_box">
						<input type="text" id="memberId" name="memberId" class="login_id" placeholder="아이디"><br>
					</div>
					<div class="login_box">
						<input type="password" id="memberPw" name="memberPw" class="login_pw" placeholder="비밀번호">
					</div>
				</div>
				<button class="btn_login" >로그인</button>
				
				<div>
					<label>
						<input type="checkbox" id="rememberId">아이디저장
					</label>
				</div>
			</form>
	
			<div class="button_box">
				<a href="${contextPath}/member/findIdPage">아이디 찾기</a> |
				<a href="${contextPath}/member/findPwPage">비밀번호 찾기</a> |
				<a href="${contextPath}/member/agreePage">회원가입</a> 
			</div>
			
			<!-- 네이버 아이디 로그인 -->
			<a href="${apiURL}"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
		
		</div>

</body>
</html>