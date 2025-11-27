<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String lang = request.getParameter("lang");

    if (lang != null && (lang.equals("ko") || lang.equals("en"))) {
        session.setAttribute("lang", lang);
    }

    // 이전 페이지로 이동 (없으면 index.jsp)
    String previous = request.getHeader("referer");
    if (previous == null) previous = "/EmotionDiary/index.jsp";

    response.sendRedirect(previous);
%>
