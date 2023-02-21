<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String year = request.getParameter("birthyy");
	String month = request.getParameterValues("birthmm")[0];
	String day = request.getParameter("birthdd");
	String birth = year + "/" + month + "/" + day;
	String gender = request.getParameter("gender");
	String mail1 = request.getParameter("mail1");
	String mail2 = request.getParameterValues("mail2")[0];
	String mail = mail1 + "@" + mail2;
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	String address = address1 + address2; 
	String phone1 = request.getParameterValues("phone1")[0];
	String phone2 = request.getParameter("phone2");
	String phone3 = request.getParameter("phone3");
	String phone = phone1 + "-" + phone2 + "-" + phone3;
	String receive_mail = request.getParameter("mailYN");
	String receive_phone = request.getParameter("smsYN");
	String agreement = request.getParameter("termsYN");
	
%>

<sql:setDataSource var="dataSource"
		url="jdbc:mariadb://localhost:3308/teamproject_market"
		driver="org.mariadb.jdbc.Driver"
		user="root" password="2714"/>

<sql:update dataSource="${dataSource }" var="resultSet">
	INSERT INTO member VALUES (?,?,?,?,?,?,?,?,?,?,?,now())
	<sql:param value="<%=id %>" />
	<sql:param value="<%=password %>" />
	<sql:param value="<%=name %>" />
	<sql:param value="<%=birth %>" />
	<sql:param value="<%=gender %>" />
	<sql:param value="<%=mail %>" />
	<sql:param value="<%=address %>" />
	<sql:param value="<%=phone %>" />
	<sql:param value="<%=receive_mail %>" />
	<sql:param value="<%=receive_phone %>" />
	<sql:param value="<%=agreement %>" />
	
</sql:update>

<c:if test="${resultSet >= 1 }">
	<c:redirect url="resultMember.jsp?msg=1" />
</c:if>
