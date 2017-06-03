<%-- 
    Document   : MiCuenta
    Created on : 05-dic-2016, 21:27:22
    Author     : YI
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="packBD.*"%>
<%@page import="packModelo.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>VibBay - Mi Cuenta</title>
        <link rel="shortcut icon" type="image/x-icon" href="img/Logo.jpg" />
        <script type="text/javascript" src="js/pestañas.js"></script>
        <script type="text/javascript" src="js/ValidarPerfil.js"></script>
        <script type="text/javascript" src="js/fotoPerfil.js"></script>
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
                    } %>
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
        <div>
            <table class="tabs" data-min="0" data-max="2">
                <tr>
                    <th class="tabcks">&nbsp;</th>
                    <th class="tabck" id="tabck-0" onclick="activarTab(this)" >Mis artículos</th>
                    <th class="tabcks">&nbsp;</th>
                    <th class="tabck" id="tabck-1" onclick="activarTab(this)">Mis pujas</th>
                    <th class="tabcks">&nbsp;</th>
                    <th class="tabck" id="tabck-2" onclick="activarTab(this)">Mi perfil</th>
                </tr>
                <tr class="filadiv">
                    <td colspan="6" id="tab-0">
                        <div class="tabdiv" id="tabdiv-0">
                            <table border="1" width="1300">
                                <tr bgcolor="#83afb7">
                                    <th>Imagen</th>
                                    <th width="150">Nombre</th>
                                    <th width="110">Categoría</th>
                                    <th width="450">Descripción</th>
                                    <th width="100">Precio (€)</th>
                                    <th width="80">Estado</th>
                                    <th width="80">Pujas</th>
                                    <th width="80"></th>
                                </tr>   
                                <%
                                    ArrayList<Articulo> a = GestorArticulo.getInstance().misArticulos(session.getAttribute("Usuario").toString());

                                    for (int i = 0; i < a.size(); i++) {
                                %>
                                <tr>
                                    <td><center><img src="img/fotosProductos/<%= a.get(i).getImagen()%>" width="200" ></center></td>
                                <td><center><%= a.get(i).getNombre()%></center></td>
                                <td><center> <%if (a.get(i).getCategoria().equalsIgnoreCase("Electronica")) { %>Electrónica
                                    <% } else {%>
                                    <%= a.get(i).getCategoria()%><% }%>
                                </center></td>
                                <td><center><%= a.get(i).getDescripcion()%></center></td>

                                <%
                                    int codigo = a.get(i).getCodigo();
                                    String pree;

                                    if (GestorPuja.getInstance().maxPuja(codigo) == 0.00) {
                                        DecimalFormat df = new DecimalFormat("###,##0.00");
                                        pree = df.format(a.get(i).getPrecio());
                                    } else {
                                        DecimalFormat df = new DecimalFormat("###,##0.00");
                                        pree = df.format(GestorPuja.getInstance().maxPuja(codigo));
                                    }
                                %>
                                <td><center><%= pree%></center></td>
                                    <% if (a.get(i).getEstado().equalsIgnoreCase("Cerrado")) {%>
                                <td><center><%= a.get(i).getEstado()%></center></td>
                                    <% } else {%>
                                <form id="Enpuja" action="SrvEstado" method="get">
                                    <label for="cod"></label>
                                    <input type="hidden" name="cod" id="cod" value="<%= a.get(i).getCodigo()%>" />
                                    <td><center><input type="submit" name="enpuja" id="enpuja" value="En puja"></center></td>
                                </form>
                                <% }
                                    ArrayList<Puja> p = GestorPuja.getInstance().buscarPujas(codigo);

                                    if (!p.isEmpty()) {
                                %>
                                <form id="pujasAsociadas" action="PujasAsociadas.jsp" method="get">
                                    <label for="codArticulo"></label>
                                    <input type="hidden" name="codArticulo" id="codArticulo" value="<%= a.get(i).getCodigo()%>" />
                                    <td><center><a href="PujasAsociadas.jsp"><input type="submit" name="Consultar" id="Consultar" value="Consultar"></a></center></td>
                                </form>
                                <%  } else {%>
                                <td><center><input type="button" name="Consultar" id="Consultar" disabled="truen" value="Consultar"></a></center></td>
                                    <%  }

                                        if (p.isEmpty()) {
                                    %>
                                <form id="Modificar" action="ModificarArticulo.jsp" method="get">
                                    <label for="codArticulo"></label>
                                    <input type="hidden" name="codArticulo" id="codArticulo" value="<%= a.get(i).getCodigo()%>" />
                                    <td><center><a href="ModificarArticulo.jsp"><input type="submit" name="codArticulo" id="codArticulo" value="Modificar"></a></center></td>
                                </form>
                                <%  } else {
                                %>
                                <td><center><input type="button" name="Modificar" id="Modificar" disabled="truen" value="Modificar"></a></center></td>
                                    <%  }%>
                                </tr>
                                <%
                                    }
                                %>
                            </table>
                        </div>
                        <div class="tabdiv" id="tabdiv-1">
                            <table border="1" width="1300">
                                <tr bgcolor="#83afb7">
                                    <th width="400">Fecha</th>
                                    <th width="200">Artículo</th>
                                    <th width="400">Cantidad (€)</th>
                                    <th width="400">Estado</th>
                                </tr>   
                                <%
                                    ArrayList<Puja> p = GestorPuja.getInstance().misPujas(session.getAttribute("Usuario").toString());

                                    for (int i = 0; i < p.size(); i++) {
                                %>
                                <tr>
                                    <td><center><%= p.get(i).getFecha()%></center></td>
                                <form id="Anuncio" action="Anuncio.jsp" method="get">
                                    <label for="codArticulo"></label>
                                    <input type="hidden" name="codArticulo" id="codArticulo" value="<%= p.get(i).getCodArticulo()%>" />
                                    <td><center><a href="Anuncio.jsp"><input type="submit" name="codArticulo" id="codArticulo" value="<%= p.get(i).getCodArticulo()%>"></a></center></td>
                                </form>
                                <%
                                    DecimalFormat df = new DecimalFormat("###,##0.00");
                                    String pree = df.format(p.get(i).getCantidad());
                                %>
                                <td><center><%= pree%></h4></td>
                                    <td><center>
                                        <%
                                            if (GestorArticulo.getInstance().buscarArticulo(p.get(i).getCodArticulo()).getEstado().equalsIgnoreCase("En puja")) {
                                                if (p.get(i).getCantidad() == GestorPuja.getInstance().maxPuja(p.get(i).getCodArticulo())) { %>
                                        <h4 style="font-size: 1em">Última puja</h4>
                                        <%  } else {%>
                                        <h4 style="font-size: 1em">Puja superada</h4>
                                        <% }
                                        } else {
                                            if (p.get(i).getCantidad() == GestorPuja.getInstance().maxPuja(p.get(i).getCodArticulo())) {%>
                                        <h4 style="font-size: 1em">Puja ganadora</h4>
                                        <% } else {%>
                                        <h4 style="font-size: 1em">Artículo vendido</h4>
                                        <% }
                                            } %>
                                    </center></td>
                                    </tr>
                                    <%
                                        }
                                    %>
                            </table>
                        </div>
                        <div class="tabdiv" id="tabdiv-2">
                            <center>
                                <form action="SrvPerfil" method="post" enctype="multipart/form-data">
                                    <div id="contenedor">
                                        <br>
                                        <h6> <%= session.getAttribute("Usuario")%> </h6>
                                        <br>
                                        <div class="esp">
                                            <h6 style="font-size: 1.1em">
                                                <label for="nick" class="esp">Nick</label>
                                                <input type="text" name="nick" id="nick" size="15"  maxlength="16"
                                                       value="<%= GestorUsuario.getInstance().mostrarPerfil(session.getAttribute("Usuario").toString()).getNick()%>" class="esp"/>
                                            </h6>

                                            <div class="esp">
                                                <h6 style="font-size: 1.1em">
                                                    <label for="dni" class="esp">DNI</label>
                                                    <input type="text" name="dni" id="dni" size="15" maxlength="9"
                                                           <% if (GestorUsuario.getInstance().mostrarPerfil(session.getAttribute("Usuario").toString()).getDni() != null) {%>
                                                           value="<%= GestorUsuario.getInstance().mostrarPerfil(session.getAttribute("Usuario").toString()).getDni()%>"
                                                           <% } else { %>
                                                           placeholder="ej. 98765432D" <% }%> class="esp" />
                                                </h6>
                                            </div>
                                            <div class="esp">
                                                <h6 style="font-size: 1.1em">
                                                    <label for="clave" class="esp">Password</label>
                                                    <input type="text" name="clave" id="clave" size="15" maxlength="16"
                                                           value="<%= GestorUsuario.getInstance().mostrarPerfil(session.getAttribute("Usuario").toString()).getPass()%>" class="esp"/>
                                                </h6>
                                            </div>
                                            <div class="esp">
                                                <h6 style="font-size: 1.1em">
                                                    <label for="fnac" class="esp">Fecha de nacimiento</label>
                                                    <input type="date" name="fnac" id="fnac"
                                                           <% if (GestorUsuario.getInstance().mostrarPerfil(session.getAttribute("Usuario").toString()).getFnac() != null) {%>
                                                           value="<%= GestorUsuario.getInstance().mostrarPerfil(session.getAttribute("Usuario").toString()).getFnac()%>"
                                                           <% } else { %>
                                                           value="" <% } %>  class="esp"/>
                                                </h6>
                                            </div>
                                            <div class="gen">
                                                <h6 style="font-size: 1.1em">
                                                    <label for="genero">Género</label>
                                                    <input type="radio" name="genero" id="genero" value="Masculino"
                                                           <% if (GestorUsuario.getInstance().mostrarPerfil(session.getAttribute("Usuario").toString()).getGenero().equalsIgnoreCase("Masculino")) { %> checked="" <% } %> class="gen" /> Masculino
                                                    <input type="radio" name="genero" id="genero" value="Femenino"
                                                           <% if (GestorUsuario.getInstance().mostrarPerfil(session.getAttribute("Usuario").toString()).getGenero().equalsIgnoreCase("Femenino")) { %> checked="" <% }%> class="gen" /> Femenino
                                                </h6>
                                            </div>
                                            <div class="esp">
                                                <h6 style="font-size: 1.1em">
                                                    <label for="tlf" class="esp">Teléfono</label>
                                                    <input type="text" name="tlf" id="tlf" size="15" maxlength="9"
                                                           value="<%= GestorUsuario.getInstance().mostrarPerfil(session.getAttribute("Usuario").toString()).getTlf()%>" class="esp"/>
                                                </h6>
                                            </div>
                                            <h6 style="font-size: 1.1em">
                                                <label for="foto">Foto de perfil</label> </h6>
                                            <br>
                                            <input type="file" id="foto" name="foto" class="hidden">
                                            <br>
                                            <div id="caja" style="background-image: url('img/fotosPerfil/<%= GestorUsuario.getInstance().mostrarPerfil(session.getAttribute("Usuario").toString()).getFoto()%>')">   
                                            </div>
                                            <br>
                                            <input type="submit" name="Actualizar" id="Actualizar" value="Actualizar" onclick="return comprobarPerfil()" >
                                        </div>
                                        <link type="text/css" rel="stylesheet" href="css/reg.css" />
                                    </div>
                                </form>
                            </center>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <link type="text/css" rel="stylesheet" href="css/listaAnuncios.css" />
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
