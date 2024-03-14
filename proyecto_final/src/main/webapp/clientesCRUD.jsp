<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>CLIENTES</title>
    <link rel="stylesheet" href="css/clientesStyle.css"/>
</head>
<body>
    <center>
        <h1>Lista de Clientes</h1>

        <!-- Formulario para agregar cliente -->
        <form id="agregarCliente" method="post">
            <h2>Agregar un Nuevo Cliente</h2>
            <label for="identificacion">Identificación:</label>
            <input type="text" id="identificacion" name="identificacion" required><br>

            <label for="nombres">Nombres:</label>
            <input type="text" id="nombres" name="nombres" required><br>

            <label for="apellidos">Apellidos:</label>
            <input type="text" id="apellidos" name="apellidos" required><br>

            <label for="telefono">Teléfono:</label>
            <input type="text" id="telefono" name="telefono" required><br>

            <label for="direccion">Dirección:</label>
            <input type="text" id="direccion" name="direccion" required><br>

            <label for="correo">Correo Electrónico:</label>
            <input type="email" id="correo" name="correo" required><br>

            <input type="button" value="Agregar Cliente" onclick="insertarCliente()">

        </form>
        <a href="index.jsp" class="volver-button">HOME</a>

        <!-- Tabla de clientes -->
        <table border="1" id="tablaClientes">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>IDENTIFICACIÓN</th>
                    <th>NOMBRES</th>
                    <th>APELLIDOS</th>
                    <th>TELÉFONO</th>
                    <th>DIRECCIÓN</th>
                    <th>CORREO</th>
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
                    Statement stmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                        if ("POST".equals(request.getMethod())) {
                            String identificacion = request.getParameter("identificacion");
                            String nombres = request.getParameter("nombres");
                            String apellidos = request.getParameter("apellidos");
                            String telefono = request.getParameter("telefono");
                            String direccion = request.getParameter("direccion");
                            String correo = request.getParameter("correo");

                            String sql = "INSERT INTO clientes (identificacion, nombres, apellidos, telefono, direccion, correo_electronico) VALUES (?, ?, ?, ?, ?, ?)";
                            PreparedStatement insertStmt = conn.prepareStatement(sql);
                            insertStmt.setString(1, identificacion);
                            insertStmt.setString(2, nombres);
                            insertStmt.setString(3, apellidos);
                            insertStmt.setString(4, telefono);
                            insertStmt.setString(5, direccion);
                            insertStmt.setString(6, correo);

                            int rowsAffected = insertStmt.executeUpdate();

                            if (rowsAffected > 0) {
                                out.println("Inserción exitosa");
                                // Actualizar la tabla de clientes después de la inserción
                                out.println("<script>actualizarTablaClientes();</script>");
                            } else {
                                out.println("No se pudo insertar el cliente");
                            }

                            insertStmt.close();
                        }

                        String selectSql = "SELECT * FROM clientes";
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery(selectSql);

                        while (rs.next()) {
                            int id = rs.getInt("id_cliente");
                            String identificacion = rs.getString("identificacion");
                            String nombres = rs.getString("nombres");
                            String apellidos = rs.getString("apellidos");
                            String telefono = rs.getString("telefono");
                            String direccion = rs.getString("direccion");
                            String correo = rs.getString("correo_electronico");

                            out.println("<tr>");
                            out.println("<td>" + id + "</td>");
                            out.println("<td>" + identificacion + "</td>");
                            out.println("<td>" + nombres + "</td>");
                            out.println("<td>" + apellidos + "</td>");
                            out.println("<td>" + telefono + "</td>");
                            out.println("<td>" + direccion + "</td>");
                            out.println("<td>" + correo + "</td>");

                            out.println("<td>");
                            out.println("<a class='editar-link' href='clienteCRUD/editarcliente.jsp?id=" + id + "'><img src='img/editarIcon.png' alt='Editar' width='30' height='30'></a>");
                            out.println("</td>");
                            out.println("<td>");
                            out.println("<a class='eliminar-link' href='clienteCRUD/eliminarCliente.jsp?id=" + id + "'><img src='img/eliminarIcon.png' alt='Borrar' width='30' height='30'></a>");
                            out.println("</td>");

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

    <!-- JavaScript para realizar la inserción sin redireccionamiento y actualizar la tabla -->
    <script>
        function insertarCliente() {
            // Obtener datos del formulario
            var identificacion = document.getElementById("identificacion").value;
            var nombres = document.getElementById("nombres").value;
            var apellidos = document.getElementById("apellidos").value;
            var telefono = document.getElementById("telefono").value;
            var direccion = document.getElementById("direccion").value;
            var correo = document.getElementById("correo").value;

            // Realizar la inserción mediante AJAX
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "", true); // Deja el campo URL vacío para que se refiera a la misma página
            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        alert("Cliente agregado exitosamente");
                        // Actualizar la tabla de clientes después de la inserción
                        actualizarTablaClientes();
                    } else {
                        alert("Error al agregar el cliente: " + xhr.responseText);
                    }
                }
            };

            // Enviar datos al servidor
            var data = "identificacion=" + identificacion + "&nombres=" + nombres + "&apellidos=" + apellidos + "&telefono=" + telefono + "&direccion=" + direccion + "&correo=" + correo;
            xhr.send(data);
        }

        function actualizarTablaClientes() {
            // Realizar una solicitud AJAX para obtener los datos actualizados de los clientes
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "obtenerClientes.jsp", true); // Reemplaza "obtenerClientes.jsp" con la URL correcta para obtener los datos de los clientes
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    // Actualizar la tabla de clientes con los datos recibidos
                    document.getElementById("tablaClientes").innerHTML = xhr.responseText;
                }
            };
            xhr.send();
        }
    </script>
</body>
</html>
