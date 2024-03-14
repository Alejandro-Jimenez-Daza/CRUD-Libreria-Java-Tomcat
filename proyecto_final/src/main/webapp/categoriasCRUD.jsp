<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>CATEGORIAS</title>
    <link rel="stylesheet" href="css/categoriasStyle.css"/>
</head>
<body>
    <center>
        <h1>Lista de Categorias</h1>

        <form id="agregarCategoria" method="post">
            <h2>Agregar Una Nueva Categoria</h2>
            <label for="categoria">Categoria:</label>
            <input type="text" id="categoria" name="categoria" required>
            <button type="submit">Agregar</button>
            <a href="index.jsp" class="volver-button">HOME</a>
        </form>

        <!-- Tabla de categorías -->
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>CATEGORIA</th>
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
                            String categoria = request.getParameter("categoria");

                            String sql = "INSERT INTO categorias (categoria) VALUES (?)";
                            PreparedStatement insertStmt = conn.prepareStatement(sql);
                            insertStmt.setString(1, categoria);

                            int rowsAffected = insertStmt.executeUpdate();

                            if (rowsAffected > 0) {
                                out.println("Inserción exitosa");
                            } else {
                                out.println("No se pudo insertar la categoría");
                            }

                            insertStmt.close();
                        }

                        String selectSql = "SELECT * FROM categorias";
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery(selectSql);

                        while (rs.next()) {
                            int id = rs.getInt("id_categoria");
                            String categoria = rs.getString("categoria");

                            out.println("<tr>");
                            out.println("<td>" + id + "</td>");
                            out.println("<td>" + categoria + "</td>");

                            out.println("<td>");
                            out.println("<a class='editar-link' href='categoriaCRUD/editarCategoria.jsp?id=" + id + "'><img src='img/editarIcon.png' alt='Editar' width='30' height='30'></a>");
                            out.println("</td>");
                            out.println("<td>");
                            out.println("<a class='eliminar-link' href='categoriaCRUD/eliminarCategoria.jsp?id=" + id + "'><img src='img/eliminarIcon.png' alt='Borrar' width='30' height='30'></a>");
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
</body>
</html>
