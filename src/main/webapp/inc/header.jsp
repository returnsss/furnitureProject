<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<link rel="stylesheet" href="../resources/css/header.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<%
	String sessionId = (String) session.getAttribute("sessionId");
%>

<div class="container">
	<header class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-between py-3 mb-1 border-bottom">
		<a href="#" class="d-flex align-items-center mb-2 mb-md-0 text-dark text-decoration-none">
			<img width="120" height="120" role="img" src="../resources/images/logo3.png"></img>
		</a>

		<ul class="nav my-2 justify-content-center my-md-0 text-small">
			<li><a href="#" class="nav-link text-black"> Home </a></li>
			<li><a href="#" class="nav-link text-muted"> 제품 </a></li>
			<li><a href="#" class="nav-link text-muted"> 장바구니 </a></li>
			<li><a href="#" class="nav-link text-muted"> 주문 </a></li>
			<li><a href="#" class="nav-link text-muted"> 게시판 </a></li>
			<li><a href="#" class="nav-link text-muted"> 내정보 </a></li>
		</ul>

		
		<c:choose>
   			<c:when test="${empty sessionId }">
   				<div>
	   				<a class="btn btn-outline-primary" href="<c:url value="/LoginPage.lo" />">로그인</a>
	   				<a class="btn btn-primary" href="<c:url value="/AddMemberPage.lo" />">회원가입</a>
   				</div>
   			</c:when>
   			<c:otherwise>
   				<div>
	   				[<%=sessionId %>님]
	   				<a class="btn btn-outline-primary" href="<c:url value="/Logout.lo" />">로그아웃</a>
	   				<a class="btn btn-primary" href="<c:url value="/UpdateMemberPage.lo" />">회원 수정</a>
   				</div>
   			</c:otherwise>
   		</c:choose>
	</header>
</div>