<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AUTORES</title>
        <link rel="stylesheet" href="css/autoresStyle.css"/>
        <script>
            function eliminarAutor(id) {
                alert("Eliminar autor con ID: " + id);
            }
        </script>
    </head>
    <body>
    <center>
        <h1>Lista de autores</h1>

        <form id="agregarAutorForm" method="post">
            <h2>Agregar Un Nuevo Autor</h2>
            <label for="nombres">Nombres:</label>
            <input type="text" id="nombres" name="nombres" required>

            <label for="apellidos">Apellidos:</label>
            <input type="text" id="apellidos" name="apellidos" required>
            <center>
                <button type="submit">Agregar</button>
                <br>
                <!-- Agregar un botón para volver a index.jsp -->
                <a href="index.jsp" class="volver-button">HOME</a>
            </center>
        </form>

        <!-- Tabla de autores -->
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>NOMBRES</th>
                    <th>APELLIDOS</th>
                    <th>EDITAR</th>
                    <th>ELIMINAR</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Conexión a la base de datos (ajusta las credenciales según tu configuración)
                    String DB_URL = "jdbc:mysql://localhost:3306/libajdbd2561203?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=America/Bogota";
                    String DB_USER = "alejo16";
                    String DB_PASSWORD = "holamundo";

                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                        // Verificar si se envió el formulario para agregar un nuevo autor
                        if ("POST".equals(request.getMethod())) {
                            // Obtener los datos del formulario
                            String nombres = request.getParameter("nombres");
                            String apellidos = request.getParameter("apellidos");

                            // Validar los datos si es necesario
                            // Preparar la consulta SQL para la inserción
                            String sql = "INSERT INTO autores (nombres, apellidos) VALUES (?, ?)";
                            PreparedStatement insertStmt = conn.prepareStatement(sql);
                            insertStmt.setString(1, nombres);
                            insertStmt.setString(2, apellidos);

                            // Ejecutar la inserción
                            int rowsAffected = insertStmt.executeUpdate();

                            if (rowsAffected > 0) {
                                out.println("Inserción exitosa");
                            } else {
                                out.println("No se pudo insertar el autor");
                            }

                            // Cerrar el statement de inserción
                            insertStmt.close();
                        }

                        // Consulta SQL para obtener los datos de la tabla autores
                        String selectSql = "SELECT * FROM autores";
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery(selectSql);

                        // Iterar a través de los resultados y mostrarlos en la tabla
                        while (rs.next()) {
                            int id = rs.getInt("id_autor");
                            String nombres = rs.getString("nombres");
                            String apellidos = rs.getString("apellidos");

                            out.println("<tr>");
                            out.println("<td>" + id + "</td>");
                            out.println("<td>" + nombres + "</td>");
                            out.println("<td>" + apellidos + "</td>");

                            // Agregar enlaces para editar y eliminar con imágenes
                            out.println("<td>");
                            out.println("<a class='editar-link' href='autorCRUD/editarAutor.jsp?id=" + id + "'><img src='img/editarIcon.png' alt='Editar' width='30' height='30'></a>");
                            out.println("</td>");
                            out.println("<td>");
                            out.println("<a class='eliminar-link' href='autorCRUD/eliminarAutor.jsp?id=" + id + "'><img src='img/eliminarIcon.png' alt='Borrar' width='30' height='30'></a>");
                            out.println("</td>");

                            out.println("</tr>");
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
            </tbody>
        </table>
    </center>
</body>
</html>
