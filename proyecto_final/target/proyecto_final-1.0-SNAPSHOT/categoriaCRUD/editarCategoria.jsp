<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Categoría</title>
</head>
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
<body>
    
    <center>
        <h1>Editar Categoría</h1>

        <%
            String categoryId = request.getParameter("id");
            
            if (categoryId != null && !categoryId.isEmpty()) {
                try {
                    // Conexión a la base de datos (ajusta las credenciales según tu configuración)
                    String DB_URL = "jdbc:mysql://localhost:3306/libajdbd2561203?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=America/Bogota";
                    String DB_USER = "alejo16";
                    String DB_PASSWORD = "holamundo";

                    Connection conn = null;
                    PreparedStatement selectStmt = null;
                    ResultSet rs = null;

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                    // Consulta SQL para obtener los detalles de la categoría a editar
                    String selectSql = "SELECT * FROM categorias WHERE id_categoria = ?";
                    selectStmt = conn.prepareStatement(selectSql);
                    selectStmt.setInt(1, Integer.parseInt(categoryId));
                    rs = selectStmt.executeQuery();

                    if (rs.next()) {
                        String nombreCategoria = rs.getString("categoria");

                        // Verifica si se envió el formulario para actualizar la categoría
                        if ("POST".equals(request.getMethod())) {
                            String nuevoNombre = request.getParameter("nuevoNombre");

                            // Validar los datos si es necesario

                            // Consulta SQL para actualizar la categoría
                            String updateSql = "UPDATE categorias SET categoria = ? WHERE id_categoria = ?";
                            PreparedStatement updateStmt = conn.prepareStatement(updateSql);
                            updateStmt.setString(1, nuevoNombre);
                            updateStmt.setInt(2, Integer.parseInt(categoryId));
                            int rowsAffected = updateStmt.executeUpdate();

                            if (rowsAffected > 0) {
                                out.println("Categoría actualizada con éxito.<br>");
                            } else {
                                out.println("No se pudo actualizar la categoría.<br>");
                            }
                        }

                        // Formulario para editar la categoría
                        out.println("<form method='post'>");
                        out.println("<input type='text' name='nuevoNombre' value='" + nombreCategoria + "' required>");
                        out.println("<input type='submit' value='Actualizar Categoría'>");
                        out.println("</form>");
                    } else {
                        out.println("No se encontró la categoría.");
                    }

                    // Cerrar conexiones y recursos
                    if (rs != null) {
                        rs.close();
                    }
                    if (selectStmt != null) {
                        selectStmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (ClassNotFoundException | SQLException e) {
                    out.println("Error en la conexión a la base de datos: " + e.getMessage());
                }
            } else {
                out.println("ID de categoría no proporcionado.");
            }
        %>

        <!-- Botón para volver a la página de categorías -->
        <a href="../categoriasCRUD.jsp">REGRESAR
    </center>
</body>
</html>
