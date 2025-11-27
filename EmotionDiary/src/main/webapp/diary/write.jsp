<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/header.jsp" %>

<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../assets/css/style.css">
</head>

<body>
<div class="container">

    <h2>오늘의 감정 기록하기</h2>

    <!-- 파일 업로드 추가: enctype="multipart/form-data" -->
    <form action="writeAction.jsp" method="post" enctype="multipart/form-data">

        <!-- 감정 선택 UI -->
        <h3>오늘의 감정</h3>

        <div class="emotion-container">

            <div class="emotion-item" data-value="😊 행복">😊</div>
            <div class="emotion-item" data-value="😢 슬픔">😢</div>
            <div class="emotion-item" data-value="😡 분노">😡</div>
            <div class="emotion-item" data-value="😱 놀람">😱</div>
            <div class="emotion-item" data-value="😴 피곤">😴</div>
            <div class="emotion-item" data-value="😔 우울">😔</div>

        </div>

        <!-- 선택한 감정을 저장 -->
        <input type="hidden" name="emotion" id="emotionInput" required>

        <br>

        <!-- 내용 입력 -->
        <h3>내용</h3>
        <textarea name="content" placeholder="오늘의 기분을 자유롭게 적어보세요." required></textarea>

        <br>

        <!-- 파일 업로드 UI -->
        <h3>사진 업로드 (선택)</h3>
        <input type="file" name="uploadFile" accept="image/*">

        <br><br>
        <button type="submit" class="btn">등록</button>
    </form>
</div>

<script>
    // 감정 클릭 처리
    const items = document.querySelectorAll(".emotion-item");
    const emotionInput = document.getElementById("emotionInput");

    items.forEach(item => {
        item.addEventListener("click", () => {
            items.forEach(i => i.classList.remove("selected"));
            item.classList.add("selected");
            emotionInput.value = item.dataset.value;  // 이모지+텍스트 저장
        });
    });
</script>

</body>
</html>
