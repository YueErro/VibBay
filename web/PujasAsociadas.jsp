<%-- 
    Document   : Pujas
    Created on : 25-dic-2016, 17:20:59
    Author     : YI
--%>

<%@page import="packBD.GestorUsuario"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="packBD.GestorPuja"%>
<%@page import="packModelo.Puja"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>VibBay - Pujas realizadas</title>
        <link rel="shortcut icon" type="image/x-icon" href="img/Logo.jpg" />
        <script type="text/javascript" src="js/OrdenarTabla.js"></script>
    </head>
    <body>
        <header>
            <nav>
                <ul>
                    <li><%if (session.getAttribute("Usuario") == null) { %><a href="Login.jsp">Iniciar Sesión</a>
                        <%} else {%><a href="SrvLogout"> Cerrar Sesión<% } %></a></li>
                    <li><a <%if (session.getAttribute("Usuario") == null) { %>href="Login.jsp"
                                                                              <%} else {%>href="Anunciar.jsp"<% } %>>Anunciar</a></li>
                    <li><a <%if (session.getAttribute("Usuario") == null) { %>href="Login.jsp"
                                                                              <%} else {%>href="MiCuenta.jsp"<% } %>>Mi Cuenta</a></li>
                    <li><a href="Informacion.jsp">Información</a></li>

                    <li><a <%if (session.getAttribute("Usuario") == null) { %>href="Inicio.jsp"
                                                                              <%} else {%>href="ListaAnuncios.jsp"<% } %>>Inicio</a></li>
                </ul>
                <div class="atras">
                    <a href="MiCuenta.jsp"><img src="img/flecha.png" width="100%"></a>
                </div>
                <% if (session.getAttribute("Usuario") != null) {
                        String nombre = GestorUsuario.getInstance().mostrarPerfil(session.getAttribute("Usuario").toString()).getNick();
                        String genero = GestorUsuario.getInstance().mostrarPerfil(session.getAttribute("Usuario").toString()).getGenero();
                        String foto = GestorUsuario.getInstance().mostrarPerfil(session.getAttribute("Usuario").toString()).getFoto();
                %>
                <div class="fotoU" style="background-image: url('img/fotosPerfil/<%=foto%>')">
                </div>
                <% if (genero.equalsIgnoreCase("Femenino")) {
                %>
                <h2>Bienvenida <%=nombre%></h2>
                <% } else {
                %>
                <h2>Bienvenido <%=nombre%></h2>
                <% }
                    } %>
                <link type="text/css" rel="stylesheet" href="css/navegador.css" />
            </nav>
        </header>
        <br>
        <form id="buscador" action="ListaAnuncios.jsp" method="get">
            <select name = "categoria" required>
                <option value="" disabled selected hidden>-Seleccione categoría-</option>
                <option  value="Electronica">Electrónica</option>
                <option>Moda y Belleza</option>
                <option>Otros</option>
            </select>
            <input id="search" type="text" name = "nombre" placeholder="Estoy buscando...">
            <input id="submit" type="submit" value="Buscar">
        </form>
        <link type="text/css" rel="stylesheet" href="css/infor.css" />
        <br>
        <%
            int codigo = Integer.parseInt(request.getParameter("codArticulo"));
        %>
        <div>          
            <table border="1" width="1300" id="sorter">
                <tr bgcolor="#83afb7">
                    <th width="400"><h5><b>Fecha</b></h5></th>
                    <th width="400" class="nosort"><h5><b>Cantidad (€)</b></h5></th>
                    <th width="400"><h5><b>Pujador</b></h5></th>
                </tr>
                <%
                    ArrayList<Puja> p = GestorPuja.getInstance().buscarPujas(codigo);

                    for (int i = 0; i < p.size(); i++) {
                %>
                <tr>
                    <td><center><h4><%= p.get(i).getFecha()%></h4></center></td>
                    <%
                        DecimalFormat df = new DecimalFormat("###,##0.00");
                        String pree = df.format(p.get(i).getCantidad());
                    %>
                <td><center><h4><%= pree%></h4></center></td>
                <td><center><h4><%= p.get(i).getEmail()%></h4></center></td>
                </tr>
                <%
                    }
                %>
            </table>
            <br>
        </div>
        <script type="text/javascript">
            var sorter = new table.sorter("sorter");
            sorter.init("sorter", 1);
        </script>
        <footer> 
            <nav id="navInf">
                <div class="circulo">YI</div>
                <div class="copyright">Copyright © 2016, YI. Enterprise</div>
                <link type="text/css" rel="stylesheet" href="css/navegador.css" />
            </nav>       
        </footer>
    </body>
</html>