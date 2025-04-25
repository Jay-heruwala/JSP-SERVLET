/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



import model.User;
import model.Role;
import util.DatabaseUtil;


import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if (action == null || action.equals("list")) {
                listUsers(request, response);
            } else if (action.equals("new")) {
                showNewForm(request, response);
            } else if (action.equals("edit")) {
                showEditForm(request, response);
            } else if (action.equals("delete")) {
                deleteUser(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if (action.equals("insert")) {
                insertUser(request, response);
            } else if (action.equals("update")) {
                updateUser(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<User> userList = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                 "SELECT u.user_id, u.name, u.address, u.email_id, u.mobile_no, u.role_id, r.role_name " +
                 "FROM users u JOIN role r ON u.role_id = r.role_id")) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setAddress(rs.getString("address"));
                user.setEmailId(rs.getString("email_id"));
                user.setMobileNo(rs.getString("mobile_no"));
                user.setRoleId(rs.getInt("role_id"));
                user.setRoleName(rs.getString("role_name"));
                userList.add(user);
            }
        }
        request.setAttribute("userList", userList);
        request.getRequestDispatcher("/views/user-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<Role> roleList = getRoles();
        request.setAttribute("roleList", roleList);
        request.getRequestDispatcher("/views/user-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        User user = null;
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                 "SELECT u.user_id, u.name, u.address, u.email_id, u.mobile_no, u.role_id, u.password, r.role_name " +
                 "FROM users u JOIN role r ON u.role_id = r.role_id WHERE u.user_id = ?")) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setAddress(rs.getString("address"));
                user.setEmailId(rs.getString("email_id"));
                user.setMobileNo(rs.getString("mobile_no"));
                user.setRoleId(rs.getInt("role_id"));
                user.setPassword(rs.getString("password"));
                user.setRoleName(rs.getString("role_name"));
            }
        }
        List<Role> roleList = getRoles();
        request.setAttribute("user", user);
        request.setAttribute("roleList", roleList);
        request.getRequestDispatcher("/views/user-form.jsp").forward(request, response);
    }

    private void insertUser(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        User user = validateAndCreateUser(request);
        if (user == null) {
            List<Role> roleList = getRoles();
            request.setAttribute("roleList", roleList);
            request.getRequestDispatcher("/views/user-form.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                 "INSERT INTO users (name, address, email_id, mobile_no, role_id, password) VALUES (?, ?, ?, ?, ?, ?)")) {
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getAddress());
            stmt.setString(3, user.getEmailId());
            stmt.setString(4, user.getMobileNo());
            stmt.setInt(5, user.getRoleId());
            stmt.setString(6, user.getPassword());
            stmt.executeUpdate();
        }
        response.sendRedirect("users");
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        User user = validateAndCreateUser(request);
        if (user == null) {
            List<Role> roleList = getRoles();
            request.setAttribute("roleList", roleList);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/views/user-form.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                 "UPDATE users SET name = ?, address = ?, email_id = ?, mobile_no = ?, role_id = ?, password = ? WHERE user_id = ?")) {
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getAddress());
            stmt.setString(3, user.getEmailId());
            stmt.setString(4, user.getMobileNo());
            stmt.setInt(5, user.getRoleId());
            stmt.setString(6, user.getPassword());
            stmt.setInt(7, user.getUserId());
            stmt.executeUpdate();
        }
        response.sendRedirect("users");
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement("DELETE FROM users WHERE user_id = ?")) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        }
        response.sendRedirect("users");
    }

    private List<Role> getRoles() throws SQLException {
        List<Role> roleList = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT role_id, role_name FROM role")) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Role role = new Role();
                role.setRoleId(rs.getInt("role_id"));
                role.setRoleName(rs.getString("role_name"));
                roleList.add(role);
            }
        }
        return roleList;
    }

    private User validateAndCreateUser(HttpServletRequest request) {
        User user = new User();
        List<String> errors = new ArrayList<>();

        String userId = request.getParameter("userId");
        if (userId != null && !userId.isEmpty()) {
            user.setUserId(Integer.parseInt(userId));
        }

        String name = request.getParameter("name");
        if (name == null || name.trim().isEmpty()) {
            errors.add("Name is required.");
        } else if (name.length() > 100) {
            errors.add("Name must not exceed 100 characters.");
        }
        user.setName(name);

        String address = request.getParameter("address");
        if (address != null && address.length() > 255) {
            errors.add("Address must not exceed 255 characters.");
        }
        user.setAddress(address);

        String emailId = request.getParameter("emailId");
        if (emailId == null || emailId.trim().isEmpty()) {
            errors.add("Email is required.");
        } else if (!emailId.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            errors.add("Invalid email format.");
        }
        user.setEmailId(emailId);

        String mobileNo = request.getParameter("mobileNo");
        if (mobileNo == null || mobileNo.trim().isEmpty()) {
            errors.add("Mobile number is required.");
        } else if (!mobileNo.matches("\\d{10,15}")) {
            errors.add("Mobile number must be 10-15 digits.");
        }
        user.setMobileNo(mobileNo);

        String roleId = request.getParameter("roleId");
        if (roleId == null || roleId.trim().isEmpty()) {
            errors.add("Role is required.");
        } else {
            user.setRoleId(Integer.parseInt(roleId));
        }

        String password = request.getParameter("password");
        if (password == null || password.trim().isEmpty()) {
            errors.add("Password is required.");
        } else if (password.length() < 6 || password.length() > 50) {
            errors.add("Password must be between 6 and 50 characters.");
        }
        user.setPassword(password);

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("user", user);
            return null;
        }
        return user;
    }
}
