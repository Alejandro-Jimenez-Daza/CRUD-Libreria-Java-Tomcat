<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Eliminar Cliente</title>
    <link rel="stylesheet" href="../clienteCRUD/eliminarClienteStyle.css"/>
</head>
<body>
    <center>
        <h1>Eliminar Cliente</h1>

        <%-- Obtener el ID del cliente a eliminar desde el parámetro de la URL --%>
        <%
            int clienteId = Integer.parseInt(request.getParameter("id"));

            String DB_URL = "jdbc:mysql://localhost:3306/libajdbd2561203?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=America/Bogota";
            String DB_USER = "alejo16";
            String DB_PASSWORD = "holamundo";

            Connection conn = null;
            PreparedStatement deleteStmt = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                // Realizar la eliminación del cliente
                String deleteSql = "DELETE FROM clientes WHERE id_cliente = ?";
                deleteStmt = conn.prepareStatement(deleteSql);
                deleteStmt.setInt(1, clienteId);
                int rowsAffected = deleteStmt.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("Cliente eliminado exitosamente.");
                } else {
                    out.println("No se pudo eliminar el cliente.");
                }
            } catch (ClassNotFoundException | SQLException e) {
                out.println("Error en la conexión a la base de datos: " + e.getMessage());
            } finally {
                try {
                    if (deleteStmt != null) {
                        deleteStmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    out.println("Error al cerrar la conexión: " + e.getMessage());
                }
            }
        %>

        <br>
        <a href="../clientesCRUD.jsp">Volver a la tabla de Clientes</a>
    </center>
</body>
</html>
