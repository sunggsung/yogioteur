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
	
	// 페이지 로드 이벤트
	$(document).ready(function(){
		fnTour();
	})
	
	// 함수
	function fnTour(){
		$.ajax({
			url: '${contextPath}/admin/tour',
			type: 'get',
			dataType: 'json',
			success: function(responseText){
				console.log(responseText);
				//var items = responseText.response.body.items.item;
				$('#items').empty();
				$.each(responseText, function(i, item){
					var tr = '<tr>';
					tr += '<td>' + item.tm + '</td>';
					tr += '<td>' + item.courseName + '</td>';
					tr += '<td>' + item.spotName + '</td>';
					tr += '<td>' + item.thema + '</td>';
					var sky;
					switch(item.sky){
					case 1: sky = '맑음'; break;
					case 2: sky = '구름조금'; break;
					case 3: sky = '구름많음'; break;
					case 4: sky = '흐림'; break;
					case 5: sky = '비'; break;
					case 6: sky = '비눈'; break;
					case 7: sky = '눈비'; break;
					case 8: sky = '눈'; break;
					default: sky = '모름';
					}
					tr += '<td>' + sky + '</td>';
					tr += '<td>' + item.th3 + '</td>';
					tr += '<td>' + item.rhm + '%</td>';
					tr += '<td>' + item.pop + '%</td>';
					$('#items').append(tr);
				})
			}
		})
	}
	
</script>
</head>
<body>
	
	<table border="1">
		<thead>
			<tr>
				<td>예보시각</td>
				<td>코스명</td>
				<td>관광지명</td>
				<td>테마</td>
				<td>날씨</td>
				<td>기온</td>
				<td>습도</td>
				<td>강수확률</td>
			</tr>
		</thead>
		<tbody id="items"></tbody>
	</table>

</body>
</html>