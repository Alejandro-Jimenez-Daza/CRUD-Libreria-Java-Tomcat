<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Autor</title>
    <link rel="stylesheet" href="../css/autoresStyle.css"/>
</head>
<body>
<style>
    /* Estilos para el formulario */
    body {
        background-color: #f0f0f0;
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
    }

    .container {
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        max-width: 400px;
        margin: 0 auto;
        padding: 20px;
        text-align: center;
    }

    h1 {
        color: #333;
    }

    label {
        display: inline-block;
        text-align: right;
        width: 100px; /* Ancho de etiqueta ajustado */
        margin-right: 10px; /* Margen derecho entre etiqueta y campo */
    }

    input[type="text"] {
        width: 240px; /* Ancho de campo ajustado */
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }

    /* Estilos para el botón */
    .btn-save {
        background-color: #28a745;
        border: none;
        color: white;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 10px 5px;
        cursor: pointer;
        border-radius: 4px;
        transition: background-color 0.3s;
    }

    .btn-save:hover {
        background-color: #218838;
    }

    /* Estilos para el enlace de regreso */
    .btn-back {
        background-color: #007bff;
        border: none;
        color: white;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 10px 5px;
        cursor: pointer;
        border-radius: 4px;
        transition: background-color 0.3s;
    }

    .btn-back:hover {
        background-color: #0056b3;
    }
</style>

<center>
    <h1>Editar Autor</h1>

    <%
        // Variables para controlar el flujo
        boolean actualizacionExitosa = false;

        // Conexión a la base de datos (ajusta las credenciales según tu configuración)
        String DB_URL = "jdbc:mysql://localhost:3306/libajdbd2561203?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=America/Bogota";
        String DB_USER = "alejo16";
        String DB_PASSWORD = "holamundo";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Verificar si se envió el formulario de edición
            if ("POST".equals(request.getMethod())) {
                // Obtener los datos del formulario
                int idAutor = Integer.parseInt(request.getParameter("id"));
                String nuevosNombres = request.getParameter("nombres");
                String nuevosApellidos = request.getParameter("apellidos");

                // Preparar la consulta SQL de actualización
                String updateSql = "UPDATE autores SET nombres = ?, apellidos = ? WHERE id_autor = ?";
                stmt = conn.prepareStatement(updateSql);
                stmt.setString(1, nuevosNombres);
                stmt.setString(2, nuevosApellidos);
                stmt.setInt(3, idAutor);

                // Ejecutar la consulta de actualización
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    actualizacionExitosa = true;
                }
            } else {
                // Obtener el ID del autor de los parámetros de la URL
                String idAutorStr = request.getParameter("id");
                if (idAutorStr != null) {
                    int idAutor = Integer.parseInt(idAutorStr);

                    // Consulta SQL para obtener los datos actuales del autor
                    String selectSql = "SELECT * FROM autores WHERE id_autor = ?";
                    stmt = conn.prepareStatement(selectSql);
                    stmt.setInt(1, idAutor);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        String nombres = rs.getString("nombres");
                        String apellidos = rs.getString("apellidos");
    %>

    <!-- Formulario de edición -->
    <form id="editarAutorForm" method="post">
        <input type="hidden" name="id" value="<%= idAutor%>">
        <label for="nombres">Nombres:</label>
        <input type="text" id="nombres" name="nombres" value="<%= nombres%>" required>

        <label for="apellidos">Apellidos:</label>
        <input type="text" id="apellidos" name="apellidos" value="<%= apellidos%>" required>

        <button type="submit" class="btn-save">Guardar Cambios</button>
    </form>

    <%
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            out.println("Error en la conexión a la base de datos: " + e.getMessage());
        } finally {
            // Cerrar conexiones y recursos
            try {
                if (rs != null) {
                    rs.close();
                }
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

    <% if (actualizacionExitosa) { %>
    <a href="../autoresCRUD.jsp" class="btn-back">Regresar a la lista de autores</a>
    <% }%>

</center>
</body>
</html>
