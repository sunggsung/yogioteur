<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.ok {
		color: blue;
	}
	.dont {
		color: red;
	} 
	ul li a {
		color: gray;
	}
</style>
<script src="../resources/js/jquery-3.6.0.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$(document).ready(function(){
		fnModify();
		fnEmailCheck();
		fnPhoneCheck();
		fnPwCheck();
		fnPwConfirm();
		
		popupOpen();
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
			var popOption = "width=640, height=360, top=50, left=310, resizable=no, scrollbars=no, status=no;"; //팝업창 옵션(optoin)	
			window.open(popUrl,"",popOption);	
			})
		}

	
	function fnModify(){
		$('#modifyForm').on('submit', function(event){
			 if(phonePass == false){
				alert('연락처를 확인하세요.');
				event.preventDefault();
				return false;
			} 
			else if($('#memberEmail').val() == ''){
				alert('이메일을 확인하세요.');
				event.preventDefault();
				return false;
			}
			else if($('#memberPostCode').val() == ''){
				alert('우편번호를 확인하세요.');
				event.preventDefault();
				return false;
			}
			else if($('#memberRoadAddress').val() == ''){
				alert('주소를 확인하세요.');
				event.preventDefault();
				return false;
			}
			return true;
		})
		$('#modifyPwForm').on('submit', function(event){
			if(pwPass == false || rePwPass == false){
				alert('비밀번호를 확인하세요.');
				event.preventDefault();
				return false;
			}
			return true;
		})
	}
	
	let phonePass = false;
	function fnPhoneCheck(){
		$('#memberPhone').on('keyup', function(){
			let regPhone = /^[0-9]{1,11}$/;
			if(regPhone.test($('#memberPhone').val())==false){
				$('#memberPhoneMsg').text('전화번호는 -없이 숫자로만 입력해주세요.').addClass('dont').removeClass('ok');
				phonePass = false;
			} else {
				$('#memberPhoneMsg').text('');
				phonePass = true;
			}
		})
	}
	
	// 이메일 확인
	function fnEmailCheck(){
		// 정규식 
		let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+(\.[a-zA-Z]{2,}){1,2}$/; 
		if(regEmail.test($('#memberEmail').val())==false){
			$('#memberEmailMsg').text('이메일 형식이 올바르지 않습니다.').addClass('dont').removeClass('ok');     
			return;
		}
		$('#btnConfirmEmail').on('click', function(){
			$.ajax({
				url: '${contextPath}/member/emailCheck',
				type: 'get',
				data: 'memberEmail=' + $('#memberEmail').val(),
				dataType: 'json',
				success: function(obj){
					if(obj.res == null){
						$('#memberEmailMsg').text('사용가능한 이메일입니다.').addClass('ok').removeClass('dont');    
					} else {
						$('#memberEmailMsg').text('이미 사용 중인 이메일입니다.').addClass('dont').removeClass('ok');
					}
				}
			})
		})
	}

	
	function fnPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var roadAddr = data.roadAddress; 
	                $('#memberPostcode').val(data.zonecode);
	                $('#memberRoadAddress').val(roadAddr);
            }
        }).open();
    }
	
	let pwPass = false;
	function fnPwCheck(){
		$('#memberPw').on('keyup', function(){
			let regPw = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,12}$/; 
			if(regPw.test($('#memberPw').val())==false){
				$('#pwMsg').text('영문 소문자, 숫자, 특수문자 포함 8~12자로 입력해주세요.').addClass('dont').removeClass('ok');
				pwPass = false;
			} else {
				$('#pwMsg').text('사용 가능한 비밀번호입니다.').addClass('ok').removeClass('dont');
				pwPass = true;
			}
		})
	}
	

	let rePwPass = false;
	function fnPwConfirm(){
		$('#memberRePw').on('keyup', function(){
			if($('#memberRePw').val() != '' && $('#memberPw').val() != $('#memberRePw').val()){
				$('#rePwMsg').text('비밀번호를 확인하세요.').addClass('dont').removeClass('ok');
				rePwPass = false;
			} else {
				$('#rePwMsg').text('');
				rePwPass = true;
			}
		})
	}
	
