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
import jakarta.servlet.http.HttpSession;

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
        String nombre_usuario = request.getParameter("usuario");
        String password = request.getParameter("clave");
        String ejecutivoRut = request.getParameter("ejecutivo");
        double montoInicial = 0.0;
        
        Connection con = null;
        PreparedStatement psUsuario = null;
        PreparedStatement psPersona = null;
        PreparedStatement psCuentaCorriente = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Cuentas_clientes", "jp", "4r1c42012");

            psUsuario = con.prepareStatement("INSERT INTO usuario (nombre_usuario, password) VALUES (?, ?)", PreparedStatement.RETURN_GENERATED_KEYS);
	        psUsuario.setString(1, nombre_usuario);
	        psUsuario.setString(2, password);
	        psUsuario.executeUpdate();
	        
	        rs = psUsuario.getGeneratedKeys();
            int usuarioId = 0;
            if (rs.next()) {
                usuarioId = rs.getInt(1);
            }
	
            psPersona = con.prepareStatement("INSERT INTO persona (rut, nombre, apellido, direccion, correo, telefono, nombre_mascota, usuario_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
	        psPersona.setString(1, rut);
	        psPersona.setString(2, nombre);
	        psPersona.setString(3, apellido);
	        psPersona.setString(4, direccion);
	        psPersona.setString(5, correo);
	        psPersona.setString(6, telefono);
	        psPersona.setString(7, nombreMascota);
	        psPersona.setInt(8, usuarioId);
	        psPersona.executeUpdate();
	       
            psCuentaCorriente = con.prepareStatement("INSERT INTO cta_corriente (rut_cliente, monto, ejecutivo) VALUES (?, ?, ?)");
            psCuentaCorriente.setString(1, rut);
            psCuentaCorriente.setDouble(2, montoInicial);
            psCuentaCorriente.setString(3, ejecutivoRut);
            psCuentaCorriente.executeUpdate();

            response.sendRedirect("personas.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", e.getMessage());
            response.sendRedirect("registrarpersona.jsp?error=1");
        } finally {
            try {
            	if (rs != null) rs.close();
                if (psUsuario != null) psUsuario.close();
                if (psPersona != null) psPersona.close();
                if (psCuentaCorriente != null) psCuentaCorriente.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
