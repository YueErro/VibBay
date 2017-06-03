/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package packBD;

import com.mysql.jdbc.*;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author YI
 */
public class Conexion {

    private Connection con;
    private Statement st;
    private final String url;
    private final String userName = "root";
    private final String password = "root";
    private static Conexion conexion;

    private Conexion() {
        url = "jdbc:mysql://localhost/bd_vibbaygrupo02";
    }

    public static Conexion getInstance() {
        if (conexion == null) {
            conexion = new Conexion();
        }
        return conexion;
    }

    public void conectar() {
        try {
            Class.forName("org.gjt.mm.mysql.Driver");
            con = (Connection) DriverManager.getConnection(url, userName, password);
            st = (Statement) con.createStatement();
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public void desconectar() {
        try {
            st.close();
            con.close();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public Connection getConexion() {

        return con;
    }

    public Statement getSt() {
        return st;
    }
}