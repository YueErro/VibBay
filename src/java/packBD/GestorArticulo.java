/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package packBD;

import java.sql.*;
import java.util.ArrayList;
import packModelo.Articulo;

/**
 *
 * @author YI
 */
public class GestorArticulo {

    private static GestorArticulo ga;

    private GestorArticulo() {
    }

    public static GestorArticulo getInstance() {
        if (ga == null) {
            ga = new GestorArticulo();
        }
        return ga;
    }

    public boolean publicarArticulo(String pEmail, String pImag, String pNom, String pCat, String pDesc, double pPrecio, String pFecha) {

        Conexion c = Conexion.getInstance();

        c.conectar();

        boolean insertado = false;

        try {

            Connection con = c.getConexion();

            PreparedStatement ps = con.prepareStatement("INSERT INTO articulo(email, imagen, nombre, categoria, descripcion, precio, estado, fecha) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)");

            ps.setString(1, pEmail);
            ps.setString(2, pImag);
            ps.setString(3, pNom);
            ps.setString(4, pCat);
            ps.setString(5, pDesc);
            ps.setDouble(6, pPrecio);
            ps.setString(7, "En puja");
            ps.setString(8, pFecha);

            ps.executeUpdate();
            insertado = true;

        } catch (SQLException pEx) {
            System.out.println("mal");
            pEx.getStackTrace();
        } finally {
            c.desconectar();
        }
        return insertado;
    }

    public ArrayList<Articulo> misArticulos(String pEmail) {
        ResultSet r;

        Conexion c = Conexion.getInstance();

        c.conectar();

        ArrayList<Articulo> articulos = new ArrayList<>();

        try {
            r = c.getSt().executeQuery("SELECT * FROM Articulo WHERE email = '" + pEmail + "'");

            while (r.next()) {
                int codigo = r.getInt("codigo");
                String imagen = r.getString("imagen");
                String nombre = r.getString("nombre");
                String categoria = r.getString("categoria");
                String descripcion = r.getString("descripcion");
                double precio = r.getDouble("precio");
                String estado = r.getString("estado");
                String fecha = r.getString("fecha");

                articulos.add(new Articulo(codigo, pEmail, imagen, nombre, categoria, descripcion, precio, estado, fecha));
            }
        } catch (SQLException ex) {
            System.err.println("SQLException: " + ex.getMessage());
        } finally {
            c.desconectar();
        }
        return articulos;
    }

    public ArrayList<Articulo> buscarArticulos(String pNom, String pCat) {
        ResultSet r;

        Conexion c = Conexion.getInstance();

        c.conectar();

        ArrayList<Articulo> articulos = new ArrayList<>();

        try {
            if (pNom == null && pCat == null) {
                r = c.getSt().executeQuery("SELECT * FROM Articulo WHERE estado = 'En puja'");
            } else if (pNom.equalsIgnoreCase("")) {
                r = c.getSt().executeQuery("SELECT * FROM Articulo WHERE categoria = '" + pCat + "' AND estado = 'En puja'");
            } else {
                r = c.getSt().executeQuery("SELECT * FROM Articulo WHERE categoria = '" + pCat + "' AND nombre LIKE '" + pNom + "' AND estado = 'En puja' ");
            }

            while (r.next()) {
                int codigo = r.getInt("codigo");
                String email = r.getString("email");
                String imagen = r.getString("imagen");
                String nombre = r.getString("nombre");
                String descripcion = r.getString("descripcion");
                double precio = r.getDouble("precio");
                String estado = r.getString("estado");
                String fecha = r.getString("fecha");

                articulos.add(new Articulo(codigo, email, imagen, nombre, pCat, descripcion, precio, estado, fecha));
            }
        } catch (SQLException ex) {
            System.err.println("SQLException: " + ex.getMessage());
        } finally {
            c.desconectar();
        }
        return articulos;
    }

    public Articulo buscarArticulo(Integer pCod) {
        ResultSet r;

        Conexion c = Conexion.getInstance();

        c.conectar();

        Articulo articulo = null;

        try {

            r = c.getSt().executeQuery("SELECT * FROM Articulo WHERE codigo = '" + pCod + "'");

            while (r.next()) {
                String imagen = r.getString("imagen");
                String categoria = r.getString("categoria");
                double precio = r.getDouble("precio");
                String estado = r.getString("estado");
                String nombre = r.getString("nombre");
                String descripcion = r.getString("descripcion");
                String email = r.getString("email");
                String fecha = r.getString("fecha");

                articulo = new Articulo(pCod, email, imagen, nombre, categoria, descripcion, precio, estado, fecha);
            }
        } catch (SQLException ex) {
            System.err.println("SQLException: " + ex.getMessage());
        } finally {
            c.desconectar();
        }
        return articulo;
    }

    public void cambiarEstado(String pEmail, int pCod) {

        Conexion c = Conexion.getInstance();

        c.conectar();

        try {
            c.getSt().executeUpdate("Update Articulo SET estado = 'Cerrado' WHERE email = '" + pEmail + "' AND codigo = '" + pCod + "' ");
        } catch (SQLException ex) {
            System.err.println("SQLException: " + ex.getMessage());
        }
    }

    public boolean cambiarArticulo(String pImagen, String pNom, String pCat, String pDesc, double pPrecio, int pCod) {
        Conexion c = Conexion.getInstance();

        c.conectar();

        boolean cambiado = false;
        try {
            c.getSt().executeUpdate(" UPDATE Articulo SET nombre = '" + pNom + "', categoria = '" + pCat + "'"
                    + ", descripcion = '" + pDesc + "', imagen = '" + pImagen + "', precio = '" + pPrecio + "' WHERE codigo = '" + pCod + "' ");
            cambiado = true;
        } catch (SQLException pEx) {
            pEx.getMessage();
        } finally {
            c.desconectar();
        }
        return cambiado;
    }
}