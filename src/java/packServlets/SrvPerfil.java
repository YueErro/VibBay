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
@WebServlet(name = "SrvPerfil", urlPatterns = {"/SrvPerfil"})
public class SrvPerfil extends HttpServlet {

    @Override
    public void init(ServletConfig cfg) throws ServletException {
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
        String pass = mr.getParameter("clave");
        String fnac = mr.getParameter("fnac");
        String genero = mr.getParameter("genero");
        Integer tlf = Integer.parseInt(mr.getParameter("tlf"));
        System.out.println("hola");
        String foto = mr.getFilesystemName("foto");
        String correo = request.getSession().getAttribute("Usuario").toString();

        if (foto == null) {
            foto = GestorUsuario.getInstance().mostrarPerfil(correo).getFoto();
        }
        try {
            GestorUsuario.getInstance().cambiarPerfil(nick, dni, correo, pass, fnac, genero, tlf, foto);

            String path = "'MiCuenta.jsp'";
            response.setContentType("text/html");
            PrintWriter out = null;

            try {
                out = response.getWriter();
            } catch (IOException e) {
                System.out.println("Se ha producido una IOException");
            }

            out.println("<HTML>");
            out.println("<HEAD>");
            out.println("<TITLE>Actualizado</TITLE>");
            out.println("</HEAD>");
            out.println("<BODY>");
            out.println("<CENTER>");
            out.println("<br>");
            out.println("<p>Perfil actualizado correctamente:");
            out.println("<br>");
            out.println("<br>");
            out.println("<a href=" + path + ">MI CUENTA</a>");
            out.println("</CENTER>");
            out.println("</BODY>");
            out.println("</HTML>");
            out.flush();
            out.close();
        } catch (Exception e) {
            System.out.println("Se ha producido una IOException");
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
            Logger.getLogger(SrvPerfil.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (Exception ex) {
            Logger.getLogger(SrvPerfil.class.getName()).log(Level.SEVERE, null, ex);
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