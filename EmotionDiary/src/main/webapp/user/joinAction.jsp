<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO" %>

<%
request.setCharacterEncoding("UTF-8");
%>

<!-- 액션 태그로 DTO 생성 -->
<jsp:useBean id="user" class="dto.UserDTO" scope="page" />

<!-- ★ request 파라미터 자동 바인딩 -->
<jsp:setProperty name="user" property="username" />
<jsp:setProperty name="user" property="password" />
<jsp:setProperty name="user" property="nickname" />

<%
UserDAO dao = new UserDAO();

// 액션 태그로 생성된 user 객체 사용
int result = dao.register(user);

if (result == 1) {
    response.sendRedirect("login.jsp");
} else {
    out.println("<h3>회원가입 실패!</h3>");
}
%>
