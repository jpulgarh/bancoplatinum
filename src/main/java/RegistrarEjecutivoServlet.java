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

@WebServlet("/registrarejecutivo")
public class RegistrarEjecutivoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String rut = request.getParameter("rut");
        String nombre = request.getParameter("nombre");
        String departamento = request.getParameter("departamento");
        String usuario = request.getParameter("usuario");
        String password = request.getParameter("clave");
        
        Connection con = null;
        PreparedStatement psEjecutivo = null;
        PreparedStatement psUsuario = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Cuentas_clientes", "jp", "4r1c42012");
            
            psUsuario = con.prepareStatement("INSERT INTO usuario (nombre_usuario, password) VALUES (?, ?)", PreparedStatement.RETURN_GENERATED_KEYS);
	        psUsuario.setString(1, usuario);
	        psUsuario.setString(2, password);
	        psUsuario.executeUpdate();
	        
	        rs = psUsuario.getGeneratedKeys();
            int usuarioId = 0;
            if (rs.next()) {
                usuarioId = rs.getInt(1);
            }
	        
            psEjecutivo = con.prepareStatement("INSERT INTO ejecutivo (rut, nombre, departamento, usuario_id) VALUES (?, ?, ?, ?)");
            psEjecutivo.setString(1, rut);
            psEjecutivo.setString(2, nombre);
            psEjecutivo.setString(3, departamento);
            psEjecutivo.setInt(4, usuarioId);
            psEjecutivo.executeUpdate();

            response.sendRedirect("bienvenido.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("registrarejecutivo.jsp?error=1");
        } finally {
            try {
            	if (rs != null) rs.close();
                if (psUsuario != null) psUsuario.close();
                if (psEjecutivo != null) psEjecutivo.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
