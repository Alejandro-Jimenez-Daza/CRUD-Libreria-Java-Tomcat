<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="editarUsuarioStyle.css">
    <title>Eliminar Usuario</title>
</head>
<body>
    <center>
        <h1>Eliminar Usuario</h1>
        <br>

        <!-- Botón para volver a la tabla -->
        <a href="../usuariosCRUD.jsp" class="volver-button">Volver a la Tabla</a>
        <br>
        <br>

        <%
            String DB_URL = "jdbc:mysql://localhost:3306/libajdbd2561203?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=America/Bogota";
            String DB_USER = "alejo16";
            String DB_PASSWORD = "holamundo";

            Connection conn = null;
            Statement stmt = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                // Obtener el ID del usuario a eliminar de los parámetros de solicitud
                String userId = request.getParameter("id");
                int idUsuario = Integer.parseInt(userId);

                // Realizar la eliminación en la base de datos
                String deleteSql = "DELETE FROM usuarios_ajd WHERE id_usuario = ?";
                PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
                deleteStmt.setInt(1, idUsuario);

                int rowsAffected = deleteStmt.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("Usuario eliminado correctamente.");
                } else {
                    out.println("No se pudo eliminar el usuario.");
                }

                deleteStmt.close();
            } catch (ClassNotFoundException | SQLException e) {
                out.println("Error en la conexión a la base de datos: " + e.getMessage());
            } finally {
                try {
                    if (stmt != null) {
                        stmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    out.println("Error al cerrar la conexión: " + e.getMessage());
                }
            }
        %>
    </center>
</body>
</html>
