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
	body{
		margin: 0 auto;
		font-family: 'Kdam Thmor Pro', sans-serif;
	}
	.title {
		text-align: center;
	}
	#agreeForm {
		text-align: center;
	}
	.blind {
		display: none;
	}
	.items, .item{	
		padding-left: 20px;
		background-image: url("../resources/image/uncheck.png");
		background-size: 18px 18px;
		background-repeat: no-repeat;
	}
	.check{
		background-image: url("../resources/image/check.png");
	}
    .box > div {
     	color: #666;
        width: 500px;
        height: 100px;
        border: 1px solid black;
        overflow-y: scroll;
        font-size: 14px;
        margin-bottom: 24px;
        display: inline-block;;
      }


</style>
<script src="../resources/js/jquery-3.6.0.js"></script>
<script>

	$(function(){
		
		$('#checkAll').on('click', function(){
		
			$('.checkOne').prop('checked', $('#checkAll').prop('checked'));		
																				
			if($('#checkAll').is(':checked')){
				$('.item, .items').addClass('check');
			} else{
				$('.item, .items').removeClass('check');
			}
		})
		
		
		$('.checkOne').on('click', function(){
			let checkAll = true;							

			$.each($('.checkOne'), function(i, checkOne){
				if($(checkOne).is(':checked') == false){	
					$('#checkAll').prop('checked', false);
					$('.items').removeClass('check');
					checkAll = false;						
					return false;
				}
			})
			if(checkAll){								
				$('#checkAll').prop('checked', true);	
				$('.items').addClass('check');			
			}
		})
		
		
		$('.item, .items').on('click', function(){
			$(this).toggleClass('check');		
		})
		
		
		$('#agreeForm').on('submit', function(e){
			if($('#service').is(':checked') == false || $('#privacy').is(':checked') == false){
				alert('필수 약관에 모두 동의하세요.');
				e.preventDefault();
				return false;
			}
			return true;
		})
		
	})
	
