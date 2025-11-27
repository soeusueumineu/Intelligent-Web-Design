<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="util.DBUtil, java.io.File" %>

<%
request.setCharacterEncoding("UTF-8");

int logId = Integer.parseInt(request.getParameter("log_id"));

// 1. 첨부된 파일 이름 조회
String fileName = null;
String selectSql = "SELECT file_name FROM emotion_log WHERE log_id=?";

try (java.sql.Connection conn = DBUtil.getConnection();
     java.sql.PreparedStatement pstmt = conn.prepareStatement(selectSql)) {

    pstmt.setInt(1, logId);
    java.sql.ResultSet rs = pstmt.executeQuery();

    if (rs.next()) {
        fileName = rs.getString("file_name");
    }
} catch (Exception e) {
    e.printStackTrace();
}


// 2. DB에서 일기 삭제
String deleteSql = "DELETE FROM emotion_log WHERE log_id=?";

try (java.sql.Connection conn = DBUtil.getConnection();
     java.sql.PreparedStatement pstmt = conn.prepareStatement(deleteSql)) {

    pstmt.setInt(1, logId);
    pstmt.executeUpdate();

} catch (Exception e) {
    e.printStackTrace();
    out.println("삭제 실패");
    return;
}


// 3. 파일 삭제 (파일이 존재할 경우만)
if (fileName != null && !fileName.equals("")) {

    // 실제 업로드된 경로
    String uploadPath = application.getRealPath("/upload");

    File file = new File(uploadPath + File.separator + fileName);
    if (file.exists()) {
        file.delete();
    }
}

// 4. 삭제 후 목록으로 이동
response.sendRedirect("list.jsp");
%>
