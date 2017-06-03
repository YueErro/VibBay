<%--
    Document   : Anuncio
    Created on : 24-dic-2016, 19:04:22
    Author     : YI
--%>

<%@page import="packBD.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="packModelo.Articulo"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>VibBay - Anuncio</title>
        <link rel="shortcut icon" type="image/x-icon" href="img/Logo.jpg" />
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
                <% if (session.getAttribute("Usuario") != null ) {
                    String nombre = GestorUsuario.getInstance().mostrarPerfil(session.getAttribute("Usuario").toString()).getNick();
                    String genero = GestorUsuario.getInstance().mostrarPerfil(session.getAttribute("Usuario").toString()).getGenero();
                    String foto = GestorUsuario.getInstance().mostrarPerfil(session.getAttribute("Usuario").toString()).getFoto();
                %>
                <div class="fotoU" style="background-image: url('img/fotosPerfil/<%=foto%>')">
                </div>
                <% if(genero.equalsIgnoreCase("Femenino")){
                %>
                <h2>Bienvenida <%=nombre%></h2>
                <% } else {
                %>
                <h2>Bienvenido <%=nombre%></h2>
                <% } } %>
                <link type="text/css" rel="stylesheet" href="css/navegador.css" />
            </nav>
        </header>
        <br>
        <%
            Integer codigo = Integer.parseInt(request.getParameter("codArticulo"));
            Articulo a = GestorArticulo.getInstance().buscarArticulo(codigo);
        %>
        <div>
            <center>
                <t1 id="nombre"><%= a.getNombre()%></t1>
                <br>
                <br>
                <img id="imagen" src="img/fotosProductos/<%= a.getImagen()%>" width="30%">
                <br>
                <br>
                <t2>Categoría:</t2>
                <br>
                <t3 id="categoria"><%if( a.getCategoria().equalsIgnoreCase("Electronica") ){ %>Electrónica
                    <% } else{ %><%= a.getCategoria()%><% } %></t3>
                <br>
                <br>
                <t2>Descripción del producto:</t2>
                <br>
                <t3 id="descripcion"><%= a.getDescripcion()%></t3>
                <br>
                <br>
                <%
                    DecimalFormat df = new DecimalFormat("###,##0.00");
                    String pre = df.format(a.getPrecio());

                %> 
                <t2>Precio de salida:</t2>
                <br>
                <t3 id="precio"><%= pre + " " + "€"%></t3>
                <br>
                <br>
                <t2>Vendedor:</t2>
                <br>
                <t3 id="vendedor"><%= a.getEmail()%></t3>
                <br>
                <br>
                <t2>Fecha de publicación:</t2>
                <br>
                <t3 id="fecha"><%= a.getFecha()%></t3>
                <br>
                <br>
                <%
                    String pree = df.format(GestorPuja.getInstance().maxPuja(codigo));
                    
                    if( a.getEstado().equalsIgnoreCase("Cerrado"))
                    {
                %>      
                <t2>Vendido por:</t2>
                    <%
                        }
                        else
                        {
                    %>
                <t2>Precio mínimo a pujar:</t2>
                    <%
                        }
                    %>
                <br>
                <t3 id="precio"><%= pree + " " + "€"%></t3>

            </center>
            <link type="text/css" rel="stylesheet" href="css/listaAnuncios.css" />
        </div>
        <br>
        <footer>
            <nav id="navInf">
                <div class="circulo">YI</div>
                <div class="copyright">Copyright © 2016, YI. Enterprise</div>
                <link type="text/css" rel="stylesheet" href="css/navegador.css" />
            </nav>
        </footer>
    </body>
</html>