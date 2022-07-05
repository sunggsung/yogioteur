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
<link rel="stylesheet" href="../resources/css/reviewList.css?after">
<script>

	// 리뷰수정
	function fnReviewModify(mb){
		location.href='${contextPath}/review/reviewChangePage?reviewNo=' + $(mb).data('review_no');
	}
	//댓글 저장
	function fnReviewReply(bn){
		location.href='${contextPath}/reply/reviewReplySavePage?reviewNo=' + $(bn).data('review_no');
	}
	// 리뷰삭제
	 function fnReviewRemove(reviewNo){      
	       if(confirm('리뷰를 삭제할까요?')){
	          location.href='${contextPath}/review/reviewRemove?reviewNo=' + reviewNo;
	       }
	 }
	
	//댓글 수정
	function fnReviewReplyModify(mr){
		location.href='${contextPath}/reply/reviewReplyChangePage?replyNo=' + $(mr).data('reply_no')+'&reviewNo='+$(mr).data('review_no') ;
	}
	 // 댓글 삭제
	 function fnReviewReplyRemove(rpn){
		 if(confirm('댓글을 삭제할까요?')){
	          location.href='${contextPath}/reply/reviewReplyRemove?replyNo=' + $(rpn).data('reply_no');
	       }
	 }
	 
</script>
<style>
	.unlink, .link {
		display: inline-block;  /* 같은 줄에 둘 수 있고, width, height 등 크기 지정 속성을 지정할 수 있다. */
		padding: 10px;
		margin: 5px;
		border: 1px solid white;
		text-align: center;
		text-decoration: none;  /* 링크 밑줄 없애기 */
		color: gray;
	}
	.link:hover {
		border: 1px solid orange;
		color: limegreen;
	}
	
	.paging{
		text-align: center;
	}
	input[type=button] { 	
	 	color : white;
		background-color : #696969;
		padding : 10px;
		border : none;
	}
	
</style>
</head>
<body>

   <jsp:include page="../layout/header.jsp"></jsp:include>
   
   <h1 class="rivewListTitle">리뷰목록</h1>
   
   <div class="reviewListView">
   
   
	  <c:if test = "${loginMember.memberId ne null}">
	   		<a class="addRe" href="${contextPath}/review/reviewSavePage">새 리뷰 작성하기</a>
	   </c:if> 
	  
	  <br><br>
	   
	   <c:forEach items="${reviews}" var="review">
	   		
	   		<div id = "ReviewListONE">
	   			<div class="memberReview">
	   				<div class="reviewbox"> 
	   				<span class="usericon"><i class="fa-solid fa-face-smile fa-2x"></i></span>  &nbsp; &nbsp;
	   				<span class="reviewTitleName"> ${review.reviewTitle}</span><br>
	   					<div class="ReviewNomal">
	   					<c:forEach var="i" begin="1" end="5">
	   						<c:if test="${review.reviewRevNo ge i}">
		   						<span id="staro">★</span>					
	   						</c:if>
	   						<c:if test="${review.reviewRevNo lt i}">
		   						<span id="staro">☆</span>					
	   						</c:if>	
	   					</c:forEach>
	   					
	   					<br>
	   					
	   					아이디 : ${review.memberId}<br>
	   					${review.roomName} ${review.rtType}<br>
	   					${review.reviewContent}<br>
	   					${review.reviewCreated}<br>
	   					</div>
	   					
	   					<br><br>
						
						<c:forEach var="reImage" items="${reImages}">
							<c:if test="${review.reviewNo eq reImage.reviewNo}">
								<img alt="${reImage.reImageOrigin}" src="${contextPath}/review/display?reImageNo=${reImage.reImageNo}" width="300px">					
							</c:if>
						</c:forEach>
						
						<br>
						<c:if test="${loginMember.memberId eq review.memberId || loginMember.memberId eq 'admin123'}">
			   				<input type="button" value="삭제" name="reviewRemoveBtn" onclick="fnReviewRemove(${review.reviewNo})">					
						</c:if>
						
						<c:if test = "${loginMember.memberId eq review.memberId}">
							<input type="button" value="리뷰 수정" name="reviewModifyBtn" data-review_no="${review.reviewNo}" onclick="fnReviewModify(this)">
			   			</c:if>
			   			
			   			<c:if test = "${loginMember.memberId eq 'admin123'}">
			   				<input type="button" value="댓글달기" id ="reviewReplyBtn" data-review_no="${review.reviewNo}" onclick="fnReviewReply(this)">
			   			</c:if>
			   			
			   			
			   			
	   				</div>
	   			</div>
	   			
						<c:forEach items="${reviewReplies}" var="reviewReply">
		   						<c:if test="${review.reviewNo eq reviewReply.reviewNo}">
					   			<div class="adminicon">Yogioteur Hotel <i class="fa-solid fa-hotel fa-2x"></i> </div>
					   				<div class="adminReply">		
			   							<div id="adminReplyList" >
					   						<div>
												${reviewReply.replyContent}
												<c:if test = "${loginMember.memberId eq 'admin123'}">		   					
								   					<input type="button" id="reviewReplyRemoveBtn" value="댓글 삭제" data-reply_no="${reviewReply.replyNo}" onclick="fnReviewReplyRemove(this)">
								   					<input type="button" id="reviewReplyModifyBtn" value="댓글 수정" data-reply_no="${reviewReply.replyNo}" data-review_no="${review.reviewNo}" onclick="fnReviewReplyModify(this)">
					   							</c:if>
					   						</div>					
					   					</div>		   					   						
		   							</div>
		   						</c:if>
						</c:forEach>
	   			
	   		</div>
	   		
	   </c:forEach>
   </div>
   
   
   <div class="paging">${paging}</div>
   
   <jsp:include page="../layout/footer.jsp"></jsp:include>
   
</body>
</html>