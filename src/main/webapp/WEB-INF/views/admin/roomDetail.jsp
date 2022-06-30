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
	
	$(document).ready(function() {
		var rtNo = ${room.rtNo}
		switch(rtNo) {
		case 1:
			$('#rtNo').val("1")
			break;
		case 2:
			$('#rtNo').val("2")
			break;
		case 3:
			$('#rtNo').val("3")
			break;
		}
		$('#btnRemove').on('click', function() {
			if(confirm('삭제하시겠습니까?')) {
				location.href='${contextPath}/room/remove?roomNo=${room.roomNo}';
			}
		})
		fnPreview($('#image1'), $('#preview1'));
		fnPreview($('#image2'), $('#preview2'));
	})
	
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
	
	<div class="container">
		<jsp:include page="index.jsp"></jsp:include>
		
		<div class="grid_item room">
			<h3>객실상세</h3>
			<form id="f" action="${contextPath}/room/changeRoom" method="post" enctype="multipart/form-data">
				객실번호: ${room.roomNo}<br>
				<input type="hidden" name="roomNo" value="${room.roomNo}">
				객실타입
				<select name="rtNo" id="rtNo">
					<option value="1">싱글</option>
					<option value="2">더블</option>
					<option value="3">트윈</option>
				</select><br>
				객실이름 <input type="text" name="roomName" id="roomName" value="${room.roomName}"><br>
				객실가격 <input type="text" name="roomPrice" id="roomPrice" value="${room.roomPrice}"><br>
				예약상태:
				<c:choose>
					<c:when test="${room.roomStatus eq 0}"><td>예약가능</td></c:when>
					<c:when test="${room.roomStatus eq 1}"><td>예약불가</td></c:when>
				</c:choose><br>
				${room.roomCheckIn}<br>
				${room.roomCheckOut}<br>
				
				사진1 <input type="file" name="image1" id="image1">
				<div>
					<img id="preview1" alt="${image[0].imageOrigin}" src="${contextPath}/room/display?imageNo=${image[0].imageNo}" width="300px">
					<input type="hidden" name="image1No" value="${image[0].imageNo}">
				</div>
				사진2 <input type="file" name="image1" id="image2">
				<div>
					<img id="preview2" alt="${image[1].imageOrigin}" src="${contextPath}/room/display?imageNo=${image[1].imageNo}" width="300px">
					<input type="hidden" name="image2No" value="${image[1].imageNo}">
				</div>
				<button>수정</button>
				<input type="button" value="목록으로" onclick="location.href='${contextPath}/admin/room'">
				<input type="button" value="삭제" id="btnRemove">
			</form>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
</html>