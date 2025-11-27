<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.EmotionLogDAO, dto.EmotionLogDTO" %>
<%@ include file="/WEB-INF/header.jsp" %>

<html>
<head>
    <link rel="stylesheet" href="/EmotionDiary/assets/css/style.css">
</head>

<body>
<div class="container">

    <%
        if (loginUser == null) {
            response.sendRedirect("/EmotionDiary/user/login.jsp");
            return;
        }

        int logId = Integer.parseInt(request.getParameter("log_id"));
        EmotionLogDAO dao = new EmotionLogDAO();
        EmotionLogDTO log = dao.getLogById(logId);
    %>

    <button onclick="location.href='list.jsp'" class="btn-back">뒤로가기</button>

    <div class="detail-card">
        <h2><%= getEmoji(log.getEmotion()) %></h2>

        <!-- 작성 날짜 표시 수정 -->
        <p class="date"><%= log.getCreatedAt() %></p>

        <p class="content"><%= log.getContent().replace("\n","<br>") %></p>

        <% if (log.getFileName() != null && !log.getFileName().equals("")) { %>
            <div style="margin-top:20px;">
                <img src="<%= request.getContextPath() %>/upload/<%= log.getFileName() %>"

                    style="width:300px; border-radius:10px; box-shadow:0 2px 8px rgba(0,0,0,0.2);">
            </div>
        <% } %>

        <div class="button-group">
            <button onclick="location.href='update.jsp?log_id=<%= logId %>'" class="btn">수정</button>
            <button onclick="location.href='delete.jsp?log_id=<%= logId %>'" class="btn delete">삭제</button>
        </div>
    </div>

</div>
</body>
</html>

<%!
    public String getEmoji(String emotion) {
        switch (emotion) {
            case "happy": return "😊";
            case "sad": return "😢";
            case "angry": return "😡";
            case "surprise": return "😱";
            case "tired": return "😴";
            case "depressed": return "😔";
            default: return emotion;
        }
    }
%>
