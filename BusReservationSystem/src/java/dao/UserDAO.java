package dao;

import java.sql.*;
import util.DatabaseUtil;
import model.User;
import java.util.*;

public class UserDAO {

    public User getUserByUserName(String userName) {
        User user = null;
        Connection connection = null;
        try {
            connection = DatabaseUtil.getConnection();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        if (connection != null) {
            try {
                PreparedStatement stmt = connection.prepareStatement("select * from users where email=?");
                stmt.setString(1, userName);
                
                ResultSet resultSet = stmt.executeQuery();
                if(resultSet.next()){
                    user = new User();
                    user.setUser_id(resultSet.getLong("user_id"));
                    user.setName(resultSet.getString("name"));
                    user.setContact_number(resultSet.getString("contact_number"));
                    user.setEmail(resultSet.getString("email"));
                }

            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        return user;
    }
    
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT user_id, name, contact_number, email FROM users";

        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                User user = new User(
                    rs.getLong("user_id"),
                    rs.getString("name"),
                    rs.getString("contact_number"),
                    rs.getString("email")
                );
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    
     public int getTotalCustomers() {
        String sql = "SELECT COUNT(*) AS count FROM users";
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
