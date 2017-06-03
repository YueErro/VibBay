/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package packServlets;

import com.oreilly.servlet.MultipartRequest;
import java.io.*;
import java.net.URLDecoder;
import java.text.*;
import java.util.logging.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import packBD.*;

/**
 *
 * @author YI
 */
@WebServlet(name = "SrvRegistro", urlPatterns = {"/SrvRegistro"})
public class SrvRegistro extends HttpServlet {

    @Override
    public void init(ServletConfig cfg) throws ServletException {
        super.init();
        Conexion c = Conexion.getInstance();
        c.conectar();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.text.ParseException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException, Exception {
        MultipartRequest mr = new MultipartRequest(request, getPath() + "web/img/fotosPerfil");
        String nick = mr.getParameter("nick");
        String dni = mr.getParameter("dni");
        String correo = mr.getParameter("correo");
        String pass = mr.getParameter("clave");
        String fnac = mr.getParameter("fnac");
        String genero = mr.getParameter("genero");
        Integer tlf = Integer.parseInt(mr.getParameter("tlf"));
        String foto = mr.getFilesystemName("foto");

        if (GestorUsuario.getInstance().buscarUsuario(correo)) {

            String path = "'Login.jsp'";
            response.setContentType("text/html");
            PrintWriter out = null;

            try {
                out = response.getWriter();
            } catch (IOException e) {
                System.out.println("Se ha producido una IOException");
            }

            out.println("<HTML>");
            out.println("<HEAD>");
            out.println("<TITLE>Error</TITLE>");
            out.println("</HEAD>");
            out.println("<BODY>");
            out.println("<CENTER>");
            out.println("<br>");
            out.println("<p>Correo existente:");
            out.println("<br>");
            out.println("<br>");
            out.println("<a href=" + path + ">INICIAR SESIÓN</a>");
            out.println("</CENTER>");
            out.println("</BODY>");
            out.println("</HTML>");
            out.flush();
            out.close();
        } else {

            GestorUsuario.getInstance().registrarUsuario(nick, dni, correo, pass, fnac, genero, tlf, foto);

            String path = "'Login.jsp'";
            response.setContentType("text/html");
            PrintWriter out = null;

            try {
                out = response.getWriter();
            } catch (IOException e) {
                System.out.println("Se ha producido una IOException");
            }

            out.println("<HTML>");
            out.println("<HEAD>");
            out.println("<TITLE>Registrado</TITLE>");
            out.println("</HEAD>");
            out.println("<BODY>");
            out.println("<CENTER>");
            out.println("<br>");
            out.println("<p>Cuenta creada correctamente:");
            out.println("<br>");
            out.println("<br>");
            out.println("<a href=" + path + ">INICIAR SESIÓN</a>");
            out.println("</CENTER>");
            out.println("</BODY>");
            out.println("</HTML>");
            out.flush();
            out.close();
        }
    }

    private String getPath() throws UnsupportedEncodingException {
        String path = this.getClass().getClassLoader().getResource("").getPath();
        String fullPath = URLDecoder.decode(path, "UTF-8");
        String pathArr[] = fullPath.split("build/web/WEB-INF/classes/");
        fullPath = pathArr[0];
        String reponsePath;
        reponsePath = new File(fullPath).getPath() + File.separatorChar;
        return reponsePath;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(SrvRegistro.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(SrvRegistro.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(SrvRegistro.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}