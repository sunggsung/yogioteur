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
</head>
<body>
		
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="content">
		<h3>문의내역 확인</h3>
			<table class="fag" border="1">
				<thead>
					<tr>
						<td>게시글번호</td>
						<td>제목</td>
						<td>작성일</td>
					</tr>
				</thead>
				<tbody id="confirmFaq">
						<tr>
							<td>${faq.faqNo}</td>
							<td>${faq.faqTitle}</td>
							<td>${faq.faqCreated}</td>
						</tr>
				</tbody>
			</table>
		</div>

</body>
</html>