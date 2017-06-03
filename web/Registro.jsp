<%-- 
    Document   : Registro
    Created on : 05-dic-2016, 21:22:13
    Author     : YI
--%>

<%@page import="packBD.GestorUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>VibBay - Registro</title>
        <link rel="shortcut icon" type="image/x-icon" href="img/Logo.jpg" />
        <link rel="stylesheet" href="css/reg.css">
        <script src="js/fotoPerfil.js"></script>
        <script type="text/javascript" src="js/ValidarRegistro.js"></script>
    </head>
    <body>
        <header>
            <nav>
                <ul>
                    <li><%if (session.getAttribute("Usuario") == null) { %><a href="Login.jsp">Iniciar Sesión</a>
                        <%} else {%><a href="SrvLogout"> Cerrar Sesión<% } %></a></li>
                    <li><a <%if (session.getAttribute("Usuario") == null) { %>href="Login.jsp"
                                                                              <%} else {%>href="Anunciar.jsp"<% } %>> Anunciar</a></li>
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
            <form id="buscador" action="ListaAnuncios.jsp" method="post">
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
            <center>
                <br>
                <form action="SrvRegistro" method="post" enctype="multipart/form-data">
                    <div id="contenedor">
                        <h1> Crear cuenta </h1>
                        <div class="esp">
                        <h6>
                            <label for="nick" class="esp">Nick</label>
                            <input type="text" name="nick" id="nick" size="15"  maxlength="16" placeholder="4-16 caracteres" class="esp"/>
                        </h6>
                        </div>    
                        <div class="esp">
                        <h6>
                            <label for="dni" class="esp">DNI</label>
                            <input type="text" name="dni" id="dni" size="15" maxlength="9" placeholder="ej. 98765432D" class="esp"/>
                        </h6>
                        </div>
                        <div class="esp">
                        <h6>
                            <label for="correo" class="esp">Correo</label>
                            <input type="text" name="correo" id="correo" size="30" maxlength="30" placeholder="ej. vibbay@gmail.com" class="esp"/>
                        </h6>
                        </div>    
                        <div class="esp">    
                        <h6>
                            <label for="clave" class="esp">Password</label>
                            <input type="password" name="clave" id="clave" size="15" maxlength="16" placeholder="4-16 caracteres" class="esp"/>
                        </h6>
                        </div>
                        <div class="esp">
                        <h6>
                            <label for="fnac" class="esp">Fecha de nacimiento</label>
                            <input type="date" name="fnac" id="fnac" value=" " class="esp">
                        </h6>
                        </div>   
                        <div class="gen">
                        <h6>
                            <label for="genero" class="gen">Género</label>
                            <input type="radio" name="genero" id="genero" value="Masculino" class="gen"/> Masculino
                            <input type="radio" name="genero" id="genero" value="Femenino" checked="" class="gen"/> Femenino
                        </h6>
                        </div>
                        <div class="esp">
                        <h6>
                            <label for="tlf" class="esp">Teléfono</label>
                            <input type="text" name="tlf" id="tlf" size="15" maxlength="9" placeholder="ej. 945000000" class="esp"/>
                        </h6>
                        </div>    
                        
                        <h6>
                            <label for="foto">Foto de perfil</label>
                            <br>
                            <input type="file" id="foto" name="foto" class="hidden">
                            <br>
                            <div id="caja"></div>       
                        </h6>
                        
                        <link type="text/css" rel="stylesheet" href="css/reg.css" />
                        <input type="submit" name="registrar" id="registrar" value="Crea tu cuenta de VibBay" onclick="return comprobarRegistro()">
                    </div>
                </form>
            </center>
        </section>
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