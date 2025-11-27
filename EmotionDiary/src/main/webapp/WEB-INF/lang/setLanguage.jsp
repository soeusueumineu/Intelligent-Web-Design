<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String lang = request.getParameter("lang");

if (lang == null) lang = "ko";   // default

session.setAttribute("lang", lang);

// 이전 페이지로 이동
response.sendRedirect(request.getHeader("referer"));
%>
