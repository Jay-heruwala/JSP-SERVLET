
package com.connection;
import java.sql.*;

public class ConnectionClass {
            String URL = "jdbc:mysql://localhost:3306/Programs";
            String user = "root";
            String databasePassword = "Root";
            
            public Connection createConnection()throws ClassNotFoundException,SQLException{
                Class.forName("com.mysql.cj.jdbc.Driver");
                return DriverManager.getConnection(URL, user, databasePassword);
            }
    
}
