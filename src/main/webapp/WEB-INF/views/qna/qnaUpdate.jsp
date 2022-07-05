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
			fnTextareaLimitQnaM();
			fnQnaAddMCheck();
		})
	
	function fnTextareaLimitQnaM(){
		$('#qnaContentM').on('keyup', function(){
			$('#qnaContentM_cnt').html("(" + $(this).val().length+" / 500)");
			
			if($(this).val().length > 500){
				$(this).val($(this).val().substring(0,500));
				$('#qnaContentM_cnt').html("(500 / 500)" );
			}
			
		})
	}
	
	function fnQnaAddMCheck(){
			
			$('#QnaAddM').on('submit', function(ev){
				if($('#qnaTitleM').val() == '' || $('#qnaContentM').val() == ''){
					alert('문의사항 제목과 내용을 작성해주세요');
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
   
   <h1>QnA 문의사항 수정</h1>
  
   <a href="${contextPath}/qna/qnaList">목록으로</a>
  
  
   <form id="QnaAddM" method="post" action="${contextPath}/qna/qnaUpdate">
   
   		<input type="hidden" name="qnaNo" value="${qna.qnaNo}"> 
   		<input type="hidden" name="memberId" value="${qna.memberId}" readonly> 
   		제목 : <input type="text" id="qnaTitleM" name="qnaTitle" value="${qna.qnaTitle}" readonly><br>
   		내용 : <textarea rows="20" cols="50" id="qnaContentM" name="qnaContent">${qna.qnaTitle}</textarea><br>
   		<div id="qnaContentM_cnt">(0 / 500)</div>
   		<button>수정하기</button>
   </form>
  
  <jsp:include page="../layout/footer.jsp"></jsp:include>
  
  
</body>
</html>