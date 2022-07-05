<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ</title>
<script src="../resources/js/jquery-3.6.0.js"></script>
<script>
	$(function(){
		fnFaqAddLimit();
		fnReviewAddCheck();
	})
	function fnFaqAddLimit(){
		$('#faqContent').on('keyup', function(){
			$('#faqContent_cnt').html("(" + $(this).val().length+" / 500)");
			
			if($(this).val().length > 500){
				$(this).val($(this).val().substring(0,500));
				$('#review_textarea_cnt').html("(500 / 500)" );
			}
			
		})
	}
	
	function fnReviewAddCheck(){
		
		$('#faqSv').on('submit', function(ev){
			if($('#faqTitle').val() == '' || $('#faqContent').val() == ''){
				
				
				alert('작성된 내용이 없습니다.');
				ev.preventDefault();
				return false;
			}
			
			
			return true;
		})
	}
	
	
</script>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	
 	<h1>FAQ 게시글 작성</h1>
	
	<form id="faqSv" action="${contextPath}/faq/faqSave" method="post">
		<input type="text" id="faqTitle" name="faqTitle"><br>
		<textarea rows="5" cols="50" id="faqContent" name="faqContent"></textarea><br><br>
		<div id="faqContent_cnt">(0 / 500)</div><br><br>
		<button>등록</button>
		<input type="button" value="목록" onclick="location.href='${contextPath}/faq/faqList'">
		<input type="reset" value="초기화">
	</form>

	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
</html>