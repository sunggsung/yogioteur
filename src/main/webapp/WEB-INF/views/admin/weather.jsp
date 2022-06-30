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
		$.ajax({
			url: '${contextPath}/admin/weather',
			type: 'GET',
			dataType: 'json',
			success: function(responseText) {
				var items = responseText.response.body.items.item;
				$('#items').empty();
				$.each(items, function(i, item) {
					if(item.category == 'TMP') {
						var tr = '<tr>';
						tr += '<td>' + item.fcstDate + '</td>';
						tr += '<td>' + item.fcstTime + '</td>';
						tr += '<td>' + item.fcstValue + '</td>';
					} 
					if(item.category == 'SKY') {
						tr += '<td>' + item.fcstValue + '</td>';
						tr += '</tr>';
					}
					$('#items').append(tr);
				})
			}
		})
	})
	
</script>
</head>
<body>

	<table border="1">
		<thead>
			<tr>
				<td>예보날짜</td>
				<td>예보시간</td>
				<td>기온</td>
				<td>하늘상태</td>
				<td>강수확률</td>
			</tr>
		</thead>
		<tbody id="items">
		</tbody>	
	</table>

</body>
</html>