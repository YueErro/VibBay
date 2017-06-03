/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package packBD;

import packModelo.Usuario;
import java.sql.*;

/**
 *
 * @author YI
 */
public class GestorUsuario {

    private static GestorUsuario gu;

    private GestorUsuario() {
    }

    public static GestorUsuario getInstance() {
        if (gu == null) {
            gu = new GestorUsuario();
        }
        return gu;
    }

    public boolean buscarUsuario(String pCorreo) {
        ResultSet resultado;
        boolean encontrado = false;
        Conexion c = Conexion.getInstance();
        c.conectar();

        try {
            resultado = c.getSt().executeQuery("SELECT correo FROM Usuario WHERE correo = '" + pCorreo + "'");

            if (resultado.next()) {
                encontrado = true;
            }
        } catch (SQLException ex) {
            System.err.println("SQLException: " + ex.getMessage());
        }
        return encontrado;
    }

    public boolean comprobarPassword(String pEmail, String pPass) {
        ResultSet resultado;
        boolean coincide = false;
        Conexion c = Conexion.getInstance();
        c.conectar();

        try {
            resultado = c.getSt().executeQuery("SELECT pass FROM Usuario WHERE correo = '" + pEmail + "' AND pass = '" + pPass + "'");

            if (resultado.next()) {
                coincide = true;
            }
        } catch (SQLException ex) {
            System.err.println("SQLException: " + ex.getMessage());
        }
        return coincide;
    }

    public Usuario mostrarPerfil(String pCorreo) {
        ResultSet r;
        Conexion c = Conexion.getInstance();
        c.conectar();
        String nick;
        String pass;
        String dni;
        String fnac;
        String genero;
        String foto;
        int tlf;
        Usuario u = null;

        try {
            r = c.getSt().executeQuery("SELECT * FROM Usuario WHERE correo = '" + pCorreo + "'");

            r.first();

            nick = r.getString("nick");
            dni = r.getString("dni");
            pass = r.getString("pass");
            fnac = r.getString("fnac");
            genero = r.getString("genero");
            tlf = r.getInt("tlf");
            foto = r.getString("foto");

            u = new Usuario(nick, dni, pCorreo, pass, fnac, genero, tlf, foto);
        } catch (SQLException ex) {
            System.err.println("SQLException: " + ex.getMessage());
        } finally {
            c.desconectar();
        }
        return u;
    }

    public boolean cambiarPerfil(String pNick, String pDni,
            String pCorreo, String pPass,
            String pFnac, String pGenero,
            int pTlf, String pFoto) {
        Conexion c = Conexion.getInstance();
        c.conectar();
        boolean cambiado = false;

        try {
            c.getSt().executeUpdate(" UPDATE Usuario SET nick = '" + pNick + "', dni = '" + pDni + "'" + ""
                    + ", pass = '" + pPass + "', fnac = '" + pFnac + "', genero = '" + pGenero + "'" + ""
                    + ", tlf = " + pTlf + ", foto = '" + pFoto + "' WHERE correo = '" + pCorreo + "' ");
            cambiado = true;
        } catch (SQLException pEx) {
            pEx.getMessage();
        } finally {
            c.desconectar();
        }
        return cambiado;
    }

    public void registrarUsuario(String pNick, String pDni,
            String pCorreo, String pPass,
            String pFnac, String pGenero,
            int pTlf, String pFoto) {
        Conexion c = Conexion.getInstance();
        c.conectar();

        try {
            if (pFoto == null) {
                pFoto = "sfp.jpg";
            }

            if (pFnac.equalsIgnoreCase("")) {
                pFnac = "1900-01-01";
            }

            Connection con = c.getConexion();

            PreparedStatement ps = con.prepareStatement("INSERT INTO Usuario( nick, dni, correo, pass, fnac, genero, tlf, foto ) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)");

            ps.setString(1, pNick);
            ps.setString(2, pDni);
            ps.setString(3, pCorreo);
            ps.setString(4, pPass);
            ps.setString(5, pFnac);
            ps.setString(6, pGenero);
            ps.setInt(7, pTlf);
            ps.setString(8, pFoto);

            ps.executeUpdate();

        } catch (SQLException pEx) {
            pEx.getStackTrace();
            System.out.println(pEx.getMessage());
        } finally {
            c.desconectar();
        }
    }
}
