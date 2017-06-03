<%-- 
    Document   : Informacion
    Created on : 05-dic-2016, 21:30:42
    Author     : YI
--%>

<%@page import="packBD.GestorUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>VibBay - Información</title>
        <link rel="shortcut icon" type="image/x-icon" href="img/Logo.jpg" />
    </head>
    <body>
        <header>
            <nav>
                <ul>
                    <li><%if(session.getAttribute("Usuario")==null){ %><a href="Login.jsp">Iniciar Sesión</a>
                        <%}else{%><a href="SrvLogout"> Cerrar Sesión<% } %></a></li>
                    <li><a <%if(session.getAttribute("Usuario")==null){ %>href="Login.jsp"
                                                                          <%}else{%>href="Anunciar.jsp"<% } %>>Anunciar</a></li>
                    <li><a <%if(session.getAttribute("Usuario")==null){ %>href="Login.jsp"
                                                                          <%}else{%>href="MiCuenta.jsp"<% } %>>Mi Cuenta</a></li>
                    <li><a href="Informacion.jsp">Información</a></li>

                    <li><a <%if(session.getAttribute("Usuario")==null){ %>href="Inicio.jsp"
                                                                          <%}else{%>href="ListaAnuncios.jsp"<% } %>>Inicio</a></li>
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
        <div id='bloque1'>
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
            <div><center>
                    <h1>VibBay Grupo02:</h1>
                    <pre style="font-family: 'Raleway'; font-size: 1.2em">
        VibBay es un marketplace digital multiplataforma a través del cual particulares y profesionales pueden buscar y pujar por artículos
        y servicios en distintas categorías. VibBay es propiedad de YI. Enterprise, compañía que forman Yue Erro e Itziar Egiluz.
                    </pre>
                </center>
            </div>
            <div id='bloque'>
                <center><h1>Contacto:</h1></center>
                <div class='A'>
                    <h3 style="color: #0A7492">Yue Erro</h3>
                    <pre style="font-family: 'Raleway'; font-size: 1.2em">
C/ Nieves Cano nº 12
01006 Vitoria-Gasteiz, Araba
yerro001@ikasle.ehu.eus

Tlf: 945 01 32 05
Fax: 945 01 32 70 
                    </pre>
                </div>
                <div class='B'>
                    <h3 style="color: #0A7492">Itziar Egiluz</h3>
                    <pre style="font-family: 'Raleway'; font-size: 1.2em">
C/ Nieves Cano nº 12
01006 Vitoria-Gasteiz, Araba
ieguiluz008@ikasle.ehu.eus

Tlf: 945 01 32 05
Fax: 945 01 32 70 
                    </pre>
                </div>
            </div>
            <link type="text/css" rel="stylesheet" href="css/infor.css" />
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