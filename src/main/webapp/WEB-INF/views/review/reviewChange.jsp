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
<link rel="stylesheet" href="../resources/css/reviewChange.css?af">
<script>
	
	$(function(){

		fnFileCheck();
		fnReviewList();
		fnReviewModifyCheck();
		fnRadioStar();
		fnReviewMLimit();
	})
	
	function fnRadioStar(){
		
		var star = 6 - ${review.reviewRevNo};
		
		$('#rate'+star).prop('checked',true);
		
	}
	
	function fnReviewModifyCheck(){
		
		$('#reviewChange').on('submit', function(event){
			 if($('#reviewTitle').val() == '' || $('#review_textarea').val() == null ){
				
				
				alert('리뷰제목 또는 리뷰내용이 없습니다.');
				event.preventDefault();
				return false;
			}
			
			
			
			return true;
		})
	}
	
		
	
	
	function fnReviewList(){
		$('#reviewList').on('click', function(){
			location.href="${contextPath}/review/reviewList";
		})
	}
	
	// 첨부파일 사전점검(확장자, 크기)
	function fnFileCheck(){
		$('#files').on('change', function(){
			// 첨부 규칙
			let regExt = /(.*)\.(jpg|png|gif)$/;
			let maxSize = 1024 * 1024 * 10;  // 하나당 최대 크기
			// 첨부 가져오기
			let files = $(this)[0].files;
			// 각 첨부의 순회
			for(let i = 0; i < files.length; i++){
				// 확장자 체크
				if(regExt.test(files[i].name) == false){
					alert('이미지만 첨부할 수 있습니다.');
					$(this).val('');  // 첨부된 파일이 모두 없어짐
					return;
				}
				// 크기 체크
				if(files[i].size > maxSize){
					alert('10MB 이하의 파일만 첨부할 수 있습니다.');
					$(this).val('');  // 첨부된 파일이 모두 없어짐
					return;
				}
			}
		})
	}
		
	function fnReviewMLimit(){
		$('#review_textarea').on('keyup', function(){
			$('#review_textarea_cnt').html("(" + $(this).val().length+" / 500)");
			
			if($(this).val().length > 500){
				$(this).val($(this).val().substring(0,500));
				$('#review_textarea_cnt').html("(500 / 500)" );
			}
			
		})
	}
</script>
<style type="text/css">

	#reviewChange fieldset{
    display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
    border: 0; /* 필드셋 테두리 제거 */
	}
	#reviewChange input[type=radio]{
	    display: none; /* 라디오박스 감춤 */
	}
	#reviewChange label{
    font-size: 3em; /* 이모지 크기 */
    color: transparent; /* 기존 이모지 컬러 제거 */
    text-shadow: 0 0 0 #f0f0f0; /* 새 이모지 색상 부여 */
	}
	#reviewChange input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99); /* 마우스 클릭 체크 */
}
	#reviewChange fieldset{
    display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
    direction: rtl; /* 이모지 순서 반전 */
    border: 0; /* 필드셋 테두리 제거 */
}
}
</style>

</head>
<body>

   <jsp:include page="../layout/header.jsp"></jsp:include>
   
   <h1 class="reChangetitle">리뷰 수정하기</h1>
   
   
   <div class ="reviewChangeOne">
	   <form id="reviewChange" action="${contextPath}/review/reviewChange" method="post" enctype="multipart/form-data">
	   		
	   		
	   		<input type="hidden" name="reviewNo" value="${review.reviewNo}">
	   		아이디 : <input type="text" id="memberId" name="memberId" value="${loginMember.memberId}" readonly> <br>
	   		<input type="text" id="roomName" name="roomName" value="방1" readonly> 
		   	<input type="text" id="rtType" name="rtType" value="싱글" readonly> <br>
	  		
	  		별점 :
	   		<fieldset>
		        <input type="radio" name="reviewRevNo" value="5" id="rate1"><label for="rate1">★</label>
		        <input type="radio" name="reviewRevNo" value="4" id="rate2"><label for="rate2">★</label>
		        <input type="radio" name="reviewRevNo" value="3" id="rate3"><label for="rate3">★</label>
		        <input type="radio" name="reviewRevNo" value="2" id="rate4"><label for="rate4">★</label>
		        <input type="radio" name="reviewRevNo" value="1" id="rate5"><label for="rate5">★</label>
	    	</fieldset>
	  		<br>
	  		<input type="text" id="reviewTitle" name="reviewTitle" value="${review.reviewTitle}" ><br>
	  		<textarea rows="10" cols="50" id="review_textarea" class="review_textarea" id="reviewContent" name="reviewContent" >${review.reviewContent}</textarea><br>
	   		<div id="review_textarea_cnt">(0 / 500)</div>
	   		
	   		
	   		<input type="file" name="files" id="files" multiple="multiple"/>
	   		<button>수정하기</button>
	   		<input type="button" id="reviewList" value="목록으로">
	   	
	   	
	 	  </form>
   		

   			<c:forEach var="reImage" items="${reImage}" varStatus="status">
				<div>${reImage.reImageOrigin}<a href="${contextPath}/review/removeReImage?reImageNo=${reImage.reImageNo}&reviewNo=${reImage.reviewNo}"><i class="fa-solid fa-circle-xmark"></i></a></div>
			</c:forEach>
				
				
			<hr>
			
			
			<c:forEach var="reImage" items="${reImage}">
				<img alt="${reImage.reImageOrigin}" src="${contextPath}/review/display?reImageNo=${reImage.reImageNo}&reviewNo=${reImage.reviewNo}" width="300px" height=" 200px">					
			</c:forEach>
   		
   	</div>
   
   <jsp:include page="../layout/footer.jsp"></jsp:include>
   
</body>
</html>