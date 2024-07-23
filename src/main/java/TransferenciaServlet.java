import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/transferencia")
public class TransferenciaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String rutOrigen = request.getParameter("rutOrigen");
        String monto = request.getParameter("monto");
        String rutDestinatario = request.getParameter("rutDestinatario");
        String cuentaDestino = request.getParameter("cuentaDestino");
        String tipoCuenta = request.getParameter("tipoCuenta");

        Connection con = null;
        PreparedStatement ps = null;
       
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Cuentas_clientes", "jp", "4r1c42012");

            ps = con.prepareStatement("INSERT INTO transaccion (rut_dueño, monto_transferencia, cuenta_transferencia, tipo_cuenta) VALUES (?, ?, ?, ?)");
            ps.setString(1, rutOrigen);
            ps.setDouble(2, Double.parseDouble(monto));
            ps.setString(3, cuentaDestino);
            ps.setString(4, tipoCuenta);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("transferenciaexitosa.jsp?rutOrigen=" + rutOrigen + "&cuentaDestino=" + cuentaDestino + "&monto=" + monto);
            } else {
                response.sendRedirect("transferencias.jsp?error=1&rut=" + ps);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("transferencias.jsp?error=1&rut=" + e);
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

