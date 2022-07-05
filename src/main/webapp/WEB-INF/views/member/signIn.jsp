<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

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
	.signIn {
		text-align: center;
	}
	.join_container {
		margin: 0 auto;
		width: 460px;
		box-sizing: border-box;
	}
	.title {
		margin: 19px 0 8px;
		font-size: 16px;
		font-weight: 800;
	}
	label {
		cursor: pointer;
	}
	. InputAreaWrapper {
		margin-bottom: 10px;
	}
	.InputArea {
		display: block;
		position: relative;
		margin: 0;
		width: 100%;
		height: 51px;
		border: solid 1px #dadada;
		padding: 10px 110px 10px 14px;
		box-sizing: border-box;
		vertical-align: top;
	}
	.InputArea_con {
		display: block;
		position: relative;
		width: 100%;
		height: 80px;
		border: solid 1px #dadada;
		padding: 10px 110px 10px 14px;
		box-sizing: border-box;
		vertical-align: top;
	}
	.box {
		border: 0 none;
		display: block;
		width: 100%;
		height: 30px;
		outline: none;
	}
	.boxes {
		height: 20px;
		width: 60%;
		border: solid 1px #dadada;
		outline: none;
	}
	.BtnArea {
		text-align: center;
		display: block;
		line-height: 30px;
		margin: 20px 0;
	}
