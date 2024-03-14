<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Agregar Libro</title>
    <link rel="stylesheet" href="../css/añadirLibroStyle.css"/>
</head>
<body>
<center>
    <h1>Agregar Nuevo Libro</h1>

    <!-- Formulario para ingresar los datos del nuevo libro -->
    <form action="" method="post">
        <label for="isbn">ISBN:</label>
        <input type="text" id="isbn" name="isbn" required>

        <label for="titulo">Título:</label>
        <input type="text" id="titulo" name="titulo" required>

        <label for="fecha_pub">Fecha de Publicación:</label>
        <input type="text" id="fecha_pub" name="fecha_pub" required>

        <label for="categoria">Categoría (#1 al 7):</label>
        <input type="text" id="categoria" name="categoria" required>

        <label for="precio">Precio:</label>
        <input type="text" id="precio" name="precio" required>

        <label for="portada">Portada:</label>
        <input type="text" id="portada" name="portada">

        <label for="cantidad_stock">Cantidad en Stock:</label>
        <input type="text" id="cantidad_stock" name="cantidad_stock" required>

        <button type="submit">Agregar</button>
    </form>

    <!-- Procesar la inserción del libro y mostrar un mensaje de éxito -->
    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String isbn = request.getParameter("isbn");
            if (isbn == null || isbn.isEmpty()) {
                // Mostrar un mensaje de error
                out.println("<p>El campo ISBN no puede estar vacío.</p>");
            } else {
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
        }
    %>

    <!-- Botón para regresar a la tabla de libros -->
    <a id="regresar"href="../librosCRUD.jsp">REGRESAR</a>
</center>
</body>
</html>
