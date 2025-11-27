<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="WEB-INF/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <link rel="stylesheet" href="/EmotionDiary/assets/css/style.css">
</head>

<body>
<div class="container">

    <% if (loginUser == null) { %>

        <h2><%= messages.get("title") %></h2>
        <p style="text-align:center;"><%= messages.get("welcome") %></p>

        <button onclick="location.href='/EmotionDiary/user/login.jsp'">
            <%= messages.get("login") %>
        </button>

        <button onclick="location.href='/EmotionDiary/user/join.jsp'">
            <%= messages.get("join") %>
        </button>

    <% } else { %>

        <h2>
            <%= loginUser.getNickname() %> 
            <%= messages.get("nickname_suffix") %>
            - <%= messages.get("title") %>
        </h2>

        <button onclick="location.href='/EmotionDiary/diary/write.jsp'">
            <%= messages.get("write_diary") %>
        </button>

        <button onclick="location.href='/EmotionDiary/diary/list.jsp'">
            <%= messages.get("list_diary") %>
        </button>

    <% } %>

</div>
</body>
</html>
