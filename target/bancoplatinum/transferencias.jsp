<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Transferencia - Banco Platinum</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>Transferencias Banco Platinum</h1>
        <%
            // Obtén la información del usuario actual
            Connection con = null;
            PreparedStatement psPersona = null;
            ResultSet rsPersona = null;

            String rut = request.getParameter("rut");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Cuentas_clientes", "jp", "4r1c42012");

                // Obtener información de la persona
                psPersona = con.prepareStatement("SELECT nombre, apellido FROM persona WHERE rut = ?");
                psPersona.setString(1, rut);
                rsPersona = psPersona.executeQuery();

                if (rsPersona.next()) {
                    String nombre = rsPersona.getString("nombre");
                    String apellido = rsPersona.getString("apellido");
        %>
        <div class="info">
            <h2>Información del usuario</h2>
            <p><strong>Nombre:</strong> <%= nombre %> <%= apellido %></p>
        </div>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p style='color:red;'>Error al recuperar los datos.</p>");
            } finally {
                try {
                    if (rsPersona != null) rsPersona.close();
                    if (psPersona != null) psPersona.close();
                    if (con != null) con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
        <div class="transaction">
            <h2>Formulario de transferencia</h2>
            <form action="transferencia" method="post">
            	<div class="form-group">
                    <label for="rutOrigen">Rut de la cuenta de origen:</label>
                    <input type="text" id="rutOrigen" name="rutOrigen" value="<%= rut %>" readonly>
                </div>
                <div class="form-group">
                    <label for="monto">Monto:</label>
                    <input type="number" id="monto" name="monto" step="0" required>
                </div>
                <div class="form-group">
                	<label for="rutDestinatario">Rut del destinatario:</label>
                    <input type="text" id="rutDestinatario" name="rutDestinatario" required>
                </div>
                <div class="form-group">
                    <label for="cuentaDestino">Número de cuenta a transferir:</label>
                    <input type="text" id="cuentaDestino" name="cuentaDestino" required>
                </div>
                <div class="form-group">
                    <label for="tipoCuenta">Tipo de cuenta de destino:</label>
                    <select id="tipoCuenta" name="tipoCuenta" required>
                        <option value="cuenta_corriente">Cuenta Corriente</option>
                        <option value="cuenta_vista">Cuenta Vista</option>
                        <option value="cuenta_rut">Cuenta RUT</option>
                    </select>
                </div>
                <input type="submit" value="Realizar Transferencia">
            </form>
        </div>
        <!-- Menú para cerrar sesión y realizar transferencias a otras cuentas del banco -->
        <br>
	    <div>
	        <button type="button" onclick="location.href='index.jsp'">Cerrar sesión</button>
	        <button type="button" onclick="location.href='transferencias.jsp?rut=<%=rut%>'">Realizar transferencia</button>
	        <button type="button" onclick="location.href='personas.jsp?rut=<%=rut%>'">Banca personas</button>
	    </div>
    </div>
</body>
</html>

