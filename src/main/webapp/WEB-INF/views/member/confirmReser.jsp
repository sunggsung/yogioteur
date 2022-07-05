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
<style>
	ul li a {
		color: gray;
	}
</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$(document).ready(function(){
		popupOpen();
		deleteReser();
		reviewPage();
	})
	function popupOpen(){	
		$(".cancelBtn").click(function(){ 
			var cancelBtn = $(this);
			
			// checkBtn.parent() : checkBtn의 부모는 <td>이다.
			// checkBtn.parent().parent() : <td>의 부모이므로 <tr>이다.
			var tr = cancelBtn.parent().parent();
			var td = tr.children();
			
			var no = td.eq(0).text();
			
			console.log(no);
		
			var popUrl = "${contextPath}/reservation/reservationCancel/" + no; //팝업창에 출력될 페이지 URL	
			var popOption = "width=640, height=360, top=50, left=310, resizable=no, scrollbars=no, status=no;"; //팝업창 옵션(optoin)	
			window.open(popUrl,"",popOption);	
		})
	}
	function deleteReser(){
		$('.deleteBtn').click(function(){
			var deleteBtn = $(this);
			
			// checkBtn.parent() : checkBtn의 부모는 <td>이다.
			// checkBtn.parent().parent() : <td>의 부모이므로 <tr>이다.
			var tr = deleteBtn.parent().parent();
			var td = tr.children();
			
			var resNo = td.eq(0).text();
			
			console.log(resNo);
			
			let deleteReservation = 0;
			let deletePayments = 0;
			let deletePrice = 0;
			$.ajax({
				url: '${contextPath}/reserRemove/' + resNo,
				type: 'DELETE',
				dataType: 'json',
				success: function(obj){
					alert('예약 내역을 제거합니다.');
					deleteReservation += obj.res1;
					deletePayments += obj.res2;
					deletePrice += obj.res3;
				}
			})
		})
	}
	function reviewPage(){	
		$(".reviewBtn").click(function(){ 
			var reviewBtn = $(this);
			
			// checkBtn.parent() : checkBtn의 부모는 <td>이다.
			// checkBtn.parent().parent() : <td>의 부모이므로 <tr>이다.
			var tr = reviewBtn.parent().parent();
			var td = tr.children();
			
			var roomNo = td.eq(1).text();
			
			console.log(roomNo);
		
			$.ajax({
				url: '${contextPath}/review/reviewSavePage',
				type: 'GET',
				data: { "roomNo" : roomNo }
			})
		})
	}
</script>
</head>
<body>
		
	<jsp:include page="../layout/header.jsp"></jsp:include>
			
	<ul>
		<li><a href="${contextPath}/member/memberInfo">내정보</a></li>
		<li><a href="${contextPath}/member/modifyPwPage">비밀번호 변경</a></li>
		<li><a href="${contextPath}/member/confirmReserPage">예약내역</a></li>
	</ul>
			
	 <div class="container">
       <h3>예약 확인</h3>
			<table class="reser" border="1">
				<thead>
					<tr>
						<td>예약번호</td>
						<td>객실이름</td>
						<td>회원이름</td>
						<td>체크인날짜</td>
						<td>체크아웃날짜</td>
						<td>예약인원</td>
						<td>예약상태</td>
						<td>리뷰</td>
						<td></td> <!--  -->
					</tr>
				</thead>
				<tbody id="confirmReser">
					<c:forEach items="${reservations}" var="reservation"> <!--  -->
						<tr>
							<td>${reservation.reserNo}</td>
							<td>${reservation.roomNo}</td>
							<td>${loginMember.memberName}</td>
							<td>${reservation.reserCheckIn}</td>
							<td>${reservation.reserCheckOut}</td>
							<td>${reservation.reserPeople}</td>
							<td>
								<c:if test="${reservation.reserStatus ne 0}">
									예약 확정
								</c:if>
								<c:if test="${reservation.reserStatus eq 0}">
									예약 취소
								</c:if>
							</td>
							<td>
								<input type="button" value="리뷰" class="reviewBtn">
							</td>
							<td>
								<c:if test="${reservation.reserStatus ne 0}">
									<input type="button" value="예약취소" class="cancelBtn">
								</c:if>
								<c:if test="${reservation.reserStatus eq 0}">
									<input type="button" value="내역삭제" class="deleteBtn">
								</c:if>
							</td>
						</tr>
					</c:forEach> <!--  -->
				</tbody>
			</table>
    </div>


</body>
</html>