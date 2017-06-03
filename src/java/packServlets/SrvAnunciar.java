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
import java.util.Date;
import javax.servlet.annotation.WebServlet;
import javax.servlet.*;
import javax.servlet.http.*;
import packBD.*;

/**
 *
 * @author YI
 */
@WebServlet(name = "SrvAnunciar", urlPatterns = {"/SrvAnunciar"})
public class SrvAnunciar extends HttpServlet {

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
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MultipartRequest mr = new MultipartRequest(request, getPath() + "web/img/fotosProductos");
        String imagen = mr.getFilesystemName("foto");
        String nombre = mr.getParameter("nombre");
        String categoria = mr.getParameter("categoria");
        String descripcion = mr.getParameter("descripcion");
        String pre = mr.getParameter("preciomin");
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
        double precio = Double.parseDouble(pree);
        Date fecha = new Date();
        DateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        String email = request.getSession().getAttribute("Usuario").toString();

        try {
            GestorArticulo.getInstance().publicarArticulo(email, imagen, nombre, categoria, descripcion, precio, format.format(fecha));

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
            out.println("<TITLE>Publicado</TITLE>");
            out.println("</HEAD>");
            out.println("<BODY>");
            out.println("<CENTER>");
            out.println("<br>");
            out.println("<p>Artículo publicado correctamente:");
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

    private String getPath() throws UnsupportedEncodingException {
        String path = this.getClass().getClassLoader().getResource("").getPath();
        String fullPath = URLDecoder.decode(path, "UTF-8");
        String pathArr[] = fullPath.split("build/web/WEB-INF/classes/");
        fullPath = pathArr[0];
        String reponsePath;
        reponsePath = new File(fullPath).getPath() + File.separatorChar;
        return reponsePath;
    }
}
