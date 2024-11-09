<%-- 
    Document   : registro
    Created on : 9 nov 2024, 7:40:19 a.m.
    Author     : jason
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@page import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet, Servlets.ConexionBaseDatos"%>
        <title>Registro</title>
    </head>
    <body>
        <h1>Registre algun libro</h1>
        
         <div class="mostrardatos">
                <table>
                    <thead>
                        <tr>
                            <%
                                String tipoConsulta = request.getParameter("consulta");
                                if ("libro".equals(tipoConsulta) || "agregarLibro".equals(tipoConsulta)) {
                            %>
                            <th scope="col" class="mostrar">isbn</th>
                            <th scope="col" class="mostrar">Titulo</th>
                            <th scope="col" class="mostrar">Año de publicacion</th>
                            <th scope="col" class="mostrar">Autor</th>
                            <th scope="col" class="mostrar">Clasificacion</th>
                            <th scope="col" class="mostrar">cantidad de paginas</th>
                            <% if ("editarUsuarios".equals(tipoConsulta)) { %>
                                <th scope="col" class="mostrar">Acciones</th>
                            <% } %>
                                <%
                                } else if ("inventario".equals(tipoConsulta) || "editarInventario".equals(tipoConsulta)) {
                                %>
                            <th scope="col" class="mostrar">ID</th>
                            <th scope="col" class="mostrar">Producto</th>
                            <th scope="col" class="mostrar">Cantidad</th>
                            <th scope="col" class="mostrar">Precio</th>
                            <% if ("editarInventario".equals(tipoConsulta)) { %>
                                <th scope="col" class="mostrar">Acciones</th>
                            <% } %>
                                <%
                                }
                                %>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            // Mostrar formulario para agregar nuevo usuario o producto en modo edición
                            if ("editarLibro".equals(tipoConsulta)) { 
                        %>
                        <tr>
                            <form action="RegistroServlet" method="post">
                            
                                <td><input type="text" name="isbn" placeholder="isbn del libro" required></td>
                                <td><input type="text" name="nombre" placeholder="Nombre del libro" required></td>
                                <td><input type="text" name="anio" placeholder="Año de publicacion" required></td>
                                <td><input type="text" name="autor" placeholder="Autor" required></td>
                                <td><input type="text" name="clasificacion" placeholder="Clasificacion" required></td>
                                <td><input type="text" name="paginas" placeholder="Cantidad de paginas" required></td>
                  
                                <td><button type="submit" class="agregar">Agregar Libro</button></td>
                            </form>
                        </tr>
                      
                        
                        <%
                            String query = "";
                            if ("libro".equals(tipoConsulta) || "agregarLibro".equals(tipoConsulta)) {
                                query = "SELECT isbn, titulo_libro, anio_publicacion, autor, clasificacion, cantidad_paginas tipo FROM libro";
                            } else if ("inventario".equals(tipoConsulta) || "editarInventario".equals(tipoConsulta)) {
                                query = "SELECT id, nombre_producto, cantidad, precio FROM inventario";
                            }

                            if (!query.isEmpty()) {
                                try {
                                    Connection con = ConexionBaseDatos.getConnection();
                                    Statement st = con.createStatement();
                                    ResultSet rs = st.executeQuery(query);

                                    while (rs.next()) {
                                        if ("libro".equals(tipoConsulta) || "agregarLibro".equals(tipoConsulta)) {
                        %>
                        <tr>
                            <form action="ResgistroServlet" method="post">
                                
                                <td class="detalles"><input type="text" name="isbn" value="<%= rs.getString("isbn") %>" <% if (!"agregarLibro".equals(tipoConsulta)) { %>readonly<% } %>></td>
                                <td class="detalles"><input type="text" name="titulo" value="<%= rs.getString("titulo_libro") %>" <% if (!"agregarLibro".equals(tipoConsulta)) { %>readonly<% } %>></td>
                                <td class="detalles"><input type="text" name="anio" value="<%= rs.getString("anio_publicacion") %>" <% if (!"agregarLibro".equals(tipoConsulta)) { %>readonly<% } %>></td>
                                <td class="detalles"><input type="text" name="autor" value="<%= rs.getString("autor") %>" <% if (!"agregarLibro".equals(tipoConsulta)) { %>readonly<% } %>></td>
                                <td class="detalles"><input type="text" name="clasificacion" value="<%= rs.getString("clasificacion") %>" <% if (!"agregarLibro".equals(tipoConsulta)) { %>readonly<% } %>></td>
                                <td class="detalles"><input type="text" name="paginas" value="<%= rs.getString("cantidad_paginas") %>" <% if (!"agregarLibro".equals(tipoConsulta)) { %>readonly<% } %>></td>
                                
                                <% if ("editarUsuarios".equals(tipoConsulta)) { %>
                                    <td>
                                        <button type="submit" name="action" value="update" class="modificar">Actualizar</button>
                                        <button type="submit" name="action" value="delete" class="modificar1">Eliminar</button>
                                    </td>
                                <% } %>
                            </form>
                        </tr>
                        <%
                        } else if ("inventario".equals(tipoConsulta) || "editarInventario".equals(tipoConsulta)) {
                        %>
                        <tr>
                            <form action="EditarInventarioServlet" method="post">
                                <td class="detalles"><input type="hidden" name="id" value="<%= rs.getInt("id") %>"><%= rs.getInt("id") %></td>
                                <td class="detalles"><input type="text" name="nombre_producto" value="<%= rs.getString("nombre_producto") %>" <% if (!"editarInventario".equals(tipoConsulta)) { %>readonly<% } %>></td>
                                <td class="detalles"><input type="text" name="cantidad" value="<%= rs.getInt("cantidad") %>" <% if (!"editarInventario".equals(tipoConsulta)) { %>readonly<% } %>></td>
                                <td class="detalles"><input type="text" name="precio" value="<%= rs.getDouble("precio") %>" <% if (!"editarInventario".equals(tipoConsulta)) { %>readonly<% } %>></td>
                                <% if ("editarInventario".equals(tipoConsulta)) { %>
                                    <td>
                                        <button type="submit" name="action" value="update" class="modificar">Actualizar</button>
                                        <button type="submit" name="action" value="delete" class="modificar1">Eliminar</button>
                                    </td>
                                <% } %>
                            </form>
                        </tr>
                        <%
                                        }
                                    }
                                    con.close();
                                } catch (Exception e) {
                                    out.println("Error en la consulta: " + e.getMessage());
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        
        
        <div>
            <button type="submit" name="libro" value="libro" class="dato">Registrar libro</button>
        </div>
    </body>
</html>
