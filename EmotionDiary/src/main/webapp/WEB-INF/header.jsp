<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // 로그인 사용자
    dto.UserDTO loginUser = (dto.UserDTO) session.getAttribute("user");

    // 언어 설정
    String lang = (String) session.getAttribute("lang");
    if (lang == null) {
        lang = "ko";
        session.setAttribute("lang", "ko");
    }

    // 메시지 로딩
    String base = "/WEB-INF/lang/messages_" + lang + ".properties";
    java.util.Properties messages = new java.util.Properties();
    messages.load(application.getResourceAsStream(base));
%>

<div class="top-header">
    <a href="/EmotionDiary/index.jsp" class="logo"><%= messages.get("title") %></a>

    <div class="header-right">
        <% if (loginUser != null) { %>
            <span class="welcome">
                <%= loginUser.getNickname() %> <%= messages.get("nickname_suffix") %>
            </span>
            <a href="/EmotionDiary/user/logout.jsp" class="logout-btn">
                <%= messages.get("logout") %>
            </a>
        <% } else { %>
            <a href="/EmotionDiary/user/login.jsp" class="login-btn">
                <%= messages.get("login") %>
            </a>
        <% } %>

        <!-- 언어 전환 버튼 -->
        <a href="/EmotionDiary/setLang.jsp?lang=ko" class="lang-btn">KO</a>
        <a href="/EmotionDiary/setLang.jsp?lang=en" class="lang-btn">EN</a>
    </div>
</div>
