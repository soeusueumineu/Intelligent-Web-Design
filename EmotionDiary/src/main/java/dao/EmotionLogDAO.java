package dao;

import dto.EmotionLogDTO;
import util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmotionLogDAO {

    // 일기 저장
    public int insertLog(EmotionLogDTO log) {
        String sql = "INSERT INTO emotion_log (user_id, emotion, diary_text, created_at, file_name) " +
                     "VALUES (?, ?, ?, NOW(), ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, log.getUserId());
            pstmt.setString(2, log.getEmotion());
            pstmt.setString(3, log.getContent());
            pstmt.setString(4, log.getFileName());

            return pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    // 사용자별 일기 목록 조회
    public List<EmotionLogDTO> getLogsByUser(int userId) {
        List<EmotionLogDTO> list = new ArrayList<>();

        String sql = "SELECT * FROM emotion_log WHERE user_id = ? ORDER BY created_at DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                EmotionLogDTO log = new EmotionLogDTO();
                log.setLogId(rs.getInt("log_id"));
                log.setUserId(userId);
                log.setEmotion(rs.getString("emotion"));
                log.setContent(rs.getString("diary_text"));
                log.setCreatedAt(rs.getString("created_at")); 
                log.setFileName(rs.getString("file_name"));
                list.add(log);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 단일 일기 조회
    public EmotionLogDTO getLogById(int logId) {
        String sql = "SELECT * FROM emotion_log WHERE log_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, logId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                EmotionLogDTO log = new EmotionLogDTO();
                log.setLogId(logId);
                log.setUserId(rs.getInt("user_id"));
                log.setEmotion(rs.getString("emotion"));
                log.setContent(rs.getString("diary_text"));
                log.setCreatedAt(rs.getString("created_at"));
                log.setFileName(rs.getString("file_name"));
                return log;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
