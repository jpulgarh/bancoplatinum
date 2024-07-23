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
        <h1>Detalle de la transferencia</h1>
        <%
            String rutOrigen = request.getParameter("rutOrigen");
        	String cuentaDestino = request.getParameter("cuentaDestino");
        	String monto = request.getParameter("monto");
        %>
        <div class="info">
            <h2>Transferencia realizada con &eacute;xito</h2>
            <p><strong>Desde:</strong> <%= rutOrigen %></p>
            <p><strong>Cuenta de destino:</strong> <%= cuentaDestino %></p>
            <p><strong>Monto:</strong>$ <%= monto %></p>
        </div>
        <!-- Menú para cerrar sesión y realizar transferencias a otras cuentas del banco -->
        <br>
	    <div>
	        <button type="button" onclick="location.href='index.jsp'">Cerrar sesión</button>
	        <button type="button" onclick="location.href='transferencias.jsp?rut=<%=rutOrigen%>'">Realizar transferencia</button>
	        <button type="button" onclick="location.href='personas.jsp?rut=<%=rutOrigen%>'">Banca personas</button>
	    </div>
    </div>
</body>
</html> 