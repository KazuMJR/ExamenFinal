/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("ResgistroUsuarioServlet")
public class ResgistroServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String isbn = request.getParameter("isbn");
        String titulo = request.getParameter("titulo");
        String anio = request.getParameter("anio");
         String autor = request.getParameter("autor");
          String clasificacion = request.getParameter("clasificacion");
           String paginas = request.getParameter("paginas");

        try (Connection con = ConexionBaseDatos.getConnection()) {
            String query = "INSERT INTO libro (isbn, titulo_libro, anio_publicacion, autor, clasificacion, cantidad_paginas) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement pst = con.prepareStatement(query)) {
                pst.setString(1, isbn);
                pst.setString(2, titulo);
                pst.setString(3, anio);
                pst.setString(4, autor);
                pst.setString(5, clasificacion);
                pst.setString(6, paginas);
      
                pst.executeUpdate();
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        response.sendRedirect("registro.jsp");
    }
}
