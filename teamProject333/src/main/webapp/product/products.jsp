<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
	<%@ page import="java.util.*"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">

<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}

.b-example-divider {
	height: 3rem;
	background-color: rgba(0, 0, 0, .1);
	border: solid rgba(0, 0, 0, .15);
	border-width: 1px 0;
	box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em
		rgba(0, 0, 0, .15);
}

.b-example-vr {
	flex-shrink: 0;
	width: 1.5rem;
	height: 100vh;
}

.bi {
	vertical-align: -.125em;
	fill: currentColor;
}

.nav-scroller {
	position: relative;
	z-index: 2;
	height: 2.75rem;
	overflow-y: hidden;
}

.nav-scroller .nav {
	display: flex;
	flex-wrap: nowrap;
	padding-bottom: 1rem;
	margin-top: -1px;
	overflow-x: auto;
	text-align: center;
	white-space: nowrap;
	-webkit-overflow-scrolling: touch;
}
</style>

</head>
<body>
	<main>
<%--		<jsp:include page="../inc/header.jsp" />--%>


		<div class="album py-5 my-5">
		
		<h2 class="text-center">- 제품 목록 -</h2>

			<div class="container">

				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3">
								<%-- 제품 목록 출력 --%>
		<%@ include file="../inc/dbconn.jsp"%>
		<%
		String sql = "select * from products";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		while (rs.next()) {
		%>
					<div class="col my-5">
						<div class="card shadow-sm" style="height: 500px;">
							<img
								src="${pageContext.request.contextPath}/resources/images/<%=rs.getString("fileName")%>"
								style="height: 300px;width: 100%" alt="">


							<div class="card-body">
								<h2><%=rs.getString("productName")%></h2>
								<p class="card-text"><%=rs.getString("description")%></p>
								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
									<a href="./product.jsp?productId=<%=rs.getString("productId")%>" class="btn btn-sm btn-outline-secondary" role="button">
				View &raquo;</a>
										<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
									</div>
									<small class="text-muted"><%=rs.getString("regist_day")%></small>
								</div>
							</div>
						</div>
					</div>
					<%
					}
					%>

				</div>

			</div>
						<div align="center">		
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center mt-5">
					<li class="page-item disabled"><a class="page-link">Previous</a>
					</li>
					<li class="page-item"><a class="page-link" href="#">1</a></li>
					<li class="page-item"><a class="page-link" href="#">2</a></li>
					<li class="page-item"><a class="page-link" href="#">3</a></li>
					<li class="page-item"><a class="page-link" href="#">Next</a></li>
				</ul>
			</nav>
		</div>



	</main>
<%--	<jsp:include page="../inc/footer.jsp" />--%>
</body>
</html>