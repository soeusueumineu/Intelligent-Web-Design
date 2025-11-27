package controller;

import util.DBUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

public class TestDBServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain;charset=UTF-8");

        try (Connection conn = DBUtil.getConnection()) {
            if (conn != null) {
                response.getWriter().println("✅ DB 연결 성공!");
            } else {
                response.getWriter().println("❌ DB 연결 실패!");
            }
        } catch (Exception e) {
            response.getWriter().println("❌ 예외 발생: " + e.getMessage());
        }
    }
}
