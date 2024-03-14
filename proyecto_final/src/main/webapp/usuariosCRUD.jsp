<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="css/usuariosStyle.css">
    <title>Usuarios</title>
</head>
<body>
    <center>
        <h1>Lista de Usuarios</h1>
        <br>

        <!-- Formulario para agregar un nuevo usuario -->
        <form id="agregarUsuario" method="post">
            <h2>Agregar un Nuevo Usuario</h2>
            <label for="usuario">Usuario:</label>
            <input type="text" id="usuario" name="usuario" required><br>

            <label for="clave">Clave:</label>
            <input type="password" id="clave" name="clave" required><br>

            <label for="correo">Correo Electrónico:</label>
            <input type="email" id="correo" name="correo" required><br>

            <input type="submit" value="Agregar Usuario">
        </form>
        <br>
        <br>

        <!-- Tabla de usuarios -->
        <table border="1" id="tablaUsuarios">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>USUARIO</th>
                    <th>CLAVE</th>
                    <th>CORREO ELECTRÓNICO</th>
                    <th>EDITAR</th>
                    <th>ELIMINAR</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String DB_URL = "jdbc:mysql://localhost:3306/libajdbd2561203?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=America/Bogota";
                    String DB_USER = "alejo16";
                    String DB_PASSWORD = "holamundo";

                    Connection conn = null;
                    PreparedStatement insertStmt = null;
                    Statement stmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                        if ("POST".equals(request.getMethod())) {
                            String usuario = request.getParameter("usuario");
                            String clave = request.getParameter("clave");
                            String correo = request.getParameter("correo");

                            String sql = "INSERT INTO usuarios_ajd (usuario, clave, correo) VALUES (?, ?, ?)";
                            insertStmt = conn.prepareStatement(sql);
                            insertStmt.setString(1, usuario);
                            insertStmt.setString(2, clave);
                            insertStmt.setString(3, correo);

                            int rowsAffected = insertStmt.executeUpdate();

                            if (rowsAffected > 0) {
                                out.println("Inserción exitosa");
                            } else {
                                out.println("No se pudo insertar el usuario");
                            }

                            insertStmt.close();
                        }

                        String selectSql = "SELECT * FROM usuarios_ajd";
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery(selectSql);

                        while (rs.next()) {
                            int id = rs.getInt("id_usuario");
                            String nombreUsuario = rs.getString("usuario");
                            String claveUsuario = rs.getString("clave");
                            String correoUsuario = rs.getString("correo");

                            out.println("<tr>");
                            out.println("<td>" + id + "</td>");
                            out.println("<td>" + nombreUsuario + "</td>");
                            out.println("<td>" + claveUsuario + "</td>");
                            out.println("<td>" + correoUsuario + "</td>");
                            out.println("<td><a href='usuariosCRUD/editarUsuario.jsp?id=" + id + "'><img src='img/editarIcon.png' alt='Editar' width='30' height='30'></a></td>");
                            out.println("<td><a href='usuariosCRUD/eliminarUsuario.jsp?id=" + id + "'><img src='img/eliminarIcon.png' alt='Eliminar' width='30' height='30'></a></td>");
                            out.println("</tr>");
                        }
                    } catch (ClassNotFoundException | SQLException e) {
                        out.println("Error en la conexión a la base de datos: " + e.getMessage());
                    } finally {
                        try {
                            if (rs != null) {
                                rs.close();
                            }
                            if (stmt != null) {
                                stmt.close();
                            }
                            if (insertStmt != null) {
                                insertStmt.close();
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
