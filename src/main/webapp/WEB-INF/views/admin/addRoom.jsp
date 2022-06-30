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
	
	$(function() {
		fnFileCheck($('#image1'));
		fnFileCheck($('#image2'));
		fnSubmit();
		fnPreview($('#image1'), $('#preview1'));
		fnPreview($('#image2'), $('#preview2'));
	})
	
	// 첨부파일 사전점검(확장자, 크기)
	function fnFileCheck(image) {
		image.on('change', function(){
			// 첨부 규칙
			let regExt = /(.*)\.(jpg|png|gif)$/;
			let maxSize = 10 * 1024 * 1024;  // 하나당 최대 크기
			// 첨부 가져오기
			let files = $(this)[0].files;
			// 각 첨부의 순회
			for(let i = 0; i < files.length; i++) {
				// 확장자 체크
				if(regExt.test(files[i].name) == false) {
					alert('이미지만 첨부할 수 있습니다.');
					$(this).val('');  // 첨부된 파일이 모두 없어짐
					return;
				}
				// 크기 체크
				if(files[i].size > maxSize) {
					alert('10MB 이하의 파일만 첨부할 수 있습니다.');
					$(this).val('');
					return;
				} 
			}
		})
	}
	
	function fnSubmit() {
		$('#f').on('submit', function(event) {
			if($('#image1').val() == '' || $('#image2').val() == '') {
				event.preventDefault();
				alert('이미지를 첨부하세요.');
			}
		})
	}
	
	function fnPreview(image, preview) {
		image.on('change', function() {
			if (this.files && this.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					preview.attr('src', e.target.result);
				};
				reader.readAsDataURL(this.files[0]);
			} else {
				preview.attr('src', "");
			}
		})
	}
	
</script>
<link rel="stylesheet" href="../resources/css/admin.css">
</head>
<body>
		<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="container">
		<jsp:include page="index.jsp"></jsp:include>
		
		<div class="grid_item room">
			<h3>객실등록</h3>
			<form id="f" action="${contextPath}/room/saveRoom" method="post" enctype="multipart/form-data">
				객실타입
				<select name="rtNo">
					<option value="">==선택==</option>
					<option value="1">싱글</option>
					<option value="2">더블</option>
					<option value="3">트윈</option>
				</select><br>
				객실이름 <input type="text" name="roomName" id="roomName"><br>
				객실가격 <input type="text" name="roomPrice" id="roomPrice"><br><br>
				이미지 첨부1 <input type="file" name="image1" id="image1"><br>
				<img id="preview1" width="300px"><br>
				이미지 첨부2 <input type="file" name="image1" id="image2"><br>
				<img id="preview2" width="300px"><br>
				<button>등록</button>
			</form>
		</div>
	</div>
		<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
</html>