<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Eliminar Libro</title>
    <link rel="stylesheet" href="../css/libroStyle.css"/>
</head>
<body>
    <center>
        <h1>Eliminar Libro</h1>

        <%-- Obtener el ID del libro a eliminar desde el parámetro GET --%>
        <%
            String libroId = request.getParameter("id");
            if (libroId != null && !libroId.isEmpty()) {
                Connection conn = null;
                PreparedStatement pstmt = null;

                try {
                    String DB_URL = "jdbc:mysql://localhost:3306/libajdbd2561203?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=America/Bogota";
                    String DB_USER = "alejo16";
                    String DB_PASSWORD = "holamundo";

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                    // Eliminar el libro de la base de datos
                    String deleteQuery = "DELETE FROM libros WHERE isbn = ?";
                    pstmt = conn.prepareStatement(deleteQuery);
                    pstmt.setString(1, libroId);

                    int rowsAffected = pstmt.executeUpdate();

                    // Verificar si la eliminación fue exitosa
                    if (rowsAffected > 0) {
                        out.println("<p>Libro eliminado exitosamente.</p>");
                    } else {
                        out.println("<p>Error al eliminar el libro.</p>");
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
            } else {
                out.println("<p>No se proporcionó un ID válido para eliminar el libro.</p>");
            }
        %>

        <!-- Botón para regresar a la tabla de libros -->
        <a href="../librosCRUD.jsp">REGRESAR</a>
    </center>
</body>
</html>
