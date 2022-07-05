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
       	margin: 0 auto 20px;
       	text-align: center;
    }
    .content {
    	margin: 10px 0;
    	text-align: center;
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
    .false {
   		width: 390px;
   		margin: 110px auto;
  	 	padding: 60px 50px 51px;
  	 	border: 1px solid #dadada;
    }
    .btn_notFound {
    	text-align: center;
    }
</style>
</head>
<body>

	<jsp:include page="../layout/header.jsp"></jsp:include>

	<c:if test="${memberConfirm != null}">
		<div class="join" >
			<h3 class="title">아이디 찾기</h3>
				<div class="content">
					<div class="find_box">
						회원님의 아이디 : ${memberConfirm.memberId} 
					</div>
					<div class="find_box">
						가입일 : ${memberConfirm.signIn}
					</div>
					<input type="button" value="로그인" class="btn_findId" onclick="location.href='${contextPath}/member/loginPage'">
				</div>
		</div>
	</c:if>
	
	<c:if test="${memberConfirm == null}">
		<div class="false" >
			<h3 class="title">아이디 찾기</h3>
				<div class="content">
					입력하신 정보로 등록된 회원이 없습니다.<br>
					정보를 다시 확인하시고 시도해주세요.
				</div>
				<div class="btn_notFound">
					<input type="button" value="취소" onclick="location.href='${contextPath}/'">
					<input type="button" value="회원가입" onclick="location.href='${contextPath}/member/agreePage'">
				</div>
		</div>
	</c:if>
	
	<jsp:include page="../layout/footer.jsp"></jsp:include>
	
	
</body>
</html>