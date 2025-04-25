
package dao;



import model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/programs";
    private String jdbcUsername = "root";
    private String jdbcPassword = "Root";

    private static final String INSERT_USER_SQL = "INSERT INTO user (firstname, lastname, email, mobilenumber, address, role, password) VALUES (?, ?, ?, ?, ?, ?, ?);";
    private static final String SELECT_USER_BY_EMAIL = "SELECT * FROM user WHERE email = ?;";
    private static final String SELECT_ALL_USERS = "SELECT * FROM user;";
    private static final String DELETE_USER_SQL = "DELETE FROM user WHERE email = ?;";
    private static final String UPDATE_USER_SQL = "UPDATE user SET firstname = ?, lastname = ?, mobilenumber = ?, address = ?, role = ?, password = ? WHERE email = ?;";

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public void insertUser(User user) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER_SQL)) {
            preparedStatement.setString(1, user.getFirstName());
            preparedStatement.setString(2, user.getLastName());
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setLong(4, user.getMobileNumber());
            preparedStatement.setString(5, user.getAddress());
            preparedStatement.setString(6, user.getRole());
            preparedStatement.setString(7, user.getPassword());
            preparedStatement.executeUpdate();
        }
    }

    public User selectUser(String email) {
        User user = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_EMAIL)) {
            preparedStatement.setString(1, email);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                String firstName = rs.getString("firstname");
                String lastName = rs.getString("lastname");
                long mobileNumber = rs.getLong("mobilenumber");
                String address = rs.getString("address");
                String role = rs.getString("role");
                String password = rs.getString("password");
                user = new User(firstName, lastName, email, mobileNumber, address, role, password);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public List<User> selectAllUsers() {
        List<User> users = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_USERS)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                String firstName = rs.getString("firstname");
                String lastName = rs.getString("lastname");
                String email = rs.getString("email");
                long mobileNumber = rs.getLong("mobilenumber");
                String address = rs.getString("address");
                String role = rs.getString("role");
                String password = rs.getString("password");
                users.add(new User(firstName, lastName, email, mobileNumber, address, role, password));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public boolean deleteUser(String email) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(DELETE_USER_SQL)) {
            statement.setString(1, email);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public boolean updateUser(User user) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(UPDATE_USER_SQL)) {
            statement.setString(1, user.getFirstName());
            statement.setString(2, user.getLastName());
            statement.setLong(3, user.getMobileNumber());
            statement.setString(4, user.getAddress());
            statement.setString(5, user.getRole());
            statement.setString(6, user.getPassword());
            statement.setString(7, user.getEmail());
            rowUpdated = statement.executeUpdate() > 0;
        }
        return rowUpdated;
    }
}