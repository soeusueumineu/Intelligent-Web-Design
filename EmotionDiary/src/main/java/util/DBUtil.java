package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {

    private static final String URL =
        "jdbc:mysql://emotiondiary.cjg2aaai646f.ap-northeast-2.rds.amazonaws.com:3306/emotiondiary?serverTimezone=Asia/Seoul&characterEncoding=UTF-8";

    private static final String USER = "admin";      
    private static final String PASSWORD = "password"; 

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
