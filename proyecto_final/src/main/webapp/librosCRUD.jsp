<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LIBROS</title>
        <link rel="stylesheet" href="css/libroStyle.css"/>
    </head>
    <body>
    <center>
        <h1>Lista de Libros</h1>
        <form action="libroCRUD/añadirLibro.jsp" method="post">
            <button type="submit" id="agregarLib">Agregar Libro</button>
        </form>
        <a href="index.jsp" class="volver-button">HOME</a>

        <table border="1">
            <thead>
                <tr>
                    <th>ISBN</th>
                    <th>TITULO</th>
                    <th>FECHA_PUB</th>
                    <th>CATEGORIA</th>
                    <th>PRECIO</th>
                    <th>PORTADA</th>
                    <th>CANTIDAD EN STOCK</th>
                    <th>EDITAR</th>
                    <th>ELIMINAR</th>
                </tr>
            </thead>
            <br>
            <tbody>
                <!-- Procesar el formulario y agregar un nuevo libro -->
                <%
                    if (request.getMethod().equalsIgnoreCase("POST")) {
                        String isbn = request.getParameter("isbn");
                        String titulo = request.getParameter("titulo");
                        String fecha_pub = request.getParameter("fecha_pub");
                        String categoria = request.getParameter("categoria");
                        String precio = request.getParameter("precio");
                        String portada = request.getParameter("portada");
                        String cantidad_stock = request.getParameter("cantidad_stock");

                        Connection conn = null;
                        PreparedStatement pstmt = null;

                        try {
                            String DB_URL = "jdbc:mysql://localhost:3306/libajdbd2561203?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=America/Bogota";
                            String DB_USER = "alejo16";
                            String DB_PASSWORD = "holamundo";

                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                            // Insertar un nuevo libro en la base de datos
                            String insertQuery = "INSERT INTO libros (isbn, titulo, fecha_pub, categoria, precio, portada, cantidad_stock) VALUES (?, ?, ?, ?, ?, ?, ?)";
                            pstmt = conn.prepareStatement(insertQuery);
                            pstmt.setString(1, isbn);
                            pstmt.setString(2, titulo);
                            pstmt.setString(3, fecha_pub);
                            pstmt.setString(4, categoria);
                            pstmt.setString(5, precio);
                            pstmt.setString(6, portada);
                            pstmt.setString(7, cantidad_stock);

                            int rowsAffected = pstmt.executeUpdate();

                            // Verificar si la inserción fue exitosa
                            if (rowsAffected > 0) {
                                out.println("<p>Libro agregado exitosamente.</p>");
                            } else {
                                out.println("<p>Error al agregar el libro.</p>");
                            }
                        } catch (ClassNotFoundException | SQLException e) {
                            out.println("Error en la conexión a la base de datos: " + e.getMessage());
                        } finally {
                            // Cerrar la conexión
                            try {
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
                    }

                    // Mostrar la lista actualizada de libros
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;

                    try {
                        String DB_URL = "jdbc:mysql://localhost:3306/libajdbd2561203?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=America/Bogota";
                        String DB_USER = "alejo16";
                        String DB_PASSWORD = "holamundo";

                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                        stmt = conn.createStatement();

                        String sql = "SELECT * FROM libros";
                        rs = stmt.executeQuery(sql);

                        while (rs.next()) {
                            // Mostrar los datos de la base de datos
                            int isbn = rs.getInt("isbn");
                            String libroTitulo = rs.getString("titulo");
                            java.sql.Date fecha_pub = rs.getDate("fecha_pub");
                            String categoria = rs.getString("categoria");
                            String precio = rs.getString("precio");
                            String portada = rs.getString("portada");
                            String cantidad_stock = rs.getString("cantidad_stock");

                            out.println("<tr>");
                            out.println("<td>" + isbn + "</td>");
                            out.println("<td>" + libroTitulo + "</td>");
                            out.println("<td>" + fecha_pub + "</td>");
                            out.println("<td>" + categoria + "</td>");
                            out.println("<td>" + precio + "</td>");
                            out.println("<td>" + portada + "</td>");
                            out.println("<td>" + cantidad_stock + "</td>");
                            out.println("<td>");
                            out.println("<a href='libroCRUD/editarLibro.jsp?id=" + isbn + "'><img src='img/editarIcon.png' alt='Eliminar' width='30' height='30'></a>");
                            out.println("</td>");
                            out.println("<td>");
                            out.println("<a href='libroCRUD/eliminarLibro.jsp?id=" + isbn + "'><img src='img/eliminarIcon.png' alt='Eliminar' width='30' height='30'></a>");
                            out.println("</td>");
                            out.println("</tr>");
                        }
                    } catch (ClassNotFoundException | SQLException e) {
                        out.println("Error en la conexión a la base de datos: " + e.getMessage());
                    } finally {
                        // Cerrar conexiones
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
