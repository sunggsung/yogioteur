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
		fnMemberDetail();
	})
	
	function fnMemberDetail() {
		$('.btnDetail').on('click', function() {
			location.href='${contextPath}/admin/memberDetail?memberNo=' + $(this).data('member_no');
		})
	}
	
</script>
<link rel="stylesheet" href="../resources/css/admin.css">
</head>
<body>
	
	<div class="container">
		<jsp:include page="index.jsp"></jsp:include>
		
		<div class="grid_item member">
			<h3>회원 목록</h3>
			<table class="table">
				<thead>
					<tr>
						<td>회원번호</td>
						<td>아이디</td>
						<td>이름</td>
						<td>이메일</td>
						<td>연락처</td>
						<td>가입일</td>
						<td>비고</td>
					</tr>
				</thead>
				<tbody id="members">
					<c:forEach items="${members}" var="member" varStatus="vs">
						<tr>
							<!-- <td>${beginNo - vs.index}</td> -->
							<td>${member.memberNo}</td>
							<td>${member.memberId}</td>
							<td>${member.memberName}</td>
							<td>${member.memberEmail}</td>
							<td>${member.memberPhone}</td>
							<td>${member.signIn}</td>
							<td><input type="button" value="상세보기" class="btnDetail" data-member_no="${member.memberNo}"></td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="7">${paging}</td>
					</tr>
				</tfoot>
			</table>
		</div>
		
	</div>

</body>
</html>