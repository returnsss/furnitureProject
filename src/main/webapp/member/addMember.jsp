<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">

<style>
.formWrap {
	max-width: 680px;
	padding: 40px 60px 60px 100px;
	margin: 25px auto;
	background: #fff;
	-moz-border-radius: 10px;
	border-radius: 10px;
	box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
}

h4 {
	text-align: center;
	padding-top: 300px;
}

.birth {
	display: flex;
}

.birth p {
	margin-right: 10px;
}

/* .phone, .phoneC, .zipcode {
    	display: flex;
    }*/
.phone select {
	margin-right: 10px;
}

.phone input {
	margin-right: 10px;
}

.phoneC button {
	margin-left: 10px;
	width: 230px;
}

.zipcode button {
	cursor: pointer;
	width: 200px;
	height: 35px;
	margin-left: 10px;
}

.zipcodeWrap input {
	margin-bottom: 7px;
}

.id button {
	width: 235px;
	margin-left: 10px;
}
</style>
</head>

<body>
	<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
	<script>
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var fullAddr = ''; // 최종 주소 변수
                    var extraAddr = ''; // 조합형 주소 변수

                    // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        fullAddr = data.roadAddress;
                    }
                    else { // 사용자가 지번 주소를 선택했을 경우(J)
                        fullAddr = data.jibunAddress;
                    }

                    // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                    if(data.userSelectedType === 'R'){
                        //법정동명이 있을 경우 추가한다.
                        if(data.bname !== ''){
                            extraAddr += data.bname;
                        }
                        // 건물명이 있을 경우 추가한다.
                        if(data.buildingName !== ''){
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                        fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
                    document.getElementById('address1').value = fullAddr;

                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById('address2').focus();
                }
            }).open();
        }
    </script>
    <script type="text/javascript">
		function checkForm() {
			if (!document.newMember.id.value) {
				alert("아이디를 입력하세요.");
				return false;
			}
	
			if (!document.newMember.password.value) {
				alert("비밀번호를 입력하세요.");
				return false;
			}
	
			if (document.newMember.password.value != document.newMember.password_confirm.value) {
				alert("비밀번호를 동일하게 입력하세요.");
				return false;
			}
		}
	</script>
	<jsp:include page="../inc/header.jsp" />
	<h4>회원가입</h4>
	<form class="formWrap" action="processAddMember.jsp"
		name="frmMemberInsert" method="post" onsubmit="return checkForm()">
		<div class="row mb-3">
			<label for="id" class="col-sm-3 col-form-label">아이디</label>
			<div class="col-sm-7 d-flex id">
				<input type="text" class="form-control" id="id" name="id" placeholder="id"> 
				<span class="idCheck"></span>
				<input type="button" class="btn btn-primary btn-sm" name="btnIsDuplication" value="아이디 중복 확인">
			</div>
		</div>
		
		<div class="row mb-3">
			<label for="password" class="col-sm-3 col-form-label">비밀번호</label>
			<div class="col-sm-5">
				<input type="password" class="form-control" id="password"
					name="password" placeholder="password">
			</div>
		</div>
		
		<div class="row mb-3">
			<label for="password_confirm" class="col-sm-3 col-form-label">비밀번호 확인</label>
			<div class="col-sm-5">
				<input type="password" class="form-control" id="passwordC"
					name="password_confirm" placeholder="password confirm">
			</div>
		</div>
		
		<div class="row mb-3">
			<label for="name" class="col-sm-3 col-form-label">이름</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="name" name="name"
				placeholder="name">
			</div>
		</div>
		
		<div class="row mb-3">
			<label for="birth" class="col-sm-3 col-form-label">생년월일</label>
			<div class="col-sm-7 birth">
				<input type="text" name="birthyy" class="form-control" maxlength="4" placeholder="년(4자)" size="6"> 
				<select name="birthmm" class="form-control">
					<option value="">월</option>
					<option value="01">1</option>
					<option value="02">2</option>
					<option value="03">3</option>
					<option value="04">4</option>
					<option value="05">5</option>
					<option value="06">6</option>
					<option value="07">7</option>
					<option value="08">8</option>
					<option value="09">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
				</select> <input type="text" name="birthdd" class="form-control" maxlength="2" placeholder="일" size="4">
			</div>
		</div>

		<div class="row mb-3">
			<label class="col-sm-3 col-form-label">성별</label>
			<div class="col-sm-5">
				<input name="gender" type="radio" value="남" checked /> 남 
				<input name="gender" type="radio" value="여" /> 여
			</div>
		</div>

		<div class="row mb-3">
			<label for="mail" class="col-sm-3 col-form-label">이메일</label>
			<div class="col-sm-7 d-flex">
				<input type="text" class="form-control" id="mail1" maxlength="50" name="mail1" placeholder="email">@
				<select name="mail2" id="mail2" class="form-control">
					<option>naver.com</option>
					<option>daum.net</option>
					<option>gmail.com</option>
					<option>nate.com</option>
				</select>
			</div>
		</div>
		
		
		<div class="row mb-3">
			<label for="name" class="col-sm-3 col-form-label">주소</label>
			<div class="col-sm-7 zipcodeWrap">
				<div class="zipcode d-flex">
					<input name="zipcode" id="zipcode" readonly class="form-control">
					<button type="button" class="btn btn-primary btn-sm"
						onclick="execDaumPostcode();">우편번호 검색</button>
				</div>
				<input name="address1" id="address1" class="form-control" size="40"
					maxlength="40" readonly> 
				<input name="address2" id="address2" class="form-control" size="40" maxlength="40">
			</div>
		</div>

		<div class="row mb-3">
			<label for="phone" class="col-sm-3 col-form-label">휴대폰 번호</label>
			<div class="col-sm-7 phone d-flex">
				<select class="form-select" aria-label="Default select example"
					name="phone1">
					<option value="010">010</option>
					<option value="011">011</option>
					<option value="016">016</option>
					<option value="017">017</option>
					<option value="019">019</option>
				</select> 
				<input type="text" class="form-control" id="phone2" name="phone2" maxlength="4" size="4">
				<input type="text" class="form-control" id="phone3" name="phone3" maxlength="4" size="4">
			</div>
		</div>
		
		<div class="row mb-3">
			<label for="phoneC" class="col-sm-3 col-form-label">휴대폰 인증</label>
			<div class="col-sm-7 phoneC d-flex">
				<input type="text" class="form-control" id="phoneC" name="phoneC"
					placeholder="인증번호 입력">
				<button type="button" class="btn btn-primary btn-sm">인증번호 받기</button>
			</div>
		</div>



		<br>

		<div class="row mb-3">
			<label for="interest" class="col-sm-3 col-form-label">동의 여부</label>
			<div class="col-sm-8">

				<div class="row mb-3">
					<div class="col-form-label col-sm-5 pt-0 text-center">
						메일 수신 여부
					</div>
					<div class="col-sm-5">
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="mailYN"
								id="mailY" value="yes" checked> 
							<label class="form-check-label" for="mailY"> 동의 </label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="mailYN"
								id="mailN" value="no"> 
							<label class="form-check-label" for="mailN"> 동의 안함 </label>
						</div>
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-form-label col-sm-5 pt-0 text-center">
						문자 수신 여부
					</div>
					<div class="col-sm-5">
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="smsYN"
								id="smsY" value="yes" checked> 
							<label class="form-check-label" for="smsY"> 동의 </label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="smsYN"
								id="smsN" value="no"> 
								<label class="form-check-label" for="mailN"> 동의 안함 </label>
						</div>
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-form-label col-sm-5 pt-0 text-center">약관동의</div>
					<div class="col-sm-5">
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="termsYN"
								id="termsY" value="yes" checked> <label
								class="form-check-label" for="termsY"> 동의 </label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="termsYN"
								id="termsN" value="no"> <label
								class="form-check-label" for="termsN"> 동의 안함 </label>
						</div>
					</div>
				</div>

			</div>
		</div>
		<div class="text-center">
			<button type="reset" class="btn btn-primary">취소하기</button>
			<button type="submit" class="btn btn-primary">가입하기</button>
		</div>

	</form>
	<script>
		document.addEventListener("DOMContentLoaded", function(){
			// const inputID = document.querySelector('input[name=id]');
			const frmMemberInsert = document.frmMemberInsert; // 폼을 들고옴.
			
			// 1. 팝업을 이용한 ID 중복 확인
			// 팝업을 띄우는 이유는, 현재 페이지에서 데이터베이스에 중복 조회를 할려면 페이지 새로고침 이외에는 방법이 없음.
			const btnIsDuplication = document.querySelector('input[name=btnIsDuplication]');
			btnIsDuplication.addEventListener('click', function(){
				const id = frmMemberInsert.id.value; // 아이디 input에 있는 값.
				if(id === ""){
					alert('아이디를 입력해 주세요.');
					frmMemberInsert.id.focus();
					return;
				}
				// 아이디 중복 확인을 위해 팝업을 띄움.
				window.open('popupIdCheck.jsp?id=' + id, 'IdCheck', 'width = 500, height = 500, top = 100, left = 200, location = no');
			});
		});
	</script>
</body>
</html>