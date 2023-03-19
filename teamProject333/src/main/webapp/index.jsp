<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>

<%
    String id = (String) session.getAttribute("id");
    String passwd = (String) session.getAttribute("passwd");
    if (id == null) {
        response.sendRedirect("/inc/loginForm.jsp");
    } else if(id.equals("admin") && passwd.equals("1234")) {
%>
        <a href="../admin/AdminProductsList.ad?pageNum=1">관리자 페이지로 이동</a>
<%
    } else {
        out.println(id + "님 안녕하세요");
    }
%>

</body>
</html>