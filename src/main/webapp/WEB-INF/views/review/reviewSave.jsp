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
<link rel="stylesheet" href="../resources/css/reviewSave.css">
<script>
	
	$(function(){
		fnFileCheck();
		fnReivewAddLimit();
		fnReviewAddCheck();
	})
	
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
	function fnReivewAddLimit(){
		$('#review_textarea').on('keyup', function(){
			$('#review_textarea_cnt').html("(" + $(this).val().length+" / 500)");
			
			if($(this).val().length > 500){
				$(this).val($(this).val().substring(0,500));
				$('#review_textarea_cnt').html("(500 / 500)" );
			}
			
		})
	}
	
	function fnReviewAddCheck(){
		
		$('#reviewAdd').on('submit', function(ev){
			if($('#reviewTitle').val() == '' || $('#review_textarea').val() == '' || $('input:radio[name="reviewRevNo"]').is(':checked').val() == false){
				
				
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
   
   <h1 class="reAddtitle">새 리뷰 작성</h1>
   
   <div class ="reviewAddWriter">
	   <form id="reviewAdd" action="${contextPath}/review/reviewSave" method="post" enctype="multipart/form-data">
	   		
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
	  		<input type="text" id="reviewTitle" name="reviewTitle" placeholder="리뷰 제목" maxlength='50'><br>
	  		<textarea rows="10" cols="50" id="review_textarea" class="review_textarea" name="reviewContent" placeholder="리뷰 내용"></textarea><br>
	   		<div id="review_textarea_cnt">(0 / 500)</div>
	   		
	   		
		   		<input type="file" name="files" id="files" multiple="multiple"/>
		   		<button id="addBtn">등록</button>
	   </form>
   </div>
   <jsp:include page="../layout/footer.jsp"></jsp:include>
   
</body>
</html>