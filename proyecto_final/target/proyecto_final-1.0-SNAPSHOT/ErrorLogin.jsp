<%-- 
    Document   : ErrorLogin
    Created on : 22/09/2023, 2:38:21 p. m.
    Author     : alejo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="css/loginstyle.css"/>
    <title>Error de autenticación</title>
    <style>
        
        body {
            background-color: #f0f0f0;
        }
        .container {
            text-align: center;
            margin-top: 100px;
        }
        h1 {
            color: red;
        }
        .error-message {
            margin-top: 20px;
            font-size: 18px;
        }
        .retry-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <img src="img/iconError.png" alt="Icono de error" width="200" height="200">
        <h1>Lo sentimos</h1>
        <p class="error-message">Verifica que tu usuario y contraseña sean los correctos.</p>
        <p class="error-message">Tienes algunos intentos, de lo contrario tu cuenta será bloqueada.</p>
        <a href="login.jsp" class="retry-button">Volver a intentarlo</a>
    </div>
</body>
</html>
