<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, util.DBUtil" %>
<%@ page import="org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>
<%@ page import="java.time.LocalDateTime, java.time.ZoneId" %>

<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");

String uploadPath = application.getRealPath("/upload");
File uploadDir = new File(uploadPath);
if (!uploadDir.exists()) uploadDir.mkdirs();

DiskFileItemFactory factory = new DiskFileItemFactory();
factory.setRepository(uploadDir);
ServletFileUpload upload = new ServletFileUpload(factory);
upload.setHeaderEncoding("UTF-8");

int logId = 0;
String emotion = null;
String content = null;
String oldFileName = null;
String newFileName = null;

try {
    java.util.List<FileItem> items = upload.parseRequest(request);

    for (FileItem item : items) {

        if (item.isFormField()) {
            // 일반 input들
            String fieldName = item.getFieldName();
            String value = item.getString("UTF-8");

            if (fieldName.equals("log_id")) logId = Integer.parseInt(value);
            if (fieldName.equals("emotion")) emotion = value;
            if (fieldName.equals("content")) content = value;

        } else {
            // 파일 input 처리
            String originalName = item.getName();

            if (originalName != null && !originalName.trim().equals("")) {
                // Windows 경로 제거 대비
                originalName = new File(originalName).getName();

                newFileName = System.currentTimeMillis() + "_" + originalName;

                File uploadedFile = new File(uploadPath, newFileName);
                item.write(uploadedFile);
            }
        }
    }

    // 기존 파일 조회
    String selectSql = "SELECT file_name FROM emotion_log WHERE log_id=?";
    try (java.sql.Connection conn = DBUtil.getConnection();
         java.sql.PreparedStatement pstmt = conn.prepareStatement(selectSql)) {

        pstmt.setInt(1, logId);
        java.sql.ResultSet rs = pstmt.executeQuery();

        if (rs.next()) oldFileName = rs.getString("file_name");
    }

    // 기존 파일 삭제
    if (newFileName != null && oldFileName != null && !oldFileName.equals("")) {
        File oldFile = new File(uploadPath, oldFileName);
        if (oldFile.exists()) oldFile.delete();
    }

    String finalFileName = (newFileName != null) ? newFileName : oldFileName;

    // 한국 시간
    LocalDateTime nowKST = LocalDateTime.now(ZoneId.of("Asia/Seoul"));

    // DB 업데이트
    String updateSql = 
        "UPDATE emotion_log SET emotion=?, diary_text=?, file_name=?, updated_at=? WHERE log_id=?";

    try (java.sql.Connection conn = DBUtil.getConnection();
         java.sql.PreparedStatement pstmt = conn.prepareStatement(updateSql)) {

        pstmt.setString(1, emotion);
        pstmt.setString(2, content);
        pstmt.setString(3, finalFileName);
        pstmt.setTimestamp(4, java.sql.Timestamp.valueOf(nowKST));
        pstmt.setInt(5, logId);

        pstmt.executeUpdate();
    }

    response.sendRedirect("detail.jsp?log_id=" + logId);

} catch (Exception e) {
    e.printStackTrace();
    out.println("<h3 style='color:red;'>❌ 수정 실패 (오류는 콘솔에서 확인하세요)</h3>");
}
%>
