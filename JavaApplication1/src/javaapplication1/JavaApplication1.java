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
import java.util.LinkedList;
import java.util.Random;
/**
 *
 * @author el jotinieves
 */
public class JavaApplication1 {
    private final String url = "jdbc:postgresql://localhost/taxis";
    private final String user = "nieves";
    private final String password = "moran";
    
    
    //agregar nuevo viaje 
    int RangoRandom(int min, int max)
    {
    int range = (max - min) + 1;     
    return (int)(Math.random() * range) + min;
    }
    public int crearViaje() throws SQLException{
        Connection conn = null;
        conn = DriverManager.getConnection(url,user,password);
        Statement st = conn.createStatement();
         ResultSet rs = st.executeQuery("SELECT count(1) from viaje;");
         rs.next();
         //calcula una llave
         int id_viaje = Integer.parseInt(rs.getString(1)) + 1;
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
        rs = st.executeQuery("SELECT count(1) from vehiculo;");
        rs.next();
        int num_economico = RangoRandom(1,Integer.parseInt(rs.getString(1)));
        
        //asigna tambien una distancia al azar 
        double distancia = RangoRandom(5,70) + 1.0/RangoRandom(1,9);
        //con la fecha actual 
        String date = new SimpleDateFormat("MM-dd-yyyy").format(new Date());
        //crear tambien la transaccion para esa persona 
        //nadamas id_transaccion el id del viaje el id del cliente 
        //y el monto parcial 
        double parcial = 15  + 8 * distancia; 
        System.out.println(id_viaje +","+num_lic+","+num_economico+","+distancia+","+date+","+parcial);
        st = conn.createStatement();
        //st.executeUpdate("INSERT INTO viaje(id_viaje) VALUES (1001);");
        st.executeUpdate("INSERT INTO viaje (id_viaje,numero_licencia,num_economico,distancia,fecha)" + 
                           " VALUES (" + id_viaje + ",'"+ num_lic +"',"+ num_economico+","+distancia+",'"+date+"');");
       
        return id_viaje;
    }
    public ResultSet obtenerInformacionViaje(){ 
        return null;
    }
    /**
     * @param args the command line arguments
     */
    //para crear clientes aleatorios para acompañar a la persona 
    //toma un id de viaje e inserta a los clientes
    public void crearCliente(int id_viaje) throws SQLException{
        //toma un id aleatorio de cliente;
        Connection conn = null;
        conn = DriverManager.getConnection(url,user,password);
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT count(1) from cliente;");
        rs.next();
        int id_cliente = RangoRandom(1,Integer.parseInt(rs.getString(1)));
        //genera una nueva llave para la transaccion
        rs = st.executeQuery("SELECT count(1) from transaccion;");
        rs.next();
        int nueva_trans = Integer.parseInt(rs.getString(1)) + 1;

        //ingresa en transaccion la base de datos
        st.executeUpdate(String.format("INSERT INTO transaccion (id_transaccion,id_viaje,id_cliente) VALUES (%d,%d,%d);",nueva_trans,id_viaje,id_cliente));
                
    }
    //se supone que esto deberia tomar toda la informacion de la interfaz
    // e ingresarla en la base de datos
    int ingresar_info(int id_cliente,String tipo,boolean compartir) throws SQLException{
        //crear un viaje
        int id_viaje = this.crearViaje();
        
        Connection conn = null;
        conn = DriverManager.getConnection(url,user,password);
        Statement st = conn.createStatement();
        //agregargarme al viaje con una transaccion 
        ResultSet rs = st.executeQuery("SELECT count(1) from transaccion;");
        rs.next();
        int nueva_trans = Integer.parseInt(rs.getString(1)) + 1;
        st.executeUpdate(String.format("INSERT INTO transaccion (id_transaccion,id_viaje,id_cliente) VALUES (%d,%d,%d);",nueva_trans,id_viaje,id_cliente));
        //cambia el viaje
        st.executeUpdate(String.format("UPDATE viaje SET  tipo = '%s' WHERE id_viaje = %d;",tipo,id_viaje));
        //si resulta que si quieres compartir 
        if(compartir){
            int num_acomp = RangoRandom(1,2);
            for(int i = 0 ; i < num_acomp;i++){
                crearCliente(id_viaje);
            }
        }
        return id_viaje;
    }
    LinkedList<String[]> tuplas_viaje(int id_viaje) throws SQLException{ 
        Connection conn = null;
        conn = DriverManager.getConnection(url,user,password);
        Statement st = conn.createStatement();
        //agregargarme al viaje con una transaccion 
        
        ResultSet rs = st.executeQuery(String.format("SELECT * from cliente join transaccion using (id_cliente) WHERE id_viaje = %d ;",id_viaje));
        String[] temp;
        LinkedList<String[]> ret = new LinkedList<String[]>();
        while(rs.next()){
            temp = new String[5];
            temp[0] = rs.getString("nombre");
            temp[1] = rs.getString("ap_paterno");
            temp[2] = rs.getString("ap_materno");
            temp[3] = rs.getString("monto_total");
            temp[4] = rs.getString("descuento");
            ret.add(temp);
        }
        return ret;
    }
    LinkedList<String[]> tuplas_ganancias(String numero_licencia) throws SQLException{
         Connection conn = null;
        conn = DriverManager.getConnection(url,user,password);
        Statement st = conn.createStatement();
        //agregargarme al viaje con una transaccion 
        String query = "SELECT extract(year from fecha) yr,extract(month from fecha) mt,sum(ganancia_chofer) gan";
        query += " from transaccion join viaje using (id_viaje) ";
        query += "where numero_licencia = '%s'";
        query += "group by fecha;";       
        ResultSet rs = st.executeQuery(String.format(query, numero_licencia));
        String[] temp;
        LinkedList<String[]> ret = new LinkedList<String[]>();
        while(rs.next()){
            temp = new String[3];
            temp[0] = rs.getString("yr");
            temp[1] = rs.getString("mt");
            temp[2] = rs.getString("gan");
            ret.add(temp);
        }
        return ret;
    }
}
