<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="editarUsuarioStyle.css">
    <title>Editar Usuario</title>
</head>
<body>
    <center>
        <h1>Editar Usuario</h1>
        <br>

        <% 
            String DB_URL = "jdbc:mysql://localhost:3306/libajdbd2561203?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=America/Bogota";
            String DB_USER = "alejo16";
            String DB_PASSWORD = "holamundo";

            Connection conn = null;
            PreparedStatement selectStmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                if ("POST".equals(request.getMethod())) {
                    String idStr = request.getParameter("id");
                    int id = Integer.parseInt(idStr);

                    String usuario = request.getParameter("usuario");
                    String clave = request.getParameter("clave");
                    String correo = request.getParameter("correo");

                    // Realiza la actualización en la base de datos aquí
                    String sql = "UPDATE usuarios_ajd SET usuario=?, clave=?, correo=? WHERE id_usuario=?";
                    PreparedStatement updateStmt = conn.prepareStatement(sql);
                    updateStmt.setString(1, usuario);
                    updateStmt.setString(2, clave);
                    updateStmt.setString(3, correo);
                    updateStmt.setInt(4, id);

                    int rowsAffected = updateStmt.executeUpdate();

                    if (rowsAffected > 0) {
                        out.println("Actualización exitosa");
                    } else {
                        out.println("No se pudo actualizar el usuario");
                    }

                    updateStmt.close();
                } else {
                    // Recupera los datos actuales del usuario
                    String idStr = request.getParameter("id");
                    int id = Integer.parseInt(idStr);

                    String sql = "SELECT usuario, clave, correo FROM usuarios_ajd WHERE id_usuario=?";
                    selectStmt = conn.prepareStatement(sql);
                    selectStmt.setInt(1, id);

                    rs = selectStmt.executeQuery();

                    if (rs.next()) {
                        String usuarioActual = rs.getString("usuario");
                        String claveActual = rs.getString("clave");
                        String correoActual = rs.getString("correo");

                        // Asigna los valores a las variables
                        request.setAttribute("usuarioActual", usuarioActual);
                        request.setAttribute("claveActual", claveActual);
                        request.setAttribute("correoActual", correoActual);
                    }
                }
            } catch (ClassNotFoundException | SQLException e) {
                out.println("Error en la conexión a la base de datos: " + e.getMessage());
            } finally {
                try {
                    if (rs != null) {
                        rs.close();
                    }
                    if (selectStmt != null) {
                        selectStmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    out.println("Error al cerrar la conexión: " + e.getMessage());
                }
            }
        %>

        <!-- Agregar aquí el formulario para editar los datos del usuario -->
        <form method="post">
            <input type="hidden" name="id" value="<%= request.getParameter("id") %>">
            <label for="usuario">Usuario:</label>
            <input type="text" id="usuario" name="usuario" value="<%= request.getAttribute("usuarioActual") %>" required><br>

            <label for="clave">Clave:</label>
            <input type="password" id="clave" name="clave" value="<%= request.getAttribute("claveActual") %>" required><br>

            <label for="correo">Correo Electrónico:</label>
            <input type="email" id="correo" name="correo" value="<%= request.getAttribute("correoActual") %>" required><br>

            <input type="submit" value="Guardar Cambios">
        </form>
        <br>
        <a href="../usuariosCRUD.jsp">Volver a la tabla de usuarios</a>
    </center>
</body>
</html>
