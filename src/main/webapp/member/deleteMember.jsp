<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%
	String sessionId = (String) session.getAttribute("sessionId");
%>
<sql:setDataSource var="dataSource"
		url="jdbc:mariadb://localhost:3308/teamproject_market"
		driver="org.mariadb.jdbc.Driver"
		user="root" password="2714"/>

<sql:update dataSource="${dataSource }" var="resultSet">
	DELETE FROM member WHERE id = ?
	<sql:param value="<%=sessionId %>" />
</sql:update>

<c:if test="${resultSet >= 1 }">
	<c:import var="url" url="logoutMember.jsp" />
	<c:redirect url="resultMember.jsp" />
</c:if>
