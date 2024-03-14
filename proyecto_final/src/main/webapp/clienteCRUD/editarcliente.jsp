<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Cliente</title>
    <link rel="stylesheet" href="../css/clientesStyle.css"/>
</head>
<body>
    <center>
        <h1>Editar Cliente</h1>

        <%
            String DB_URL = "jdbc:mysql://localhost:3306/libajdbd2561203?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=America/Bogota";
            String DB_USER = "alejo16";
            String DB_PASSWORD = "holamundo";

            Connection conn = null;
            PreparedStatement updateStmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                int id = Integer.parseInt(request.getParameter("id"));
                String identificacion = "";
                String nombres = "";
                String apellidos = "";
                String telefono = "";
                String direccion = "";
                String correo = "";

                // Obtener los datos actuales del cliente
                String selectSql = "SELECT * FROM clientes WHERE id_cliente=?";
                PreparedStatement selectStmt = conn.prepareStatement(selectSql);
                selectStmt.setInt(1, id);
                rs = selectStmt.executeQuery();

                if (rs.next()) {
                    identificacion = rs.getString("identificacion");
                    nombres = rs.getString("nombres");
                    apellidos = rs.getString("apellidos");
                    telefono = rs.getString("telefono");
                    direccion = rs.getString("direccion");
                    correo = rs.getString("correo_electronico");
                }

                if ("POST".equals(request.getMethod())) {
                    identificacion = request.getParameter("identificacion");
                    nombres = request.getParameter("nombres");
                    apellidos = request.getParameter("apellidos");
                    telefono = request.getParameter("telefono");
                    direccion = request.getParameter("direccion");
                    correo = request.getParameter("correo");

                    String sql = "UPDATE clientes SET identificacion=?, nombres=?, apellidos=?, telefono=?, direccion=?, correo_electronico=? WHERE id_cliente=?";
                    updateStmt = conn.prepareStatement(sql);
                    updateStmt.setString(1, identificacion);
                    updateStmt.setString(2, nombres);
                    updateStmt.setString(3, apellidos);
                    updateStmt.setString(4, telefono);
                    updateStmt.setString(5, direccion);
                    updateStmt.setString(6, correo);
                    updateStmt.setInt(7, id);

                    int rowsAffected = updateStmt.executeUpdate();

                    if (rowsAffected > 0) {
        %>
        <div style="color: green;">Cliente editado exitosamente</div>
        <%
                    } else {
        %>
        <div style="color: red;">No se pudo editar el cliente</div>
        <%
                    }
                }
        %>

        <!-- Formulario para editar el cliente -->
        <form id="editarClienteForm" method="post">
            <input type="hidden" name="id" value="<%= id %>">
            <label for="identificacion">Identificación:</label>
            <input type="text" id="identificacion" name="identificacion" required value="<%= identificacion %>"><br>

            <label for="nombres">Nombres:</label>
            <input type="text" id="nombres" name="nombres" required value="<%= nombres %>"><br>

            <label for="apellidos">Apellidos:</label>
            <input type="text" id="apellidos" name="apellidos" required value="<%= apellidos %>"><br>

            <label for="telefono">Teléfono:</label>
            <input type="text" id="telefono" name="telefono" required value="<%= telefono %>"><br>

            <label for="direccion">Dirección:</label>
            <input type="text" id="direccion" name="direccion" required value="<%= direccion %>"><br>

            <label for="correo">Correo Electrónico:</label>
            <input type="email" id="correo" name="correo" required value="<%= correo %>"><br>

            <input type="button" value="Guardar Cambios" onclick="editarCliente()">
            <input type="button" value="Regresar" onclick="window.location.href='../clientesCRUD.jsp'">
        </form>
        <%
            } catch (ClassNotFoundException | SQLException e) {
        %>
        <div style="color: red;">Error en la conexión a la base de datos: <%= e.getMessage() %></div>
        <%
            } finally {
                try {
                    if (rs != null) {
                        rs.close();
                    }
                    if (updateStmt != null) {
                        updateStmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException e) {
        %>
        <div style="color: red;">Error al cerrar la conexión: <%= e.getMessage() %></div>
        <%
                }
            }
        %>
    </center>

    <!-- JavaScript para realizar la edición sin redireccionamiento -->
    <script>
        function editarCliente() {
            // Obtener datos del formulario
            var id = document.getElementById("id").value;
            var identificacion = document.getElementById("identificacion").value;
            var nombres = document.getElementById("nombres").value;
            var apellidos = document.getElementById("apellidos").value;
            var telefono = document.getElementById("telefono").value;
            var direccion = document.getElementById("direccion").value;
            var correo = document.getElementById("correo").value;

            // Realizar la edición mediante AJAX
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "", true); // Deja el campo URL vacío para que se refiera a la misma página
            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    var responseDiv = document.getElementById("responseDiv"); // Elemento para mostrar la respuesta
                    if (xhr.status === 200) {
                        // Éxito
                        responseDiv.innerHTML = "Cliente editado exitosamente";
                        responseDiv.style.color = "green";
                        setTimeout(function() {
                            responseDiv.innerHTML = ""; // Borrar el mensaje después de unos segundos
                        }, 3000);
                    } else {
                        // Error
                        responseDiv.innerHTML = "Error al editar el cliente: " + xhr.responseText;
                        responseDiv.style.color = "red";
                    }
                }
            };

            // Enviar datos al servidor
            var data = "id=" + id + "&identificacion=" + identificacion + "&nombres=" + nombres + "&apellidos=" + apellidos + "&telefono=" + telefono + "&direccion=" + direccion + "&correo=" + correo;
            xhr.send(data);
        }
    </script>
</body>
</html>