</script>
</head>
<body>
	
	<div class="title"><h3>약관 동의하기</h3></div>
	
	
	<form id="agreeForm" action="${contextPath}/member/signInPage">
		<div class="box">
			<input type="checkbox" id="checkAll" class="blind checkAll">
			<label for="checkAll" class="items">
			모두 동의합니다.<br>
				<span>
				※아래 동의서를 각각 확인한 후 개별적으로 동의하실 수 있습니다.전체 동의 시 체크되는 동의 항목에는 선택동의 항목이 포함되어 있습니다.
				</span>
			</label>
		</div>
		
		<hr>
		
		<div class="box">
			<input type="checkbox" id="service" class="blind checkOne">
			<label for="service" class="item">이용약관에 동의합니다.(필수)</label><br>
			<div>
				다음 사항들은 YOGIOTEUR호텔의 특별한 서비스와 특전 및 어워드에 대한 내용에 관한 것입니다. 모든 조항은 YOGIOTEUR호텔의 고유 견해로 회원을 보호하고자 만들어졌으며, YOGIOTEUR호텔 또는 제휴사의 내부 사정 및 제휴 관계 변경 등에 따라 필요한 경우 본 프로그램 규정, 조건, 특전 또는 YOGIOTEUR호텔 리워즈와 관련된 어워드 등을 변경할 수 있습니다.
				<br><br>
				제1조 목적<br>
				본 약관은 YOGIOTEUR호텔에서 운영하는 이용에 관한 서비스 내용과 기본적인 운영 사항들을 규정하는데 목적이 있습니다.<br>
				<br>
				제2조 용어의정의<br>
				“YOGIOTEUR호텔 리워즈 회원”(이하 “회원”)이란 개인정보의 수집, 제공 활용에 동의하고, 정해진 가입 절차에 따라 가입한 고객입니다.<br>
				<br>
				제3조 회원가입 및 계정생성<br>
				1. 회원가입은 호텔 홈페이지 및 모바일 앱 그리고 호텔의 지정 영업장에서 가능합니다.<br>
				2. 멤버십 가입은 만 19세 이상의 개인회원을 대상으로 하며, 법인 또는 단체 등은 가입할 수 없습니다.<br>
				3. 회원은 하나의 멤버십 계정만 소유할 수 있습니다. 중복 가입 시 하나를 제외한 멤버십은 해지 처리됩니다.<br>
				4. 정보통신망 이용촉진 및 정보보호 등에 관한 법률 제29조 제2항의 개인정보 유효기간제에 따라 1년간 홈페이지 로그인 등 당사 서비스를 이용하지 않은 회원님의 개인정보는 분리 보관되며, 서비스 이용에 제한을 받을 수가 있습니다.<br>
				<br>
				제4조 회원 탈퇴 및 자격 상실<br>
				1. 회원은 호텔 홈페이지 및 모바일 앱, 서면 기타 호텔이 정한 방법을 통해 탈회를 요청할 수 있습니다.<br>
				2. 회원 탈회 시 보유한 계정 및 포인트, 혜택은 자동 소멸됩니다.<br>
				3. 회원 자격은 탈회시까지 유효하나, 다음과 같은 사유가 발생한 경우 호텔은 회원의 멤버십을 해지하거나 자격을 종료시킬 수 있습니다.<br>
				① 회원이 멤버십 특전, 포인트, 바우처 등을 제3자에게 양도 또는 판매하는 경우<br>
				② 회원 가입 시, 허위 내용 등록, 기재누락, 오기입이 있는 경우<br>
				③ 타회원의 서비스 이용을 방해하거나 그 정보를 도용하는 등 거래질서를 위협하는 경우<br>
				④ 회원이 호텔의 정상적인 운영을 방해하는 경우<br>
				⑤ 회원이 사망한 경우<br>
				⑥ 기타 부당한 행위를 하는 경우<br>
				4. 회원 자격 종료 시 보유한 계정 및 포인트, 회원 자격에 따른 혜택은 소멸되며 기타 특전 사용이 불가합니다.<br>
				<br>
				제5조 개정<br>
				1. 호텔은 호텔 및 제휴사의 사정에 따라 프로그램 구성, 특전 및 내용을 변경할 수 있으며, 본 멤버십 프로그램을 종료할 수 있습니다.<br>
				2. 호텔은 약관을 적용하고자 하는 날로부터 14일 이전에 약관이 개정된다는 사실과 개정된 내용 등을 홈페이지, 서면, 전자우편(E-mail), 문자메세지 중 1가지 이상의 방법으로 회원에게 안내합니다.<br>
				3. 회원은 변경된 약관에 동의하지 않을 수 있으며, 동의하지 않을 경우 회원 탈회를 할 수 있습니다. 단 호텔이 위 약관 변경 고지 후, 회원이 변경 약관 적용일까지 이의를 제기하지 않으면 약관 변경에 동의한 것으로 간주합니다.<br>
				4. 본 멤버십 프로그램을 종료할 경우 종료 최소 6개월전에 호텔 웹사이트에 공지하며, 전 회원을 대상으로 1회 이상 전자우편(E-mail)을 통한 안내문을 발송합니다.<br>
				5. 약관 개정 변경 및 종료에 관한 통지는 마케팅 수신 동의여부와 상관없이 모든 회원에게 고지가 되며, 회원 본인이 확인하지 않았거나, 회원이 정확한 정보를 제공하지 않음으로 인한 불이익에 대해서는 호텔에 그 책임이 없습니다.
				<br>
				제6조 해석 및 관할법원<br>
				1. 모든 프로그램에 관한 규칙 및 예외사항에 대해 해석은 관련 법령 및 상관례에 따라 합리적으로 해석합니다.<br>
				2. 본 프로그램의 약관이 회원 주거지역의 강행법규에 위배되는 부분이 있을 경우 해당 회원의 가입은 취소될 수 있습니다.<br>
				3. 본 약관은 국제관례를 참조하였으며 대한민국 법에 의거하여 구성되었습니다.<br>
				4. 본 약관과 관련하여 발생되는 일체의 분쟁은 서울중앙지방법원을 제1심 관할 법원으로 합니다.<br>
			</div>
		</div>

		<div class="box">
			<input type="checkbox" id="privacy" class="blind checkOne">
			<label for="privacy" class="item">개인정보 수집, 이용에 동의합니다.(필수)</label><br>
			<div>
				YOGIOTEUR호텔 회원가입과 관련하여 아래와 같이 개인정보를 수집 및 이용하는 것에 동의합니다.
				<br><br>
				개인정보 수집항목<br>
				- 필수사항 : 성명, 생년월일, 연락처(모바일 또는 자택), 이메일, 아이디, 비밀번호, YOGIOTEUR호텔(국내) 예약 및 투숙정보(투숙기간, 숙박료, 구매금액 포함), 포인트 적립 및 사용내역, 할인내역, IP/쿠키정보
				<br>
				개인정보 수집 및 이용 목적<br>
				- YOGIOTEUR호텔 회원제 서비스에 따른 본인확인 절차에 활용<br>
				- 할인 등 각종 멤버십 서비스 제공<br>
				- 고객공지, 불만처리를 위한 원활한 의사소통의 경로확보<br>
				- 부정이용 방지, 법적 분쟁 등의 처리<br>
				<br>
				개인정보 보유 및 이용 기간
				수집이용 동의일로부터 회원 탈회시 까지 보유됩니다.<br>
				동의를 거부할 권리가 있으나 및 동의를 거부할 경우 YOGIOTEUR호텔 회원가입 서비스 이용이 불가능 합니다.<br>
			</div>
		</div>
		
		<div class="box">
			<input type="checkbox" name="agreements" value="info" id="info" class="blind checkOne">
			<label for="info" class="item">개인정보 제3자 제공에 대한 동의(선택)</label><br>
			<div>
				1. 제공받는 자<br>
				YOGIOTEUR호텔 리조트㈜
				<br><br>
				2. 제공받는 자의 이용 목적<br>
				YOGIOTEUR호텔 서비스 제공
				<br><br>
				3. 제공하는 항목<br>
				성명, 생년월일, 이메일주소, 휴대폰번호, 구매 및 예약 내역, 투숙기간, 아이디, YOGIOTEUR호텔 번호
				<br><br>
				4. 제공받은 자의 보유•이용 기간 :
				회원 탈퇴 시까지<br>
			</div>
		</div>
		
		<div class="box">
			<input type="checkbox" name="agreements" value="event" id="event" class="blind checkOne">
			<label for="event" class="item">개인정보 마케팅 활용 동의(선택)</label><br>
			<div>
				1. 수집, 이용 항목<br>
				성명, 생년월일, 성별, 이메일주소, 휴대폰번호, 구매 및 예약 내역, 투숙기간, 아이디, YOGIOTEUR호텔 번호
				<br><br>
				2. 수집•이용 목적<br>
				YOGIOTEUR호텔㈜ 상품 및 서비스 소개(호텔, 면세점 등), YOGIOTEUR호텔㈜ 기타 제휴 호텔의 상품 및 서비스 소개, 사은•판촉행사 안내, 만족도 조사, 시장 조사
				<br><br>
				3. 보유•이용 기간<br>
				회원 탈퇴 시 까지 또는 마케팅 활용 동의 철회시 까지 중 빠른 시점<br>
				※위 사항에 대한 동의를 거부할 수 있으나, 이에 대한 동의가 없을 경우 개인형 맞춤 상품 안내 등 유용한 상품안내를 받아보실 수 없습니다.
			</div>
		</div>
		
		<input type="button" value="취소" onclick="history.back()">
		<input type="submit" value="다음">
			
	</form>
	
	<jsp:include page="../layout/footer.jsp"></jsp:include>

</body>
</html>