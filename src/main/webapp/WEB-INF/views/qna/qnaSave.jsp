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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />


<script>
 
 
 	$(function(){
 		fnTextareaLimitQna();
 		fnQnaAddCheck();
 	})
 
	function fnTextareaLimitQna(){
		$('#qnaContent').on('keyup', function(){
			$('#qnaContent_cnt').html("(" + $(this).val().length+" / 500)");
			
			if($(this).val().length > 500){
				$(this).val($(this).val().substring(0,500));
				$('#qnaContent_cnt').html("(500 / 500)" );
			}
			
		})
	}
    
	function fnQnaAddCheck(){
			
			$('#QnaAdd').on('submit', function(ev){
				if($('#qnaTitle').val() == '' || $('#qnaContent').val() == ''){
					alert('제목과 내용을 작성해주세요');
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
   
   <h1>QnA 문의사항</h1>
  
   <a href="${contextPath}/qna/qnaList">목록으로</a>
  
  
   <form id="QnaAdd" method="post" action="${contextPath}/qna/qnaSave">
   		<input type="hidden" id="memberId" name="memberId" value="${loginMember.memberId}"> 
   		제목 : <input type="text" id="qnaTitle" name="qnaTitle"><br>
   		내용 : <textarea rows="20" cols="50" id="qnaContent" name="qnaContent"></textarea><br>
   		<div id="qnaContent_cnt">(0 / 500)</div>
   		<button>등록하기</button>
   </form>
  
  <jsp:include page="../layout/footer.jsp"></jsp:include>
  
  
</body>
</html>