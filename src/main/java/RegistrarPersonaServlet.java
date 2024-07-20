import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/registrarpersona")
public class RegistrarPersonaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String rut = request.getParameter("rut");
    	String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String direccion = request.getParameter("direccion");
        String correo = request.getParameter("correo");
        String telefono = request.getParameter("telefono");
        String nombreMascota = request.getParameter("nombreMascota");
        String clave = request.getParameter("clave");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Cuentas_clientes", "jp", "4r1c42012");
            PreparedStatement ps = con.prepareStatement("INSERT INTO persona (rut, nombre, apellido, direccion, correo, telefono, nombre_mascota, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            ps.setString(1, rut);
            ps.setString(2, nombre);
            ps.setString(3, apellido);
            ps.setString(4, direccion);
            ps.setString(5, correo);
            ps.setString(6, telefono);
            ps.setString(7, nombreMascota);
            ps.setString(8, clave);
            ps.executeUpdate();

            response.sendRedirect("ingresar.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
