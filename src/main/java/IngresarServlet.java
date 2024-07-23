import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ingresar")
public class IngresarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usuario = request.getParameter("usuario");
        String password = request.getParameter("clave");
        String rut = request.getParameter("rut");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Cuentas_clientes", "jp", "4r1c42012");
            PreparedStatement ps;

            ps = con.prepareStatement("SELECT p.rut FROM persona p JOIN usuario u ON p.usuario_id = u.id WHERE u.nombre_usuario = ? AND u.password = ? AND p.rut = ?");

            ps.setString(1, usuario);
            ps.setString(2, password);
            ps.setString(3, rut);
            ps.executeQuery();
           
            response.sendRedirect("personas.jsp?rut=" + rut);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ingresar.jsp?error=1");
        }
    }
}
