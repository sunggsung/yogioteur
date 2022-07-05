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
		
		$('.reply_link').on('click', function(){
			//$('.reply_form').addClass('blind');
	    	$(this).parent().parent().next().toggleClass('blind');
		});
		
		fnTextareaLimitQnaReply();
		fnQnaReplyCheck();
	})
	
	function fnTextareaLimitQnaReply(){
		$('#qnaReplyContent').on('keyup', function(){
			$('#qnaReplyContent_cnt').html("(" + $(this).val().length+" / 300)");
			
			if($(this).val().length > 300){
				$(this).val($(this).val().substring(0,300));
				$('#qnaReplyContent_cnt').html("(300 / 300)" );
			}
			
		})
		
		$('#qnaReplyContentAdd').on('keyup', function(){
			$('#qnaReplyContentAdd_cnt').html("(" + $(this).val().length+" / 300)");
			
			if($(this).val().length > 300){
				$(this).val($(this).val().substring(0,300));
				$('#qnaReplyContentAdd_cnt').html("(300 / 300)" );
			}
			
		})
		
		
	}
	
	function fnQnaReplyCheck(){
		
		$('#qnaReplyData').on('submit', function(ev){
			if($('#qnaReplyContent').val() == ''){
				alert('댓글을 작성해주세요');
				ev.preventDefault();
				return false;
			}
			
			
			return true;
		})
		
		$('#replyadd').on('submit', function(ev){
			if($('#qnaReplyContentAdd').val() == ''){
				alert('댓글을 작성해주세요');
				ev.preventDefault();
				return false;
			}
			
			
			return true;
		})
	}
    
	function fnRemoveA(qnaReplyNo, qnaNo){      
		
        if(confirm('게시글을 삭제할까요?')){
           location.href='${contextPath}/qnaReply/qnaReplyRemove?qnaReplyNo=' + qnaReplyNo +'&qnaNo=' +qnaNo;
        }
  }
	
</script>

<style>
	.blind {
		display: none;
	}
	
	
	.qnaDtailA{
		color : blue;
	}
	.qnaDetailOne{
		width : 850px;
		margin : 0 auto;
	
	}
	
	h1 {
		text-align : center;
	}
	
	#qnaReplyContent{
	  width: 850px;
	  height: 100px;
	  font-size: 15px;
	  border: 0;
	  border-radius: 10px;
	  outline: none;
	  padding-left: 10px;
	  background-color: rgb(233, 233, 233);
	  margin : 15px auto;
	  padding : 10px;
	  
	}
	
	.qnaReplyContent_cnt{
		text-align : right;
	}
	
	
	
	
</style>
</head>
<body>
   
   <jsp:include page="../layout/header.jsp"></jsp:include>
   
   <div class="qnaDetailOne">
   
	  <h1>QnA 상세보기</h1>
	  
	  <a class="qnaDtailA" href="${contextPath}/qna/qnaList">목록으로</a>
	  
	  
	  <hr>
		
		 	
		  		<c:if test="${qna.qnaCreated < qna.qnaModified}<br>">
		  			수정일 : ${qna.qnaModified}<br>
		  		</c:if>
		  		제목	: ${qna.qnaTitle}
		  		작성일 	: ${qna.qnaCreated}<br>
		  		조회수  : ${qna.qnaHit}<br><br>
		  		아이디 	: ${qna.memberId}<br><br>
		  		내용 	: ${qna.qnaContent}<br><br><br>
		 		
		 		<a class="qnaDtailA"  href="${contextPath}/qna/qnaUpdatePage?qnaNo=${qna.qnaNo}">수정하기</a>
		 	
		 	<br><br>
		 	
		 	<form id="qnaReplyData" method="post" action="${contextPath}/qnaReply/qnaReplySave">
		 		<input type="hidden" name="qnaNo" value="${qna.qnaNo}">
			  	<input type="hidden" name="memberId" value="${loginMember.memberId}">		  
			  	<textarea rows="10" cols="50" id="qnaReplyContent" name="qnaReplyContent"></textarea><br>
			  	<div class ="qnaReplyContent_cnt">
				  	<div id="qnaReplyContent_cnt">(0 / 300)</div><br>
				  	<button>댓글 달기</button>
			  	</div>
			</form>
		 	
			
		 
		  
		  <br><br>
		<table>
		
			<tbody>
		 		<c:forEach items="${qnaReplies}" var="qnaReply">
			 		<c:if test="${qnaReply.qnaReplyState == -1}">
						<tr>
							<td></td>
							<td>삭제된 댓글입니다</td>
						</tr>
					</c:if>
					<c:if test="${qnaReply.qnaReplyState == 1}">
						<tr>
							<td>아이디 	: ${qnaReply.memberId}</td>
							<td>
								<!-- Depth만큼 들여쓰기(Depth 1 == Space 2) -->
								<c:forEach begin="1" end="${qnaReply.qnaReplyDepth}" step="1">&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach>
								<!-- 댓글은 re 표시 -->
								<c:if test="${qnaReply.qnaReplyDepth gt 0}"><i class="fa-brands fa-replyd"></i></c:if>
								<!-- 내용 -->
								<c:if test="${qnaReply.qnaReplyContent.length() gt 200}">								
									${qnaReply.qnaReplyContent.substring(0, 200)}
								</c:if>
								<c:if test="${qnaReply.qnaReplyContent.length() le 200}">								
									${qnaReply.qnaReplyContent}
								</c:if>
								<!-- 답글달기(if 있으면 1단 댓글만 허용, if 없으면 다단 댓글 허용) -->
								<c:if test="${fb.depth eq 0}">
									<a class="reply_link">답글</a>	
								</c:if>							
							</td>
							<td>${qnaReply.qnaReplyCreated}</td>
							<td>
								<c:if test = "${loginMember.memberId eq qnaReply.memberId || loginMember.memberId eq 'admin123'}">
									
							
									<td><input type="button" value="삭제" onclick="fnRemoveA(${qnaReply.qnaReplyNo}, ${qna.qnaNo})"></td>
								</c:if>
									
							</td>
						</tr>
						<tr class="reply_form blind">
							<td >
								<form id="replyadd" action="${contextPath}/qnaReply/qnaReplySaveSecond" method="post">
									<input type="hidden" name="qnaNo" value="${qna.qnaNo}" >
									<input type="text" name="memberId" value="${loginMember.memberId}" size="7" readonly>
									<input type="text" id="qnaReplyContentAdd" name="qnaReplyContent">
									<div id="qnaReplyContentAdd_cnt">(0 / 300)</div>
					
									<!-- 원글의 Depth, GroupNo, GroupOrd -->
									<input type="hidden" name="qnaReplyDepth" value="${qnaReply.qnaReplyDepth}">
									<input type="hidden" name="qnaReplyGroupNo" value="${qnaReply.qnaReplyGroupNo}">
									<input type="hidden" name="qnaReplyGroupOrd" value="${qnaReply.qnaReplyGroupOrd}">
									<button>답글달기</button>
								</form>
							</td>
						</tr>
					</c:if>
			  			
			  						 			
		 		</c:forEach>
			
			</tbody>
		
		</table>
		 			
		 			
		 			
				   			
		</div>		   		
		 		 	
		 			
					
		 
	   <br><br>
	  <jsp:include page="../layout/footer.jsp"></jsp:include>
	  	
	    
  		
</body>
</html>