</script>
</head>
<body>
	
	<jsp:include page="../layout/header.jsp"></jsp:include>

	<ul>
		<li><a href="${contextPath}/member/memberInfo">내정보</a></li>
		<li><a href="${contextPath}/member/modifyPwPage">비밀번호 변경</a></li>
		<li><a href="${contextPath}/member/confoirmReserPage">예약내역</a></li>
		<li><a href="${contextPath}/member/confirmFaqPage">문의내역</a></li>
	</ul>
	
	<br>
    <div class="container">
       <form id="modifyForm" action="${contextPath}/member/modifyMember" method="post">
       		<h3>내정보</h3>
            	아이디<input type="text" name="memberId" id="memberId" value="${loginMember.memberId}" readonly="readonly"><br>
            	이름<input type="text" name="memberName" id="memberName" value="${loginMember.memberName}" readonly="readonly"><br>
				생년월일
				<input type="text" name="memberBirth" id="memberBirth" value="${loginMember.memberBirth}" readonly="readonly"><br>
            	연락처
            	<input type="text" name="memberPhone" id="memberPhone" value="${loginMember.memberPhone}" maxlength="11"><br>
				<span id="memberPhoneMsg"></span>
				주소<br>
				<input type="text" id="memberPostcode" name="memberPostCode" value="${loginMember.memberPostCode}">
				<input type="button" onclick="fnPostcode()" value="우편번호 찾기"><br>
				<input type="text" id="memberRoadAddress" name="memberRoadAddr" value="${loginMember.memberRoadAddr}"><br>
				성별
				<label>남
					<input type="radio" name="memberGender" value="male" <c:if test="${loginMember.memberGender eq 'male'}">checked="checked"</c:if>/>
				</label>
				<label>여
				<input type="radio" name="memberGender" value="female" <c:if test="${loginMember.memberGender eq 'female'}">checked="checked"</c:if>/>
				</label>
				<br>
				이메일<br>
				<input type="text" name="memberEmail" id="memberEmail" value="${loginMember.memberEmail}" >
				<input type="button" value="중복확인" id="btnConfirmEmail"><br>
				<span id="memberEmailMsg"></span>
				<input type="hidden" name="memberId" value="${loaginMember.memberId}"><br>
				이메일 수신여부
				<label>동의함
					<input type="radio" name="memberPromoAdd" value="yes" <c:if test="${loginMember.memberPromoAdd eq 'yes'}">checked="checked"</c:if>/>
				</label>
				<label>동의안함
					<input type="radio" name="memberPromoAdd" value="no" <c:if test="${loginMember.memberPromoAdd eq 'no'}">checked="checked"</c:if>/>
				</label>
           		<br>
				<button>수정</button>
				<input type="button" value="회원탈퇴" onclick="location.href='${contextPath}/member/signOut?memberId=${loginMember.memberId}'">
            </form>
    </div>
    
    <hr>
    
    <div class="container">
    	<h3>비밀번호 변경</h3>
        <p>주기적인 비밀번호 변경을 통해 개인정보를 안전하게 보호하세요.</p>
			<form id="modifyPwForm" action="${contextPath}/member/modifyPw" method="post">
				<input type="password" name="memberPw" id="memberPw" placeholder="새 비밀번호"><br>
				<span id="pwMsg"></span><br>
				<input type="password" id="memberRePw" placeholder="새 비밀번호 확인"><br>
				<span id="rePwMsg"></span><br>
				<input type="hidden" name="memberId" value="${loginMember.memberId}">
				<button>변경</button>
				<input type="button" value="취소" onclick="location.href='${contextPath}/'">
			</form>
    </div>
    
    <hr>
    
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
						<td>예약취소</td> <!--  -->
					</tr>
				</thead>
				<tbody id="confirmReser">
					<c:forEach items="${reservations}" var="reservation"> <!--  -->
						<tr>
							<td id="cancelPopUp">${reservation.reserNo}</td>
							<td>${reservation.roomNo}</td>
							<td>${loginMember.memberName}</td>
							<td>${reservation.reserCheckin}</td>
							<td>${reservation.reserCheckout}</td>
							<td>${reservation.reserPeople}</td>
							<td>예약상태</td>
							<td><input type="button" value="예약취소" class="cancelBtn"></td>
						</tr>
					</c:forEach> <!--  -->
				</tbody>
			</table>
    </div>

	<hr>
	
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