</style>
<script src="../resources/js/jquery-3.6.0.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$(function(){
		fnSignIn();
		fnIdCheck();
		fnPwCheck();
		fnPwConfirm();
		fnEmailAuth();
		fnPhoneCheck();
		fnBirthCheck();
	})
	// 가입
	function fnSignIn(){
		$('#SignInform').on('submit', function(event){
			if(idPass == false){
				alert('아이디를 확인하세요.');
				event.preventDefault();
				return false;
			}
			else if(pwPass == false || rePwPass == false){
				alert('비밀번호를 확인하세요.');
				event.preventDefault();
				return false;
			}
			else if(authCodePass == false){
				alert('이메일 인증을 받아야 합니다.');
				event.preventDefault();
				return false;
			}
			else if(phonePass == false){
				alert('전화번호를 확인하세요.');
				event.preventDefault();
				return false;
			}
			else if(birthPass == false){
				alert('생년월일을 확인하세요.');
				event.preventDefault();
				return false;
			}
			return true;
		})
	}
	
	// 생년월일 정규식
	let birthPass = false;
	function fnBirthCheck(){
		$('#memberBirth').on('keyup', function(){
			let regBirth = /^\d{6}$/;
			if(regBirth.test($('#memberBirth').val())==false){
				$('#memberBirthMsg').text('생년월일은 주민번호 앞자리만 입력해주세요.').addClass('dont').removeClass('ok');
				birthPass = false;
			} else {
				$('#memberBirthMsg').text('');
				birthPass = true;
			}
		})
	}
	
	
	// 연락처 정규식
	let phonePass = false;
	function fnPhoneCheck(){
		$('#memberPhone').on('keyup', function(){
			let regPhone = /^[0-9]{11}$/;
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
		return new Promise(function(resolve, reject) {
			// 정규식 
			let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+(\.[a-zA-Z]{2,}){1,2}$/; 
			if(regEmail.test($('#memberEmail').val())==false){
				reject(1000);      
				return;
			}
			// 중복 
			$.ajax({
				url: '${contextPath}/member/emailCheck',
				type: 'get',
				data: 'memberEmail=' + $('#memberEmail').val(),
				dataType: 'json',
				success: function(obj){
					if(obj.res == null){
						resolve();     
					} else {
						reject(2000); 
					}
				}
			})
		});
	}
	
	// 이메일 인증
	let authCodePass = false;
	function fnVerifyAuthCode(authCode){  
		$('#btnVerifyAuthCode').on('click', function(){
			if($('#authCode').val() == authCode){
				alert('인증되었습니다.');
				authCodePass = true;
			} else {
				alert('인증에 실패했습니다.');
				authCodePass = false;
			}
		})
	}
	
	// 이메일 인증발송
	function fnEmailAuth(){
		$('#btnGetAuthCode').on('click', function(){
			fnEmailCheck().then(
				function(){
					$.ajax({
						url: '${contextPath}/member/sendAuthCode',
						type: 'get',
						data: 'memberEmail=' + $('#memberEmail').val(),
						dataType: 'json',
						success: function(obj){  
							$('#memberEmailMsg').text('사용 가능한 이메일입니다.').addClass('ok').removeClass('dont');;
							alert('인증코드를 발송했습니다. 이메일을 확인해주세요.');
							fnVerifyAuthCode(obj.authCode);  
						},
						error: function(jqXHR){
							alert('인증코드 발송이 실패했습니다.');
						}
					})
				}
			).catch(
				function(code){
					if(code == 1000){
						$('#memberEmailMsg').text('이메일 형식이 올바르지 않습니다.').addClass('dont').removeClass('ok');
						$('#authCode').prop('readonly', true);
					} else if(code == 2000){
						$('#memberEmailMsg').text('이미 사용 중인 이메일입니다.').addClass('dont').removeClass('ok');
						$('#authCode').prop('readonly', true);
					}
				}
			)
		})
	}
	
	// 비밀번호 재확인
	let rePwPass = false;
	function fnPwConfirm(){
		$('#memberPwConfirm').on('keyup', function(){
			if($('#memberPwConfirm').val() != '' && $('#memberPw').val() != $('#memberPwConfirm').val()){
				$('#memberPwConfirmMsg').text('비밀번호를 확인해주세요.').addClass('dont').removeClass('ok');
				rePwPass = false;
			} else {
				$('#memberPwConfirmMsg').text('');
				rePwPass = true;
			}
		})
	}
	
	
	// 비밀번호 정규식
	let pwPass = false;
	function fnPwCheck(){
		$('#memberPw').on('keyup', function(){
			let regPw = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,12}$/; 
			if(regPw.test($('#memberPw').val())==false){
				$('#memberPwMsg').text('8~12자 영문 소문자, 숫자, 특수문자 모두포함으로만 가능합니다.').addClass('dont').removeClass('ok');
				pwPass = false;
			} else {
				$('#memberPwMsg').text('사용 가능한 비밀번호입니다.').addClass('ok').removeClass('dont');
				pwPass = true;
			}
		})
	}
	
	
	// 아이디(중복&정규식)
	let idPass = false;
	function fnIdCheck(){
		$('#memberId').on('keyup', function(){
			// 정규식 
			let regId = /^(?=.*[0-9]+)[a-zA-Z][a-zA-Z0-9]{5,11}$/; 
			if(regId.test($('#memberId').val())==false){
				$('#memberIdMsg').text('6~12자리 영문,숫자만 사용가능합니다.').addClass('dont').removeClass('ok');
				idPass = false;
				return;
			}
			// 아이디 중복 체크
			$.ajax({
				url: '${contextPath}/member/idCheck',
				type: 'get',
				data: 'memberId=' + $('#memberId').val(),
				dataType: 'json',
				success: function(obj){
					if(obj.res == null){
						$('#memberIdMsg').text('사용 가능한 아이디입니다.').addClass('ok').removeClass('dont');
						idPass = true;
					} else {
						$('#memberIdMsg').text('이미 사용중이거나 탈퇴한 아이디입니다.').addClass('dont').removeClass('ok');
						idPass = false;
					}
				},
				error: function(jqXHR){
					$('#memberIdMsg').text(jqXHR.responseText).addClass('dont').removeClass('ok');
					idPass = false;
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
</script>
</head>
<body>
	
	
	<h2 class="signIn" >회원가입</h2>
	<hr>
	
	<div class="join_container">
		<form id="SignInform" action="${contextPath}/member/signIn" method="post">
		
			<input type="hidden" name="info" value="${agreements[0]}">
			<input type="hidden" name="event" value="${agreements[1]}">
			<div class="group">
				<div class="InputAreaWapper">
					<h4 class="title">
						<label for="memberId">아이디</label>
					</h4>
						<div class="InputArea">
							<input type="text" name="memberId" id="memberId" class="box" placeholder="6~12자 영문,숫자">
						</div>
						<span id="memberIdMsg"></span>
				</div>
				
				<div class="InputAreaWapper">
					<h4 class="title">
						<label for="memberPw">비밀번호</label>
					</h4>
						<div class="InputArea">
							<input type="password" name="memberPw" id="memberPw" class="box" placeholder="8~12자 영문 소문자, 숫자, 특수문자">
						</div>
						<span id="memberPwMsg"></span>
				</div>
				
				<div class="InputAreaWapper">
					<h4 class="title">
						<label for="memberPwConfirm">비밀번호 재확인</label>
					</h4>
						<div class="InputArea">
							<input type="password" id="memberPwConfirm" class="box" placeholder="8~12자 영문 소문자, 숫자, 특수문자">
						</div>
						<span id="memberPwConfirmMsg"></span>
				</div>
				
				<div class="InputAreaWapper">
					<h4 class="title">
						<label for="memberName">이름</label>
					</h4>
						<div class="InputArea">
							<input type="text" name="memberName" id="memberName" class="box" placeholder="이름">
						</div>
				</div>
				
				<div class="InputAreaWapper">
					<h4 class="title">
						<label for="memberPhone">연락처</label>
					</h4>	
						<div class="InputArea">
							<input type="text" name="memberPhone" id="memberPhone" class="box" placeholder="하이픈(-)을 제외한 숫자만 입력" maxlength="11">
						</div>
						<span id="memberPhoneMsg"></span>
				</div>
				
				<div class="InputAreaWapper">
					<h4 class="title">
						<label for="memberBirth">생년월일</label>
					</h4>	
						<div class="InputArea">
							<input type="text" name="memberBirth" id="memberBirth" class="box" placeholder="생년월일(6자)" maxlength="6">
						</div>
						<span id="memberBirthMsg"></span>
				</div>
				
				<div class="InputAreaWapper">
					<h4 class="title">
						<label for="memberGender">성별</label>
					</h4>	
						<div class="InputArea">
							<input type="radio" name="memberGender" id="male" value="male">
							<label for="male" >Male</label>
							<input type="radio" name="memberGender" id="female" value="female">
							<label for="female" >Female</label>
						</div>
				</div>
				
				<div class="InputAreaWapper">
					<h4 class="title">
						주소
					</h4>	
						<div class="InputArea_con">
							<input type="text" name="memberPostCode" id="memberPostcode" class="boxes" placeholder="우편번호">
							<input type="button" onclick="fnPostcode()" value="우편번호 찾기">
							<input type="text" name="memberRoadAddr" id="memberRoadAddress" class="boxes"  placeholder="도로명주소">
						</div>
				</div>
				
				<div class="InputAreaWapper_con">
					<h4 class="title">
						<label for="memberEmail">이메일</label>
					</h4>	
						<div class="InputArea">
							<input type="text" name="memberEmail" id="memberEmail" class="boxes" placeholder="이메일">
							<input type="button" id="btnGetAuthCode" value="인증번호받기">
						</div>
							<span id="memberEmailMsg"></span><br>
						<div class="InputArea">
							<input type="text" name="authCode" id="authCode" class="boxes" placeholder="인증코드를 입력하세요">
							<input type="button" value="인증하기" id="btnVerifyAuthCode">
						</div>
				</div>
				
				<div class="InputAreaWapper">
					<h4 class="title">
						<label for="memberPromoAdd">이메일 수신여부</label>
					</h4>	
						<div class="InputArea">
							<input type="radio" name="memberPromoAdd" id="agree_yes" value="yes">
							<label for="agree_yes">동의함</label>
							<input type="radio" name="memberPromoAdd" id="agree_no" value="no">
							<label for="agree_no">동의안함</label>
						</div>
				</div>
			</div>
			
			<div class="BtnArea">
				<input type="button" value="취소" onclick="location.href='${contextPath}/'"> 
				<button>확인</button>
			</div>
		</form>
	</div>

	<jsp:include page="../layout/footer.jsp"></jsp:include>

</body>
</html>