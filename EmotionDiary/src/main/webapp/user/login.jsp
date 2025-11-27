<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/header.jsp" %>

<%
    // saved_id 쿠키 읽기
    String savedId = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if ("saved_id".equals(c.getName())) {
                savedId = c.getValue();
            }
        }
    }
%>

<html>
<head>
    <link rel="stylesheet" href="../assets/css/style.css">
</head>

<body>
<div class="container">
    <h2>로그인</h2>

    <form action="loginAction.jsp" method="post">

        <!-- savedId 자동 입력 -->
        <input type="text" name="username" placeholder="아이디"
               value="<%= savedId %>" required>

        <input type="password" name="password" placeholder="비밀번호" required>

        <!-- remember checkbox -->
        <label style="font-size:14px; display:block; margin-top:8px;">
            <input type="checkbox" name="remember"
                <%= !savedId.equals("") ? "checked" : "" %> >
            아이디 저장
        </label>

        <button type="submit">로그인</button>
    </form>
</div>
</body>
</html>
