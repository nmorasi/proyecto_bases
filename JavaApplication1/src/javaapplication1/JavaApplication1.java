/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package javaapplication1;
import java.sql.Connection;
import java.util.Date;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Random;
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
    public ResultSet obtenerGananciaChofer(){
        
        return null;
    }
    //agregar nuevo viaje 
    int RangoRandom(int min, int max)
    {
    int range = (max - min) + 1;     
    return (int)(Math.random() * range) + min;
    }
    public int crearViaje() throws SQLException{
        Connection conn = null;
        conn = DriverManager.getConnection(url,user,password);
        System.out.println("Connected to postgresql");
        Statement st = conn.createStatement();
         ResultSet rs = st.executeQuery("SELECT count(1) from viaje;");
         rs.next();
         //calcula una llave
         int id_v = Integer.parseInt(rs.getString(1)) + 1;
         //asigna un chofer 
        rs = st.executeQuery("SELECT count(1) from chofer;");
        rs.next();
        int num_chofer = RangoRandom(1,Integer.parseInt(rs.getString(1)) + 1);
        rs = st.executeQuery("SELECT numero_licencia from chofer;");
        int cont = 0;
        String num_lic = "";
        while(rs.next()){
            if(cont == num_chofer){
                num_lic = rs.getString(1);
                break;
            }
            cont++;
        }
        //asigna un numero economico al azar 
        rs = st.executeQuery("SELECT count(1) from taxi;");
        rs.next();
        int num_economico = RangoRandom(1,Integer.parseInt(rs.getString(1)) + 1);
        //preguntar si quiere compartir 
        
        //asigna tambien una distancia al azar 
        double distancia = RangoRandom(5,70) + 1.0/RangoRandom(1,9);
        //tambien multidestino 
        //con la fecha actual 
        String date = new SimpleDateFormat("MM-dd-yyyy").format(new Date());
        //crear tambien la transaccion para esa persona 
        //nadamas id_transaccion el id del viaje el id del cliente 
        //y el monto parcial 
        double parcial = 15  + 8 * distancia; 
        System.out.println(id_v +","+num_lic+","+num_economico+","+distancia+","+date+","+parcial);
        st = conn.createStatement();
        //st.executeUpdate("INSERT INTO viaje(id_viaje) VALUES (1001);");
        st.executeUpdate("INSERT INTO viaje (id_viaje,numero_licencia,num_economico,distancia,fecha)" + 
                           " VALUES (" + id_v + ",'"+ num_lic +"',"+ num_economico+","+distancia+",'"+date+"');");
        return id_v;
    }
    public ResultSet obtenerInformacionViaje(){ 
        return null;
    }
    /**
     * @param args the command line arguments
     */
    
}
