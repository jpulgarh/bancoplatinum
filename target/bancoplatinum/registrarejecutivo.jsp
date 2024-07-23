<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrar Ejecutivo</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="container">
        <h2>Registrar Ejecutivo</h2>
        <form action="registrarejecutivo" method="post">
            <div class="form-group">
                <label for="rut">RUT:</label>
                <input type="text" id="rut" name="rut">
            </div>
            <div class="form-group">
                <label for="nombre">Nombre:</label>
                <input type="text" id="nombre" name="nombre">
            </div>
            <div class="form-group">
                <label for="departamento">Departamento:</label>
                <input type="text" id="departamento" name="departamento">
            </div>
            <div class="form-group">
                <label for="usuario">Nombre de usuario:</label>
                <input type="text" id="usuario" name="usuario">
            </div>
            <div class="form-group">
                <label for="clave">Clave:</label>
                <input type="password" id="clave" name="clave">
            </div>
            <input type="submit" value="Registrar Ejecutivo">
        </form>
        <%
	        if (request.getParameter("error") != null) {
	            out.println("<p style='color:red;'>Error al ingresar las credenciales</p>");
	        }
	    %>
    </div>
</body>
</html>
