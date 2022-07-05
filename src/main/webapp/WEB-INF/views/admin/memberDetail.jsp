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

	$(function(){
		fnReservationList();
	})
	
	function fnReservationList() {
		$.ajax({
			url: '${contextPath}/admin/memberReserList?memberNo=' + ${member.memberNo},
			type: 'GET',
			dataType: 'json',
			success: function(obj) {
				$('#items').empty();
				$.each(obj.reservation, function(i, reservation) {
					var tr = '<tr>';
					tr += '<td>' + reservation.reserNo + '</td>';
					tr += '<td>' + reservation.roomNo + '</td>';
					tr += '<td>' + formatDate(reservation.reserCheckin) + '</td>';
					tr += '<td>' + formatDate(reservation.reserCheckout) + '</td>';
					tr += '<td>' + reservation.reserPeople + '</td>';
					tr += '</tr>';
					$('#items').append(tr);
				})
			}
			
		})
	}
	
	// 타임스탬프 형식을 yyyy/MM/dd 로 반환
	function formatDate(date) {
	    var d = new Date(date),
	        month = '' + (d.getMonth() + 1),
	        day = '' + d.getDate(),
	        year = d.getFullYear();

	    if (month.length < 2) 
	        month = '0' + month;
	    if (day.length < 2) 
	        day = '0' + day;

	    return [year, month, day].join('/');
	}
	
</script>
<link rel="stylesheet" href="../resources/css/admin.css">
</head>
<body>
	
	<div class="container">
		<jsp:include page="index.jsp"></jsp:include>
		
		<div class="grid_item member">
			<h3>회원상세</h3>
			회원번호: ${member.memberNo}<br>
			아이디: ${member.memberId}<br>
			성명: ${member.memberName}<br>
			이메일: ${member.memberEmail}<br>
			연락처: ${member.memberPhone}<br>
			주소: ${member.memberRoadAddr}<br>
			가입일: ${member.signIn}<br>
			<hr>
			<table>
				<caption>예약 내역</caption>
				<thead>
					<tr>
						<td>예약번호</td>
						<td>객실번호</td>
						<td>체크인날짜</td>
						<td>체크아웃날짜</td>
						<td>인원수</td>
					</tr>
				</thead>
				<tbody id="items">
					
				</tbody>
				<tfoot>
					
				</tfoot>
			</table>
		</div>
		
	</div>

</body>
</html>