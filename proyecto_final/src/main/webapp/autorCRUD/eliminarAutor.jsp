<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Eliminar Autor</title>
    <link rel="stylesheet" href="../css/autoresStyle.css"/>
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

        /* Estilos para el botón */
        .btn {
            background-color: #f44336;
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

        .btn:hover {
            background-color: #d32f2f;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Eliminar Autor</h1>

        <%
            // Verificar si se ha enviado un ID de autor para eliminar
            String idAutorStr = request.getParameter("id");
            if (idAutorStr != null) {
                try {
                    // Conexión a la base de datos (ajusta las credenciales según tu configuración)
                    String DB_URL = "jdbc:mysql://localhost:3306/libajdbd2561203?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=America/Bogota";
                    String DB_USER = "alejo16";
                    String DB_PASSWORD = "holamundo";

                    Connection conn = null;
                    PreparedStatement stmt = null;

                    int idAutor = Integer.parseInt(idAutorStr);

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                    // Eliminar el autor con el ID especificado
                    String deleteSql = "DELETE FROM autores WHERE id_autor = ?";
                    stmt = conn.prepareStatement(deleteSql);
                    stmt.setInt(1, idAutor);

                    int rowsAffected = stmt.executeUpdate();

                    if (rowsAffected > 0) {
                        out.println("<p>Autor eliminado exitosamente.</p>");
                    } else {
                        out.println("<p>No se pudo eliminar el autor.</p>");
                    }

                    // Cerrar la conexión
                    conn.close();
                } catch (ClassNotFoundException | SQLException | NumberFormatException e) {
                    out.println("Error en la conexión a la base de datos: " + e.getMessage());
                }
            }
        %>

        <!-- Botón de regreso a la lista de autores -->
        <a class="btn" href="../autoresCRUD.jsp">Regresar a la lista de autores</a>
    </div>
</body>
</html>
