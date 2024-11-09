<%-- 
    Document   : menu
    Created on : 6 nov 2024, 1:51:57 a.m.
    Author     : jason
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet, Servlets.ConexionBaseDatos"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mostrar</title>
        <link rel="stylesheet" href="Estilos/menu.css">
    </head>
    <body>
        <h1>Libreria Online</h1>

        <div class="mostrardatos">
            <table>
                <thead>
                    <tr>
                        <%
                            String tipoConsulta = request.getParameter("consulta");
                            if ("libro".equals(tipoConsulta)) {
                        %>
                         <th scope="col" class="mostrar">isbn</th>
                            <th scope="col" class="mostrar">Titulo</th>
                            <th scope="col" class="mostrar">Año de publicacion</th>
                            <th scope="col" class="mostrar">Autor</th>
                            <th scope="col" class="mostrar">Clasificacion</th>
                            <th scope="col" class="mostrar">cantidad de paginas</th>
                            <%
                            } else if ("inventario".equals(tipoConsulta)) {
                            %>
                        <th scope="col" class="mostrar"></th>
                        <th scope="col" class="mostrar"></th>
                        <th scope="col" class="mostrar"></th>
                        <th scope="col" class="mostrar"></th>
                            <%
                                }
                            %>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String query = "";
                        if ("usuarios".equals(tipoConsulta)) {
                            query = "SELECT isbn, titulo_libro, anio_publicacion, autor, clasificacion, cantidad_paginas FROM libro";
                        } else if ("inventario".equals(tipoConsulta)) {
                            query = "SELECT id, nombre_producto, cantidad, precio FROM inventario";
                        }

                        if (!query.isEmpty()) {
                            try {
                                Connection con = ConexionBaseDatos.getConnection();
                                Statement st = con.createStatement();
                                ResultSet rs = st.executeQuery(query);

                                while (rs.next()) {
                                    if ("libro".equals(tipoConsulta)) {
                    %>
                    <tr>
                        <td class="detalles"><%= rs.getInt("isbn")%></td>
                        <td class="detalles"><%= rs.getString("titulo_libro")%></td>
                        <td class="detalles"><%= rs.getString("anio_publicacion")%></td>
                        <td class="detalles"><%= rs.getString("autor")%></td>
                        <td class="detalles"><%= rs.getString("clasificacion")%></td>
                        <td class="detalles"><%= rs.getString("cantidad_paginas")%></td>
                     
                    </tr>
                    <%
                    } else if ("inventario".equals(tipoConsulta)) {
                    %>
                    <tr>
                        <td class="detalles"><%= rs.getInt("id")%></td>
                        <td class="detalles"><%= rs.getString("nombre_producto")%></td>
                        <td class="detalles"><%= rs.getInt("cantidad")%> uds.</td>
                        <td class="detalles">Q<%= rs.getDouble("precio")%> c/u</td>
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

        <div class="opciones">
            <form method="get">
                <button type="submit" name="consulta" value="libro" class="datos">Consultar Libro</button>
                <br>

            </form>


        </div>

    </div>
</body>
</html>
