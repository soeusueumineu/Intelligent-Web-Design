<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String lang = request.getParameter("lang");

    if(lang == null) lang = "ko";

    session.setAttribute("lang", lang);

    // 이전 페이지로 돌아가기
    String referer = request.getHeader("Referer");
    if (referer != null) {
        response.sendRedirect(referer);
    } else {
        response.sendRedirect("/EmotionDiary/index.jsp");
    }
%>
