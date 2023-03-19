<%@ page contentType="text/html; charset=UTF-8" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>title</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    // 사용자로부터 데이터를 읽어드림.
    String id = request.getParameter("id");
    String passwd = request.getParameter("passwd");


    // 아이디와 패스워드를 저장
    session.setAttribute("id", id);
    session.setAttribute("passwd", passwd);

    // 세션의 유지시간 설정
    session.setMaxInactiveInterval(60*60);

    response.sendRedirect("../index.jsp");

%>
</body>
</html>
