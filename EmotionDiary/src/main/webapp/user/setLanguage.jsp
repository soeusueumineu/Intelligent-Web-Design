<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String lang = request.getParameter("lang");
    if (lang == null) lang = "ko";

    session.setAttribute("lang", lang);

    String back = request.getHeader("Referer");
    if (back != null)
        response.sendRedirect(back);
    else
        response.sendRedirect("/EmotionDiary/index.jsp");
%>
