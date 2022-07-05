k<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../../resources/js/jquery-3.6.0.js"></script>
<script>
	$(function(){
		$('#removeReser').on('click', function(){
			const status1 = document.getElementById('popUpReserStatus');
			let status = status1.value;
			status = parseInt(status) - 1;
			$('#popUpReserStatus').attr('value', status)
			let reservation = JSON.stringify(
					{
						reserNo: $('#popUpReserNo').val(),
						reserStatus: $('#popUpReserStatus').val()
					}		
				);
				$.ajax({
					url: '${contextPath}/reserModify',
					type: 'PUT',
					data: reservation,
					contentType: 'application/json',
					success: function(obj){
						if(obj.res > 0){
							alert('예약 정보가 수정되었습니다.');
						} else {
							alert('예약 정보가 수정되지 않았습니다.');
						}
					},
					error: function(jqXHR){
						alert('예외코드[' + jqXHR.status + ']' + jqXHR.responseText);
					}
				})
				if(!confirm('예약을 취소하시겠습니까?')) {
					alert('취소하셨습니다.');
					return false;
				} else {
					alert('예약이 취소 되었습니다.');
					window.close();
			}
		})
	})
	
	
</script>
</head>
<body>
	
	예약번호 ${reservation.reserNo}
	<input type="hidden" name="popUpReserNo" id="popUpReserNo" value="${reservation.reserNo}">
	<input type="hidden" name="popUpReserStatus" id="popUpReserStatus" value="${reservation.reserStatus}">
	
	이름 <input type="text" name="popUpName" id="popUpName" value="${loginMember.memberName}" readonly><br>
	연락처 <input type="text" name="popUpTel" id="popUpTel" value="${loginMember.memberPhone}" readonly><br>
	
	요금 상세 정보
	
	옵션 금액
	부가 금액
	총 금액 ${money.totalPrice}
	체크인 ${room.roomCheckIn} 
	체크아웃 ${room.roomCheckOut}
	
	<input type="button" id="removeReser" value="예약 취소">
</body>
</html>