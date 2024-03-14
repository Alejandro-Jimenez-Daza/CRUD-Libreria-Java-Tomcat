<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Actualizar Libro</title>
    <link rel="stylesheet" href="../css/editarLibro.css"/>
</head>
<body>
    <center>
        <h1>Actualizar Libro</h1>

        <%-- Obtener los datos del formulario --%>
        <%
            String isbn = request.getParameter("isbn");
            String titulo = request.getParameter("titulo");
            String fecha_pub = request.getParameter("fecha_pub");
            String categoria = request.getParameter("categoria");
            String precio = request.getParameter("precio");
            String portada = request.getParameter("portada");
            String cantidad_stock = request.getParameter("cantidad_stock");

            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                String DB_URL = "jdbc:mysql://localhost:3306/libajdbd2561203?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=America/Bogota";
                String DB_USER = "alejo16";
                String DB_PASSWORD = "holamundo";

                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                // Actualizar el libro en la base de datos
                String updateQuery = "UPDATE libros SET titulo = ?, fecha_pub = ?, categoria = ?, precio = ?, portada = ?, cantidad_stock = ? WHERE isbn = ?";
                pstmt = conn.prepareStatement(updateQuery);
                pstmt.setString(1, titulo);
                pstmt.setString(2, fecha_pub);
                pstmt.setString(3, categoria);
                pstmt.setString(4, precio);
                pstmt.setString(5, portada);
                pstmt.setString(6, cantidad_stock);
                pstmt.setString(7, isbn);

                int rowsAffected = pstmt.executeUpdate();

                // Verificar si la actualización fue exitosa
                if (rowsAffected > 0) {
                    out.println("<p>Libro actualizado exitosamente.</p>");
                } else {
                    out.println("<p>Error al actualizar el libro.</p>");
                }
            } catch (ClassNotFoundException | SQLException e) {
                out.println("Error en la conexión a la base de datos: " + e.getMessage());
            } finally {
                // Cerrar la conexión
                try {
                    if (pstmt != null) {
                        pstmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    out.println("Error al cerrar la conexión: " + e.getMessage());
                }
            }
        %>

        <!-- Botón para regresar a la tabla de libros -->
        <a href="../librosCRUD.jsp">REGRESAR</a>
    </center>
</body>
</html>
