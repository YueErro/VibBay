<%-- 
    Document   : ListaAnuncios
    Created on : 05-dic-2016, 21:37:54
    Author     : YI
--%>

<%@page import="packBD.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="packModelo.Articulo"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>VibBay - Lista de anuncios</title>
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
                                                                              <%} else {%>href="ListaAnuncios.jsp"<% }%>>Inicio</a></li>
                </ul>
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
        <br>
        <%
            String nombre = request.getParameter("nombre");
            String categoria = request.getParameter("categoria");
        %>
        <div>
            <table border="1" width="1335">
                <tr bgcolor="#83afb7">
                    <th><h5><b>Imagen</b></h5></th>
                    <th width="150"><h5><b>Nombre</b></h5></th>
                    <th width="480"><h5><b>Descripción</b></h5></th>
                    <th width="100"><h5><b>Precio (€)</b></h5></th>
                    <th width="200"><h5><b>Vendedor</b></h5></th>
                    <th width="75"></th>
                </tr>
                <%
                    ArrayList<Articulo> a = GestorArticulo.getInstance().buscarArticulos( nombre, categoria );

                    for (int i = 0; i < a.size(); i++) 
                    {
                %>
                <tr>
                    <td><center><img id="foto" src="img/fotosProductos/<%= a.get(i).getImagen()%>" width="200" ></center></td>
                <td id="nombre"><center><h4><%= a.get(i).getNombre()%> </h4></center></td>
                <td><center><h4 id="descripcion"> <%= a.get(i).getDescripcion()%></h4></center></td>

                <%
                    int codigo = a.get(i).getCodigo();
                    String pree;
                            
                    if( GestorPuja.getInstance().maxPuja(codigo) == 0.00 )
                    {
                        DecimalFormat df = new DecimalFormat("###,##0.00");
                        pree = df.format(a.get(i).getPrecio());
                    }
                    else
                    {
                        DecimalFormat df = new DecimalFormat("###,##0.00");
                        pree = df.format(GestorPuja.getInstance().maxPuja(codigo));
                    }
                %>

                <td><center><h4><%= pree%></h4></center></td>
                <td><center><h4 id="correo"><%= a.get(i).getEmail()%></h4></center></td>
                    <% if( session.getAttribute("Usuario") == null || 
                            session.getAttribute("Usuario").toString().equalsIgnoreCase(a.get(i).getEmail()) )
                        { %>
                <td><center><input type="button" name="Pujar" id="Pujar" value="Pujar" disabled="true"></center></td>
                    <% }else{ %>
                <form id="pujaArticulo" action="Pujar.jsp" method="get">
                    <label for="codArticulo"></label>
                    <input type="hidden" name="codArticulo" id="codArticulo" value="<%= a.get(i).getCodigo()%>" />
                    <td><center><a href="Pujar.jsp"><input type="submit" name="Pujar" id="Pujar" value="Pujar"></a></center></td>
                </form>
                <% } %>
                </tr>
                <%
                    }
                %>
            </table>
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