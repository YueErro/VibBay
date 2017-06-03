<%-- 
    Document   : Login
    Created on : 05-dic-2016, 21:24:11
    Author     : YI
--%>

<%@page import="packBD.GestorUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>VibBay - Iniciar sesión</title>
        <link rel="shortcut icon" type="image/x-icon" href="img/Logo.jpg" />
        <script type="text/javascript" src="js/ValidarLogin.js"></script>
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
                    }%>
                <link type="text/css" rel="stylesheet" href="css/navegador.css" />
            </nav>
        </header>
        <br>
        <section>
            <form id="buscador" action="ListaAnuncios.jsp" method="get">
                <select required>
                    <option value="" disabled selected hidden>-Seleccione categoría-</option>
                    <option value="Electronica">Electrónica</option>
                    <option>Moda y Belleza</option>
                    <option>Otros</option>
                </select>
                <input id="search" type="text" placeholder="Estoy buscando...">
                <input id="submit" type="submit" value="Buscar">
            </form>
            <link type="text/css" rel="stylesheet" href="css/infor.css" />
            <center>
                <form action="SrvLogin" name="logueo" method="post">
                    <br>
                    <br>
                    <div id="cont2">
                        <h1> Iniciar sesión </h1>
                        <h2> Correo </h2>
                        <input type="text" name="correo" id="correo" size="30" maxlength="30" placeholder="ej. vibbay@gmail.com">
                        <br>
                        <br>
                        <h3> Password </h3>
                        <input type="password" name="clave" id="clave" size="30" maxlength="16" placeholder="4-16 caracteres">
                        <br>
                        <br>
                        <input type="submit" name="loguear" id="loguear" value="Iniciar sesión" onclick="return comprobarLogin()">
                        <br>
                        <br>
                        <h3> ¿Eres nuevo cliente? </h3>
                        <a href="Registro.jsp">
                            <input type="button" value="Crear cuenta de VibBay">
                        </a>
                    </div>
                    <link type="text/css" rel="stylesheet" href="css/reg.css" />
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