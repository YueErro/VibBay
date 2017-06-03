/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package packServlets;

import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import packBD.*;
import packModelo.*;

/**
 *
 * @author YI
 */
@WebServlet(name = "SrvPujar", urlPatterns = {"/SrvPujar"})
public class SrvPujar extends HttpServlet {

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
            int codigo = Integer.parseInt(request.getParameter("codArticulo"));
            String pre = request.getParameter("pujaMax");
            String pree = "";
            char car;
            for (int i = 0; i < pre.length(); i++) {
                car = pre.charAt(i);
                switch (car) {
                    case ',':
                        pree = pree + ".";
                    case '.':
                        pree = pree + "";
                        break;
                    default:
                        pree = pree + car;
                        break;
                }
            }
            double cantidad = Double.parseDouble(pree);
            String email = request.getSession().getAttribute("Usuario").toString();
            Date date = new Date();
            DateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            double ps = GestorArticulo.getInstance().buscarArticulo(codigo).getPrecio();
            double precio = GestorPuja.getInstance().maxPuja(codigo);
            if (precio == 0.00) {
                if (cantidad < ps) {
                    String path = "'ListaAnuncios.jsp'";
                    response.setContentType("text/html");

                    out.println("<HTML>");
                    out.println("<HEAD>");
                    out.println("<TITLE>Error</TITLE>");
                    out.println("</HEAD>");
                    out.println("<BODY>");
                    out.println("<CENTER>");
                    out.println("<br>");
                    out.println("<p>Lo sentimos, pero la puja máxima tiene que ser superior al precio actual:");
                    out.println("<br>");
                    out.println("<br>");
                    out.println("<a href=" + path + ">LISTA DE ANUNCIOS</a>");
                    out.println("</CENTER>");
                    out.println("</BODY>");
                    out.println("</HTML>");
                    out.flush();
                    out.close();
                } else {
                    try {
                        GestorPuja.getInstance().pujar(format.format(date), email, codigo, cantidad);

                        String path = "'MiCuenta.jsp'";
                        response.setContentType("text/html");

                        out.println("<HTML>");
                        out.println("<HEAD>");
                        out.println("<TITLE>Pujado</TITLE>");
                        out.println("</HEAD>");
                        out.println("<BODY>");
                        out.println("<CENTER>");
                        out.println("<br>");
                        out.println("<p>Puja realizada correctamente:");
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
            else{
                if (cantidad <= precio) {
                    String path = "'ListaAnuncios.jsp'";
                    response.setContentType("text/html");

                    out.println("<HTML>");
                    out.println("<HEAD>");
                    out.println("<TITLE>Error</TITLE>");
                    out.println("</HEAD>");
                    out.println("<BODY>");
                    out.println("<CENTER>");
                    out.println("<br>");
                    out.println("<p>Lo sentimos, pero la puja máxima tiene que ser superior a la puja máxima:");
                    out.println("<br>");
                    out.println("<br>");
                    out.println("<a href=" + path + ">LISTA DE ANUNCIOS</a>");
                    out.println("</CENTER>");
                    out.println("</BODY>");
                    out.println("</HTML>");
                    out.flush();
                    out.close();
                } else {
                    try {
                        GestorPuja.getInstance().pujar(format.format(date), email, codigo, cantidad);

                        String path = "'MiCuenta.jsp'";
                        response.setContentType("text/html");

                        out.println("<HTML>");
                        out.println("<HEAD>");
                        out.println("<TITLE>Pujado</TITLE>");
                        out.println("</HEAD>");
                        out.println("<BODY>");
                        out.println("<CENTER>");
                        out.println("<br>");
                        out.println("<p>Puja realizada correctamente:");
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
