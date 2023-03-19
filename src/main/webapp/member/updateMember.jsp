<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../resources/css/member.css">

<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<%
	String sessionId = (String) session.getAttribute("sessionId");
%>
<sql:setDataSource var="dataSource"
		url="jdbc:mariadb://localhost:3308/teamproject_market"
		driver="org.mariadb.jdbc.Driver"
		user="root" password="2714"/>

<sql:query dataSource="${dataSource }" var="resultSet">
	SELECT * FROM MEMBER WHERE ID=?
	<sql:param value="<%=sessionId %>" />
</sql:query>
<meta charset="UTF-8">
	<title>회원 정보 수정</title>
</head>
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="../resources/js/searchAddress.js"></script>
<script type="text/javascript" src="../resources/js/memberValidation.js"></script>
    
<body onload="init()">
	<jsp:include page="../inc/header.jsp" />
	
	<c:forEach var="row" items="${resultSet.rows }">
		<c:set var="mail" value="${row.mail }" />
		<c:set var="mail1" value="${mail.split('@')[0] }" />
		<c:set var="mail2" value="${mail.split('@')[1] }" />
		
		<c:set var="birth" value="${row.birth }" />
		<c:set var="year" value="${birth.split('/')[0] }" />
		<c:set var="month" value="${birth.split('/')[1] }" />
		<c:set var="day" value="${birth.split('/')[2] }" />
		
		<c:set var="address" value="${row.address }" />
		<c:set var="zipcode" value="${address.split('/')[0] }" />
		<c:set var="address1" value="${address.split('/')[1] }" />
		<c:set var="address2" value="${address.split('/')[2] }" />
		
		<c:set var="phone" value="${row.phone }" />
		<c:set var="phone1" value="${phone.split('-')[0] }" />
		<c:set var="phone2" value="${phone.split('-')[1] }" />
		<c:set var="phone3" value="${phone.split('-')[2] }" />
		
	<h4>회원 수정</h4>
	<form class="formWrap" action="processUpdateMember.jsp"
		name="frmMemberInsert" method="post" onsubmit="return checkForm()">
		<div class="row mb-3">
			<label for="id" class="col-sm-3 col-form-label">아이디</label>
			<div class="col-sm-7 d-flex id">
				<input type="text" class="form-control" id="id" name="id" placeholder="id"
				value="<c:out value='${row.id }'/>" readonly > 
			</div>
		</div>
		
		<div class="row mb-3">
			<label for="password" class="col-sm-3 col-form-label">비밀번호</label>
			<div class="col-sm-5">
				<input type="password" class="form-control" id="password"
					name="password" placeholder="password" value="<c:out value='${row.password }'/>">
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
				placeholder="name" value="<c:out value='${row.name }'/>">
			</div>
		</div>
		
		<div class="row mb-3">
			<label for="birth" class="col-sm-3 col-form-label">생년월일</label>
			<div class="col-sm-7 birth">
				<input type="text" name="birthyy" class="form-control" maxlength="4" placeholder="년(4자)" size="6" value="${year }"> 
				<select name="birthmm" id="birthmm" class="form-control">
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
				</select> <input type="text" name="birthdd" class="form-control" maxlength="2" placeholder="일" size="4" value="${day }">
			</div>
		</div>

		<div class="row mb-3">
			<label class="col-sm-3 col-form-label">성별</label>
			<div class="col-sm-5">
				<c:set var="gender" value="${row.gender }" />
				<input name="gender" type="radio" value="남" <c:if test="${gender.equals('남') }"> <c:out value="checked" /> </c:if> >남 
				<input name="gender" type="radio" value="여" <c:if test="${gender.equals('여') }"> <c:out value="checked" /> </c:if> >여
			</div>
		</div>

		<div class="row mb-3">
			<label for="mail" class="col-sm-3 col-form-label">이메일</label>
			<div class="col-sm-7 d-flex">
				<input type="text" class="form-control" id="mail1" maxlength="50" name="mail1" value="${mail1 }">@
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
					<input name="zipcode" id="zipcode" readonly class="form-control" value="${zipcode }">
					<button type="button" class="btn btn-primary btn-sm"
						onclick="execDaumPostcode();">우편번호 검색</button>
				</div>
				<input name="address1" id="address1" class="form-control" size="40" value="${address1 }"
					maxlength="40" readonly> 
				<input name="address2" id="address2" class="form-control" size="40" maxlength="40"
					value="${address2 }">
			</div>
		</div>

		<div class="row mb-3">
			<label for="phone" class="col-sm-3 col-form-label">휴대폰 번호</label>
			<div class="col-sm-7 phone d-flex">
				<select class="form-select" aria-label="Default select example"
					name="phone1" value="${phone1 }">
					<option value="010">010</option>
					<option value="011">011</option>
					<option value="016">016</option>
					<option value="017">017</option>
					<option value="019">019</option>
				</select> 
				<input type="text" class="form-control" id="phone2" name="phone2" maxlength="4" size="4" value="${phone2 }">
				<input type="text" class="form-control" id="phone3" name="phone3" maxlength="4" size="4" value="${phone3 }">
			</div>
		</div>
		
		<div class="row mb-3">
			<label for="phoneC" class="col-sm-3 col-form-label">휴대폰 인증</label>
			<div class="col-sm-7 phoneC d-flex">
				<input type="text" class="form-control randomNum" id="phoneC" name="phoneC"
					placeholder="인증번호 입력">
				<button type="button" class="btn btn-primary btn-sm randomNumBtn">인증번호 받기</button>
			</div>
		</div>
		
		
		<script type="text/javascript">
			const randomNum = document.querySelector('.randomNum');
		    const randomNumBtn = document.querySelector('.randomNumBtn');
		    
		    randomNumBtn.addEventListener('click', function(){
		        console.log(Math.floor(Math.random() * 1000000));
		        randomNum.value = Math.floor(Math.random() * 1000000)
		    })
		</script>



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
			<button type="submit" class="btn btn-primary">수정하기</button>
		</div>

	</form>
	</c:forEach>
	
	<script type="text/javascript">
		function init(){
			setComboMailValue("${mail2}");
			setComboBirthValue("${month}");
		}
		
		function setComboMailValue(val){
			var selectMail = document.getElementById('mail2');
			for(i = 0, j = selectMail.length; i < j; i++){
				if(selectMail.options[i].value == val){
					selectMail.options[i].selected = true;
					break;
				}
			}
		}
		
		function setComboBirthValue(val){
			var selectBirth = document.getElementById('birthmm');
			for(i = 0, j = selectBirth.length; i < j; i++){
				if(selectBirth.options[i].value == val){
					selectBirth.options[i].selected = true;
					break;
				}
			}
		}
		/* 
		function checkForm() {
			if (!document.modiMember.password.value) {
				alert("비밀번호를 입력하세요.");
				return false;
			}
	
			if (document.modiMember.password.value != document.modiMember.password_confirm.value) {
				alert("비밀번호를 동일하게 입력하세요.");
				return false;
			}
		} */
	
	</script>
</body>
</html>