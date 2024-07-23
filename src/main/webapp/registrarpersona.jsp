<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registrar persona</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="container">
        <h2>Registrar persona</h2>
        <%
            List<String> ejecutivos = new ArrayList<>();
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            String errorMessage = (String) session.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
        <p style="color: red;"><%= errorMessage %></p>
        <%
                session.removeAttribute("errorMessage");
            }

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Cuentas_clientes", "jp", "4r1c42012");

                // Consultar por los ejecutivos del Banco Platinum
                ps = con.prepareStatement("SELECT rut, nombre FROM ejecutivo");
                rs = ps.executeQuery();

                while (rs.next()) {
                    String rut = rs.getString("rut");
                    String nombre = rs.getString("nombre");
                    ejecutivos.add(rut);
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("errorMessage", e.getMessage());
                response.sendRedirect("registrarpersona.jsp?error=1");
                return; // Sale en caso de error
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (con != null) con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
        <form action="registrarpersona" method="post">
            <div class="form-group">
                <label for="nombre">Nombre:</label>
                <input type="text" id="nombre" name="nombre">
            </div>
            <div class="form-group">
                <label for="apellido">Apellido:</label>
                <input type="text" id="apellido" name="apellido">
            </div>
            <div class="form-group">
                <label for="rut">RUT:</label>
                <input type="text" id="rut" name="rut">
            </div>
            <div class="form-group">
                <label for="direccion">Dirección:</label>
                <input type="text" id="direccion" name="direccion">
            </div>
            <div class="form-group">
                <label for="correo">Correo:</label>
                <input type="email" id="correo" name="correo">
            </div>
            <div class="form-group">
                <label for="telefono">Teléfono:</label>
                <input type="text" id="telefono" name="telefono">
            </div>
            <div class="form-group">
                <label for="nombreMascota">Nombre de la mascota:</label>
                <input type="text" id="nombreMascota" name="nombreMascota">
            </div>
            <div class="form-group">
                <label for="usuario">Nombre de usuario:</label>
                <input type="text" id="usuario" name="usuario">
            </div>
            <div class="form-group">
                <label for="clave">Clave:</label>
                <input type="password" id="clave" name="clave">
            </div>
            <div class="form-group">
                <label for="ejecutivo">RUT del ejecutivo:</label>
                <select id="ejecutivo" name="ejecutivo">
                    <%
                        for (String ejecutivo : ejecutivos) {
                    %>
                    <option value="<%= ejecutivo.split(" - ")[0] %>"><%= ejecutivo %></option>
                    <%
                        }
                    %>
                </select>
            </div>
            <input type="submit" value="Registrar persona">
        </form>
        <%
            if (request.getParameter("error") != null) {
                out.println("<p style='color:red;'>Error al ingresar las credenciales</p>");
            }
        %>
    </div>
</body>
</html>


