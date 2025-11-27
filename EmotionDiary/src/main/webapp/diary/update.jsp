<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.EmotionLogDAO, dto.EmotionLogDTO" %>
<%@ include file="../WEB-INF/header.jsp" %>

<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../assets/css/style.css">
</head>

<body>
<div class="container">

<%
    request.setCharacterEncoding("UTF-8");

    int logId = Integer.parseInt(request.getParameter("log_id"));
    EmotionLogDAO dao = new EmotionLogDAO();
    EmotionLogDTO log = dao.getLogById(logId);

    String selectedEmotion = log.getEmotion();
%>

    <h2>일기 수정하기</h2>

    <!-- 파일 업로드 가능하도록 enctype 추가 -->
    <form action="updateAction.jsp" method="post" enctype="multipart/form-data">
        <input type="hidden" name="log_id" value="<%= logId %>">

        <!-- 감정 선택 -->
        <h3>오늘의 감정</h3>
        <div class="emotion-container">
            <div class="emotion-item" data-value="😊 행복">😊</div>
            <div class="emotion-item" data-value="😢 슬픔">😢</div>
            <div class="emotion-item" data-value="😡 분노">😡</div>
            <div class="emotion-item" data-value="😱 놀람">😱</div>
            <div class="emotion-item" data-value="😴 피곤">😴</div>
            <div class="emotion-item" data-value="😔 우울">😔</div>
        </div>

        <input type="hidden" name="emotion" id="emotionInput" value="<%= selectedEmotion %>">
        <br>

        <!-- 기존 내용 -->
        <h3>내용</h3>
        <textarea name="content" required><%= log.getContent() %></textarea>

        <br>

        <!-- 기존 파일 보여주기 -->
        <% if (log.getFileName() != null && !log.getFileName().equals("")) { %>
            <p>현재 첨부파일:</p>
            <img src="/EmotionDiary/upload/<%= log.getFileName() %>"
                 style="width:120px; height:120px; object-fit:cover; border-radius:10px;">
            <br><br>
        <% } %>

        <!-- 새 파일 업로드 -->
        <h3>새 파일 업로드 (선택)</h3>
        <input type="file" name="uploadFile">
        <br><br>

        <button type="submit" class="btn">수정 완료</button>
    </form>
</div>

<script>
    const items = document.querySelectorAll(".emotion-item");
    const emotionInput = document.getElementById("emotionInput");
    const selectedEmotion = "<%= selectedEmotion %>";

    // 기존 emotion 자동 선택 표시
    items.forEach(item => {
        if (item.dataset.value === selectedEmotion) {
            item.classList.add("selected");
        }

        item.addEventListener("click", () => {
            items.forEach(i => i.classList.remove("selected"));
            item.classList.add("selected");
            emotionInput.value = item.dataset.value;
        });
    });
</script>

</body>
</html>
