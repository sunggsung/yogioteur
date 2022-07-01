<%@ page language="java" contentType="text/html; charset=UTF-8"
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
			const resNo = $('#popUpReserNo').val();
			let deleteReservation = 0;
			let deletePayments = 0;
			let deletePrice = 0;
			$.ajax({
				url: '${contextPath}/reserRemove/' + resNo,
				type: 'DELETE',
				dataType: 'json',
				success: function(obj){
					deleteReservation += obj.res1;
					deletePayments += obj.res2;
					deletePrice += obj.res3;
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
	function reservationRemove() {
		
		
	}
</script>
</head>
<body>
	
	예약번호 ${reservation.reserNo}
	<input type="hidden" name="popUpReserNo" id="popUpReserNo" value="${reservation.reserNo}">
	
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