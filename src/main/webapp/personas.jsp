<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Plataforma Banco Platinum</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>Bienvenido a Banco Platinum</h1>
        <p>Estado de cuenta</p>
        <%
            Connection con = null;
            PreparedStatement psPersona = null;
            PreparedStatement psCuentaCorriente = null;
            ResultSet rsPersona = null;
            ResultSet rsCuentaCorriente = null;

            String rut = request.getParameter("rut");

            if (rut != null) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Cuentas_clientes", "jp", "4r1c42012");

                    // Obtener información de la persona
                    psPersona = con.prepareStatement("SELECT nombre, apellido, correo, telefono FROM persona WHERE rut = ?");
                    psPersona.setString(1, rut);
                    rsPersona = psPersona.executeQuery();

                    if (rsPersona.next()) {
                        String nombre = rsPersona.getString("nombre");
                        String apellido = rsPersona.getString("apellido");
                        String correo = rsPersona.getString("correo");
                        String telefono = rsPersona.getString("telefono");
        %>
        <div class="info">
            <h2>Detalles de la persona</h2>
            <p><strong>Nombre:</strong> <%= nombre %> <%= apellido %></p>
            <p><strong>Correo:</strong> <%= correo %></p>
            <p><strong>Teléfono:</strong> <%= telefono %></p>
        </div>
        <%
                    }

                    // Obtener información de la cuenta corriente
                    psCuentaCorriente = con.prepareStatement("SELECT monto, ejecutivo FROM cta_corriente WHERE rut_cliente = ?");
                    psCuentaCorriente.setString(1, rut);
                    rsCuentaCorriente = psCuentaCorriente.executeQuery();

                    if (rsCuentaCorriente.next()) {
                        double monto = rsCuentaCorriente.getDouble("monto");
                        String ejecutivo = rsCuentaCorriente.getString("ejecutivo");
        %>
        <div class="info">
            <h2>Detalles de la cuenta corriente</h2>
            <p><strong>Monto:</strong> $<%= monto %></p>
            <p><strong>Ejecutivo:</strong> <%= ejecutivo %></p>
        </div>
        <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p style='color:red;'>Error al recuperar los datos.</p>");
                } finally {
                    try {
                        if (rsPersona != null) rsPersona.close();
                        if (rsCuentaCorriente != null) rsCuentaCorriente.close();
                        if (psPersona != null) psPersona.close();
                        if (psCuentaCorriente != null) psCuentaCorriente.close();
                        if (con != null) con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            } else {
                out.println("<p style='color:red;'>Error: No se ha encontrado el RUT en la solicitud.</p>");
            }
        %>
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
