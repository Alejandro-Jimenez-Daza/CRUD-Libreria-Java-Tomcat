<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Libro</title>
    <link rel="stylesheet" href="../css/editarLibro.css"/>
</head>
<body>
    <center>
        <h1>Editar Libro</h1>

        <%-- Obtener el ID del libro a editar desde el parámetro GET --%>
        <%
            String libroId = request.getParameter("id");
            if (libroId != null && !libroId.isEmpty()) {
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    String DB_URL = "jdbc:mysql://localhost:3306/libajdbd2561203?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=America/Bogota";
                    String DB_USER = "alejo16";
                    String DB_PASSWORD = "holamundo";

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                    // Obtener los datos actuales del libro
                    String selectQuery = "SELECT * FROM libros WHERE isbn = ?";
                    pstmt = conn.prepareStatement(selectQuery);
                    pstmt.setString(1, libroId);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        String isbn = rs.getString("isbn");
                        String titulo = rs.getString("titulo");
                        String fecha_pub = rs.getString("fecha_pub");
                        String categoria = rs.getString("categoria");
                        String precio = rs.getString("precio");
                        String portada = rs.getString("portada");
                        String cantidad_stock = rs.getString("cantidad_stock");

                        %>
                        <form action="actualizarLibro.jsp" method="post">
                            <input type="hidden" name="isbn" value="<%= isbn %>">
                            <label for="titulo">Título:</label>
                            <input type="text" id="titulo" name="titulo" value="<%= titulo %>" required>

                            <label for="fecha_pub">Fecha de Publicación:</label>
                            <input type="text" id="fecha_pub" name="fecha_pub" value="<%= fecha_pub %>" required>

                            <label for="categoria">Categoría (#1 al 7):</label>
                            <input type="text" id="categoria" name="categoria" value="<%= categoria %>" required>

                            <label for="precio">Precio:</label>
                            <input type="text" id="precio" name="precio" value="<%= precio %>" required>

                            <label for="portada">Portada:</label>
                            <input type="text" id="portada" name="portada" value="<%= portada %>">

                            <label for="cantidad_stock">Cantidad en Stock:</label>
                            <input type="text" id="cantidad_stock" name="cantidad_stock" value="<%= cantidad_stock %>" required>

                            <button type="submit">Guardar Cambios</button>
                        </form>
                        <%
                    } else {
                        out.println("<p>No se encontró el libro con el ID proporcionado.</p>");
                    }
                } catch (ClassNotFoundException | SQLException e) {
                    out.println("Error en la conexión a la base de datos: " + e.getMessage());
                } finally {
                    // Cerrar conexiones
                    try {
                        if (rs != null) {
                            rs.close();
                        }
                        if (pstmt != null) {
                            pstmt.close();
                        }
                        if (conn != null) {
                            conn.close();
                        }
                    } catch (SQLException e) {
                        out.println("Error al cerrar la conexión: " + e.getMessage());
                    }
                }
            } else {
                out.println("<p>No se proporcionó un ID válido para editar el libro.</p>");
            }
        %>

        <!-- Botón para regresar a la tabla de libros -->
        <a href="../librosCRUD.jsp">REGRESAR</a>
    </center>
</body>
</html>
