<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Eliminar Categoría</title>
    <link rel="stylesheet" href="../css/categoriasStyle.css"/>
</head>
<body>
    <center>
        <h1>Eliminar Categoría</h1>

        <%
            String categoryId = request.getParameter("id");
            
            if (categoryId != null && !categoryId.isEmpty()) {
                try {
                    // Conexión a la base de datos (ajusta las credenciales según tu configuración)
                    String DB_URL = "jdbc:mysql://localhost:3306/libajdbd2561203?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=America/Bogota";
                    String DB_USER = "alejo16";
                    String DB_PASSWORD = "holamundo";

                    Connection conn = null;
                    PreparedStatement deleteStmt = null;

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                    // Consulta SQL para eliminar la categoría
                    String deleteSql = "DELETE FROM categorias WHERE id_categoria = ?";
                    deleteStmt = conn.prepareStatement(deleteSql);
                    deleteStmt.setInt(1, Integer.parseInt(categoryId));
                    int rowsAffected = deleteStmt.executeUpdate();

                    if (rowsAffected > 0) {
                        out.println("Categoría eliminada con éxito.<br>");
                    } else {
                        out.println("No se pudo eliminar la categoría.<br>");
                    }

                    // Cerrar conexiones y recursos
                    if (deleteStmt != null) {
                        deleteStmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (ClassNotFoundException | SQLException e) {
                    out.println("Error en la conexión a la base de datos: " + e.getMessage());
                }
            } else {
                out.println("ID de categoría no proporcionado.");
            }
        %>

        <!-- Botón para volver a la página de categorías -->
        <a href="../categoriasCRUD.jsp">Volver a la página de categorías</a>
    </center>
</body>
</html>
