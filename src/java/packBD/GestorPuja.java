/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package packBD;

import java.sql.*;
import java.util.ArrayList;
import packModelo.Puja;

/**
 *
 * @author YI
 */
public class GestorPuja {

    private static GestorPuja gp;

    private GestorPuja() {
    }

    public static GestorPuja getInstance() {
        if (gp == null) {
            gp = new GestorPuja();
        }
        return gp;
    }

    public void pujar(String pDT, String pEmail, int pCod, double pCant) {
        Conexion c = Conexion.getInstance();

        c.conectar();

        try {
            Connection con = c.getConexion();

            PreparedStatement ps = con.prepareStatement("INSERT INTO Puja( fecha, email, codArticulo, cantidad )"
                    + "VALUES( ?, ?, ?, ? ) ");
            ps.setString(1, pDT);
            ps.setString(2, pEmail);
            ps.setInt(3, pCod);
            ps.setDouble(4, pCant);

            ps.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("SQLException: " + ex.getMessage());
        }
    }

    public ArrayList<Puja> misPujas(String pEmail) {
        ResultSet r;
        Conexion c = Conexion.getInstance();
        c.conectar();
        ArrayList<Puja> pujas = new ArrayList<>();

        try {
            r = c.getSt().executeQuery("SELECT * FROM Puja WHERE email = '" + pEmail + "'");

            while (r.next()) {
                String fecha = r.getString("fecha");
                int codArticulo = r.getInt("codArticulo");
                double cantidad = r.getDouble("cantidad");

                pujas.add(new Puja(fecha, pEmail, codArticulo, cantidad));
            }
        } catch (SQLException ex) {
            System.err.println("SQLException: " + ex.getMessage());
        } finally {
            c.desconectar();
        }
        return pujas;
    }

    public ArrayList<Puja> buscarPujas(int pCod) {
        ResultSet r;
        Conexion c = Conexion.getInstance();
        c.conectar();
        ArrayList<Puja> pujas = new ArrayList<>();

        try {
            r = c.getSt().executeQuery("SELECT * FROM Puja WHERE codArticulo = '" + pCod + "'");

            while (r.next()) {
                String fecha = r.getString("fecha");
                String email = r.getString("email");
                double cantidad = r.getDouble("cantidad");

                pujas.add(new Puja(fecha, email, pCod, cantidad));
            }
        } catch (SQLException ex) {
            System.err.println("SQLException: " + ex.getMessage());
        } finally {
            c.desconectar();
        }
        return pujas;
    }

    public double maxPuja(int pCod) {
        ResultSet r;
        Conexion c = Conexion.getInstance();
        c.conectar();
        double precio = 0.00;

        try {
            r = c.getSt().executeQuery("SELECT MAX(cantidad) AS pre FROM Puja WHERE codArticulo = '" + pCod + "'");

            if (r != null) {
                r.first();
                precio = r.getDouble("pre");
            }
        } catch (SQLException ex) {
            System.err.println("SQLException: " + ex.getMessage());
        } finally {
            c.desconectar();
        }
        return precio;
    }
}
