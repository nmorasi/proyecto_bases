/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package javaapplication1;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
/**
 *
 * @author el jotinieves
 */
public class JavaApplication1 {
    private final String url = "jdbc:postgresql://localhost/taxis";
    private final String user = "nieves";
    private final String password = "moran";
    public ResultSet connect(String tabla,String campo) throws SQLException{
        Connection conn = null;
        conn = DriverManager.getConnection(url,user,password);
        System.out.println("Connected to postgresql");
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT "+campo+" FROM "+ tabla +";"); 
        return rs; 
    }
    /**
     * @param args the command line arguments
     */
    
}
