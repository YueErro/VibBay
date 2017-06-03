<%-- 
    Document   : ModificarArticulo
    Created on : 22-dic-2016, 10:18:24
    Author     : YI
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="packModelo.*"%>
<%@page import="packBD.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>VibBay - Modificar Articulo</title>
        <link rel="shortcut icon" type="image/x-icon" href="img/Logo.jpg" />
        <script src="js/fotoArticulo.js"></script>
        <script type="text/javascript" src="js/ValidarAnunciar.js"></script>
    </head>
    <body>
        <header>
            <nav>
                <ul>
                    <li><%if (session.getAttribute("Usuario") == null) { %><a href="Login.jsp">Iniciar Sesión</a>
                        <%} else {%> <a href="SrvLogout"> Cerrar Sesión<% } %></a></li>
                    <li><a <%if (session.getAttribute("Usuario") == null) { %>href="Login.jsp"
                                                                              <%} else {%>href="Anunciar.jsp"<% } %>>Anunciar</a></li>
                    <li><a <%if (session.getAttribute("Usuario") == null) { %>href="Login.jsp"
                                                                              <%} else {%>href="MiCuenta.jsp"<% } %>>Mi Cuenta</a></li>
                    <li><a href="Informacion.jsp">Información</a></li>

                    <li><a <%if (session.getAttribute("Usuario") == null) { %>href="Inicio.jsp"
                                                                              <%} else {%>href="ListaAnuncios.jsp"<% }%>>Inicio</a></li>
                </ul>
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
                <link type="text/css" rel="stylesheet" href="css/navegador.css"/>
            </nav>
        </header>
        <br>
        <section>
            <form id="buscador" action="ListaAnuncios.jsp" method="get">
                <select name = "categoria" required>
                    <option value="" disabled selected hidden>-Seleccione categoría-</option>
                    <option value="Electronica">Electrónica</option>
                    <option>Moda y Belleza</option>
                    <option>Otros</option>
                </select>
                <input id="search" type="text" name = "nombre" placeholder="Estoy buscando...">
                <input id="submit" type="submit" value="Buscar">
            </form>
            <link type="text/css" rel="stylesheet" href="css/infor.css" />
            <center>
                <form action="SrvModificar" method="post" enctype="multipart/form-data">
                    <br>
                    <br>
                    <div id="cont">
                        <%
                            Integer codigo = Integer.parseInt(request.getParameter("codArticulo"));
                            Articulo a = GestorArticulo.getInstance().buscarArticulo(codigo);
                        %>
                        <h1> Modificar </h1>
                        <input type="file" id="foto" name="foto" class="hidden">
                        <div id="imagen" style="background-image: url('img/fotosProductos/<%= a.getImagen()%>')">
                        </div>
                        <input type="text" name="nombre" id="nombre" size="30" maxlength="30" value="<%= a.getNombre()%>">
                        <select id="categoria" name="categoria">
                            <% if (a.getCategoria().equals("Electronica")) { %>
                            <option selected="" value="Electronica">Electrónica</option>
                            <% } else { %>
                            <option value="Electronica">Electrónica</option>
                            <% }
                                if (a.getCategoria().equals("Moda y Belleza")) { %>
                            <option selected="">Moda y Belleza</option>
                            <% } else { %>
                            <option>Moda y Belleza</option>
                            <% }
                                if (a.getCategoria().equals("Otros")) { %>
                            <option selected="">Otros</option>
                            <% } else { %>
                            <option>Otros</option>
                            <% }%>
                        </select>
                        <br>
                        <br>
                        <textarea name="descripcion" id="descripcion" rows="5" cols="100" maxlength="485" style="font-family: sans-serif"><%= a.getDescripcion()%></textarea>
                        <br>
                        <br>
                        <%
                            DecimalFormat df = new DecimalFormat("###,##0.00");
                            String pree = df.format(a.getPrecio());
                        %>
                        <input type="text" name="preciomin" id="preciomin" value="<%= pree%>">€
                        <br>
                        <br>
                        <input type="hidden" name="codArticulo" id="codArticulo" value="<%= codigo%>" />
                        <input type="submit" name="modificar" id="modificar" value="Modificar "onclick="return comprobarAnuncio()">
                    </div>
                    <link type="text/css" rel="stylesheet" href="css/anun.css" />
                </form>
            </center>
            <br>
            <br>
        </section>
        <footer> 
            <nav id="navInf">
                <div class="circulo">YI</div>
                <div class="copyright">Copyright © 2016, YI. Enterprise</div>
                <link type="text/css" rel="stylesheet" href="css/navegador.css" />
            </nav>     
        </footer>
    </body>
</html>