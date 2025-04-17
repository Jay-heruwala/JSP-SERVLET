
package Util;

import java.sql.*;

public class DatabaseUtil {
    private static Connection connection;
    
    
    public static Connection getConnection(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/programs", "root", "Root");
        }catch(ClassNotFoundException e){
            System.out.println("Error : " + e.getMessage());
        }catch(Exception e){
            System.out.println("Error : " + e.getMessage());
        }
        return connection;
    }
    
}
