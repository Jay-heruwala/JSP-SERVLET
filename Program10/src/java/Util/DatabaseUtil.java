
package Util;
import java.sql.*;

public class DatabaseUtil {
    
    public static Connection connection;
    
    public static Connection getConnection() {
        
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/programs","root" ,"Root");
            
        }catch(ClassNotFoundException ex){
            System.out.println("Class Not Found");
        }catch(SQLException e){
            System.out.println("SQL exception");
        }
        
        return connection;
    }
    
}
