/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package packServlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import packBD.*;

/**
 *
 * @author YI
 */
@WebServlet(name = "SrvCambiarEstado", urlPatterns = {"/SrvCambiarEstado"})
public class SrvCambiarEstado extends HttpServlet {

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
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String email = request.getSession().getAttribute("Usuario").toString();
            System.out.println(email);
            int codigo = Integer.parseInt(request.getSession().getAttribute("codigo").toString());
            System.out.println(codigo);

            try {
                GestorArticulo.getInstance().cambiarEstado(email, codigo);

                String path = "'MiCuenta.jsp'";
                response.setContentType("text/html");

                out.println("<HTML>");
                out.println("<HEAD>");
                out.println("<TITLE>Cerrado</TITLE>");
                out.println("</HEAD>");
                out.println("<BODY>");
                out.println("<CENTER>");
                out.println("<br>");
                out.println("<p>Ya no se pude pujar por este artículo:");
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
        processRequest(request, response);
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
        processRequest(request, response);
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