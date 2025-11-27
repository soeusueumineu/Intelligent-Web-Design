<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.EmotionLogDAO, dto.EmotionLogDTO, java.util.List" %>
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

        EmotionLogDAO dao = new EmotionLogDAO();
        List<EmotionLogDTO> logs = dao.getLogsByUser(loginUser.getId());
    %>

    <button onclick="location.href='/EmotionDiary/index.jsp'" class="btn-back">홈으로</button>

    <h2>내 감정 일기 목록</h2>

    <% if (logs.size() == 0) { %>
        <p>작성된 일기가 없습니다.</p>
    <% } else { %>

        <% for (EmotionLogDTO log : logs) { %>
            <div class="list-card" onclick="location.href='detail.jsp?log_id=<%= log.getLogId() %>'">

                <div class="emotion"><%= getEmoji(log.getEmotion()) %></div>

                <% if (log.getFileName() != null && !log.getFileName().equals("")) { %>
                    <img src="<%= request.getContextPath() %>/upload/<%= log.getFileName() %>"

                         alt="thumbnail"
                         style="width:80px; height:80px; object-fit:cover; border-radius:10px; margin-right:10px;">
                <% } %>

                <div class="content-preview"><%= log.getContent() %></div>

                <!-- 날짜 출력 수정 -->
                <div class="date"><%= log.getCreatedAt() %></div>
            </div>
        <% } %>

    <% } %>

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
