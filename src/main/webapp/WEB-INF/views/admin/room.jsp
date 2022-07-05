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
		fnRoomDetail();
		$('#roomStatus').on('change', function() {
			if($('#roomStatus').val() != '') {
				fnSelectSatus($('#roomStatus').val());
			} else {
				fnReset();
			}
		})
	})
	
	var page = 1;
	// 예약상태(0, 1)로 분류
	function fnSelectSatus(status) {
		$.ajax({
			url: '${contextPath}/admin/findRoomByStatus',
			data: 'roomStatus=' + status,
			type: 'GET',
			success: function(obj) {
				$('#rooms').empty();
				$('#tfoot').empty();
				console.log(obj.rooms);
				$.each(obj.rooms, function(i, room) {
					var tr = '<tr>';
					tr += '<td>' + room.roomNo + '</td>';
					tr += '<td>' + room.roomName + '</td>';
					tr += '<td class="type' + room.roomTypeDTO.rtNo + '">' + room.roomTypeDTO.rtType + '</td>';
					tr += '<td>' + room.roomPrice + '</td>';
					if(room.roomStatus == 0) {
						tr += '<td>예약가능</td>';
					} else {
						tr += '<td>예약불가</td>';
					}
					tr += '<td><input type="button" value="상세보기" class="btnDetail" data-room_no="' + room.roomNo + '"></td>';
					tr += '</tr>';
					$('#rooms').append(tr);
				})
			}
		})
	}
	function fnRoomDetail() {
		$(document).on('click', '.btnDetail', function() {
			location.href='${contextPath}/admin/roomDetail?roomNo=' + $(this).data('room_no');
		})
	}
	
	function fnReset() {
		location.href='${contextPath}/admin/room';
	}
	
</script>
<link rel="stylesheet" href="../resources/css/admin.css">
<style type="text/css">
	
	.type1 {
		color: red; 
	}
	.type2 {
		color: blue;
	}
	.type3 {
		color: green;
	}

</style>
</head>
<body>
	
	<div class="container">
		<jsp:include page="index.jsp"></jsp:include>
		
		<div class="grid_item room">
			<h3>객실 목록</h3>
			<table class="table">
				<thead>
					<tr>
						<td>번호</td>
						<td>이름</td>
						<td>타입</td>
						<td>가격</td>
						<td>
							<select name="roomStatus" id="roomStatus">
								<option value="">예약상태</option>
								<option value="0">예약가능</option>
								<option value="1">예약불가</option>
							</select>
						</td>
						<td>보기</td>
					</tr>
				</thead>
				<tbody id="rooms">
					<c:forEach items="${rooms}" var="room" varStatus="vs">
						<tr>
							<td>${room.roomNo}</td>
							<td>${room.roomName}</td>
							<td class="type${room.roomTypeDTO.rtNo}">${room.roomTypeDTO.rtType}</td>
							<td>${room.roomPrice}</td>
							<c:choose>
								<c:when test="${room.roomStatus eq 0}"><td>예약가능</td></c:when>
								<c:when test="${room.roomStatus eq 1}"><td>예약불가</td></c:when>
							</c:choose>
							<td><input type="button" value="상세보기" class="btnDetail" data-room_no="${room.roomNo}"></td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot id="tfoot">
					<tr>
						<td colspan="6">${paging}</td>
					</tr>
				</tfoot>
			</table>
		</div>
		
	</div>

</body>
</html>