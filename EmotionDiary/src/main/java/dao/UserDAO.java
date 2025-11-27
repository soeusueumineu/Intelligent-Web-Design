package dao;

import dto.UserDTO;
import util.DBUtil;

import java.sql.*;

public class UserDAO {

    // 회원가입
    public int register(UserDTO user) {
        String sql = "INSERT INTO user (username, password, nickname) VALUES (?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getNickname());

            return pstmt.executeUpdate(); // insert 성공하면 1 반환

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    // 로그인
    public UserDTO login(String username, String password) {
        String sql = "SELECT * FROM user WHERE username = ? AND password = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, username);
            pstmt.setString(2, password);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                UserDTO user = new UserDTO();
                user.setId(rs.getInt("user_id"));   
                user.setUsername(rs.getString("username"));
                user.setNickname(rs.getString("nickname"));
                return user;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
