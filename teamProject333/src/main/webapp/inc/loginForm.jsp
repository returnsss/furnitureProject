<%@ page contentType="text/html; charset=UTF-8" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>title</title>
</head>
<body>
<center>
    <h2>로그인</h2>
    <form action="loginProcess.jsp" method="post">
        <table border="1">
            <tr height="50">
                <td width="150">아이디</td>
                <td width="250"><input type="text" name="id"></td>
            </tr>
            <tr height="50">
                <td width="150">패스워드</td>
                <td width="250"><input type="password" name="passwd"></td>
            </tr>
            <tr height="50">
                <td colspan="2" align="center"><input type="submit" value="로그인"></td>
            </tr>
        </table>
    </form>
</center>
</body>
</html>
