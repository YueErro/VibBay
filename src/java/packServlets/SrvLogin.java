/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package packServlets;

import java.io.*;
import java.util.logging.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import packBD.*;

/**
 *
 * @author YI
 */
@WebServlet(name = "SrvLogin", urlPatterns = {"/SrvLogin"})
public class SrvLogin extends HttpServlet {

    @Override
    public void init(ServletConfig cfg) throws ServletException {
        super.init();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        String email = request.getParameter("correo");
        String password = request.getParameter("clave");

        boolean encontrado = GestorUsuario.getInstance().buscarUsuario(email);
        if (!encontrado) {
            String path1 = "'Login.jsp'";
            String path2 = "'Registro.jsp'";
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
            out.println("<br>");
            out.println("<p>Correo inexistente:");
            out.println("<br>");
            out.println("<br>");
            out.println("<a href=" + path1 + ">VOLVER</a>");
            out.println("<br>");
            out.println("<p>o");
            out.println("<br>");
            out.println("<br>");
            out.println("<a href=" + path2 + ">CREAR CUENTA</a>");
            out.println("</CENTER>");
            out.println("</BODY>");
            out.println("</HTML>");
            out.flush();
            out.close();
        } else {
            try {
                if (!GestorUsuario.getInstance().comprobarPassword(email, password)) {
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
                    out.println("<p>Contraseña incorrecta:");
                    out.println("<br>");
                    out.println("<br>");
                    out.println("<a href=" + path + ">VOLVER</a>");
                    out.println("</CENTER>");
                    out.println("</BODY>");
                    out.println("</HTML>");
                    out.flush();
                    out.close();
                } else {
                    HttpSession s = request.getSession(true);
                    s.setAttribute("Usuario", email);
                    response.sendRedirect("MiCuenta.jsp");
                }
            } catch (IOException ex) {
                System.out.println("Se ha producido una SQLException");
            }
        }
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
            Logger.getLogger(SrvLogin.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(SrvLogin.class.getName()).log(Level.SEVERE, null, ex);
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