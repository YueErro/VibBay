<%-- 
    Document   : Anuncio
    Created on : 05-dic-2016, 21:32:56
    Author     : YI
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="packBD.GestorUsuario"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="packBD.GestorArticulo"%>
<%@page import="packModelo.Articulo"%>
<%@page import="packBD.GestorPuja"%>
<%@page import="packModelo.Puja"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>VibBay - Pujar</title>
        <link rel="shortcut icon" type="image/x-icon" href="img/Logo.jpg" />
        <script type="text/javascript" src="js/ValidarPuja.js"></script>
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
                    <a href="ListaAnuncios.jsp"><img src="img/flecha.png" width="100%"></a>
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
                <t3 id="categoria"><%if (a.getCategoria().equalsIgnoreCase("Electronica")) { %>Electrónica
                    <% } else {%><%= a.getCategoria()%><% }%></t3>	
                <br>
                <br>
                <t2>Descripción del producto:</t2>
                <br>
                <t3 id="descripcion"><%= a.getDescripcion()%></t3>
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
                <t2>Pujas recibidas:</t2>
                <br>
                <%
                    ArrayList<Puja> pujas = GestorPuja.getInstance().buscarPujas(codigo);
                    int numPujas = 0;
                    for (int p = 0; p < pujas.size(); p++) {
                        numPujas++;
                    }
                %>
                <t3 id="numpujas"><%= numPujas%></t3>
                <br>
                <br>
                <%
                    String pree;

                    if (GestorPuja.getInstance().maxPuja(codigo) == 0.00) {
                        DecimalFormat df = new DecimalFormat("###,##0.00");
                        pree = df.format(a.getPrecio());
                    } else {
                        DecimalFormat df = new DecimalFormat("###,##0.00");
                        pree = df.format(GestorPuja.getInstance().maxPuja(codigo));
                    }
                %>
                <t2>Precio mínimo a pujar:</t2>
                <br>
                <t3 id="precio"><%= pree + " " + "€"%></t3>
                <br>
                <br>
                <form action="SrvPujar" method="post">
                    <t3>
                        <input type="text" name="pujaMax" id="pujaMax" required="true" placeholder="Introduce tu puja máxima">€
                    </t3>
                    <input type="hidden" name="codArticulo" id="codArticulo" value="<%= codigo%>" />
                    <input type="submit" name="pujar" id="pujar" value="Pujar" onclick="return comprobarPuja()">
                </form>
                <br>
            </center>
            <link type="text/css" rel="stylesheet" href="css/listaAnuncios.css" />
        </div>
        <footer> 
            <nav id="navInf">
                <div class="circulo">YI</div>
                <div class="copyright">Copyright © 2016, YI. Enterprise</div>
                <link type="text/css" rel="stylesheet" href="css/navegador.css" />
            </nav>       
        </footer>
    </body>
</html>