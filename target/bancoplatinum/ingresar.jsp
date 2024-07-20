<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Iniciar sesión</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="form-container">
        <form action="ingresar" method="post">
            <label for="rut">RUT:</label>
            <input type="text" id="rut" name="rut"><br>
            <label for="password">Clave:</label>
            <input type="password" id="password" name="password"><br>
            <label>Tipo de usuario:</label>
            <input type="radio" id="ejecutivo" name="tipo" value="ejecutivo">
            <label for="ejecutivo">Ejecutivo</label><br>
            <input type="radio" id="persona" name="tipo" value="persona">
            <label for="persona">Persona</label><br>
            <input type="submit" value="Ingresar">
        </form>
        <% if (request.getParameter("error") != null) { %>
            <p class="error">Credenciales de acceso inválidas</p>
        <% } %>
    </div>
</body>
</html>

