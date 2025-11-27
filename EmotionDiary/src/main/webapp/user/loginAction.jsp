<%@ page import="dao.UserDAO, dto.UserDTO" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
request.setCharacterEncoding("UTF-8");

String username = request.getParameter("username");
String password = request.getParameter("password");
String remember = request.getParameter("remember");

UserDAO dao = new UserDAO();
UserDTO user = dao.login(username, password);

if (user != null) {
    session.setAttribute("user", user);

    if ("on".equals(remember)) {
        Cookie cookie = new Cookie("saved_id", username);
        cookie.setMaxAge(60 * 60 * 24 * 30);
        cookie.setPath("/");
        response.addCookie(cookie);
    } else {
        Cookie cookie = new Cookie("saved_id", "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
    }

    response.sendRedirect("../index.jsp");

} else {
    // 로그인 실패 시 alert 띄우고 로그인 페이지로 이동
    out.println("<script>");
    out.println("alert('로그인 실패: 아이디 또는 비밀번호를 확인하세요.');");
    out.println("location.href='login.jsp';");
    out.println("</script>");
}
%>
