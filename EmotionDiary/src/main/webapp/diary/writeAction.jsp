<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, util.DBUtil" %>
<%@ page import="org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>
<%@ page import="dto.UserDTO" %>
<%@ page import="java.time.LocalDateTime, java.time.ZoneId" %>

<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");

// 로그인 사용자 확인
UserDTO user = (UserDTO) session.getAttribute("user");
if (user == null) {
    out.println("<h3>❌ 로그인 후 이용해주세요.</h3>");
    return;
}

// 업로드 경로
String uploadPath = application.getRealPath("/upload");
File uploadDir = new File(uploadPath);
if (!uploadDir.exists()) uploadDir.mkdir();

DiskFileItemFactory factory = new DiskFileItemFactory();
factory.setRepository(uploadDir);
ServletFileUpload upload = new ServletFileUpload(factory);
upload.setHeaderEncoding("UTF-8");

// 저장 변수
String emotion = null;
String content = null;
String fileName = null;

try {

    // 1. multipart 파싱
    java.util.List<FileItem> items = upload.parseRequest(request);

    for (FileItem item : items) {
        if (item.isFormField()) {
            // 일반 파라미터
            switch (item.getFieldName()) {
                case "emotion":
                    emotion = item.getString("UTF-8");
                    break;
                case "content":
                    content = item.getString("UTF-8");
                    break;
            }
        } else {
            // 파일 업로드 처리
            if (!item.getName().equals("")) {
                fileName = System.currentTimeMillis() + "_" + item.getName();
                File uploadedFile = new File(uploadPath + "/" + fileName);
                item.write(uploadedFile);
            }
        }
    }

    // 2. 한국 시간(KST) 생성
    
    LocalDateTime nowKST = LocalDateTime.now(ZoneId.of("Asia/Seoul"));

    // 3. DB 저장 
    
    String sql = "INSERT INTO emotion_log (user_id, emotion, diary_text, file_name, created_at) VALUES (?, ?, ?, ?, ?)";

    try (java.sql.Connection conn = DBUtil.getConnection();
         java.sql.PreparedStatement pstmt = conn.prepareStatement(sql)) {

        pstmt.setInt(1, user.getId());
        pstmt.setString(2, emotion);
        pstmt.setString(3, content);
        pstmt.setString(4, fileName);
        pstmt.setTimestamp(5, java.sql.Timestamp.valueOf(nowKST)); // 한국 시간 저장

        pstmt.executeUpdate();
    }

    // 4. 성공 시 리스트 페이지 이동
    response.sendRedirect("list.jsp");

} catch (Exception e) {
    e.printStackTrace();
    out.println("<h3>❌ 일기 저장 실패</h3>");
}
%>
