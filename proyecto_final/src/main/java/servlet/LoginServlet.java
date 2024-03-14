package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    // Configura tu fuente de datos (DataSource) aquí
    private static final String DB_URL = "jdbc:mysql://localhost:3306/libajdbd2561203?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=America/Bogota";
    private static final String DB_USER = "alejo16"; // Reemplaza con tu usuario de MySQL
    private static final String DB_PASSWORD = "holamundo"; // Reemplaza con tu contraseña de MySQL

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String usuarioIngresado = request.getParameter("usuario");
            String claveIngresada = request.getParameter("clave");
            
            // Iniciar la conexión a la base de datos
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                String sql = "SELECT * FROM usuarios_ajd WHERE usuario = ? AND clave = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, usuarioIngresado);
                pstmt.setString(2, claveIngresada);
                ResultSet rs = pstmt.executeQuery();

                boolean autenticado = rs.next();
                conn.close();

                if (autenticado) {
                    // Usuario autenticado, redirige a la página principal
                    response.sendRedirect("index.jsp");
                } else {
                    // Usuario no autenticado, muestra un mensaje de error
                    response.sendRedirect("ErrorLogin.jsp");
                }
            } catch (ClassNotFoundException | SQLException e) {
                out.println("Error en la conexión a la base de datos: " + e.getMessage());
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    public String getServletInfo() {
        return "Short description";
    }
}
