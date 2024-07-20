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
        String rut = request.getParameter("rut");
        String password = request.getParameter("password");
        String tipo = request.getParameter("tipo");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Cuentas_clientes", "jp", "4r1c42012");
            PreparedStatement ps;

            if ("ejecutivo".equals(tipo)) {
                ps = con.prepareStatement("SELECT * FROM ejecutivo WHERE rut=? AND password=?");
            } else {
                ps = con.prepareStatement("SELECT * FROM persona WHERE rut=? AND password=?");
            }

            ps.setString(1, rut);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                if ("ejecutivo".equals(tipo)) {
                    request.getRequestDispatcher("bienvenido.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("personas.jsp").forward(request, response);
                }
            } else {
                response.sendRedirect("ingresar.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
