<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="css/loginstyle.css"/>
  <title>Login Librería JSP</title>
  <link rel="stylesheet" href="css/loginstyle.css"/>
</head>
<body>
  <div class="wrapper">
    <h1>Hola de nuevo!</h1>
    <p>Introduce tus credenciales <br> para ingresar!</p>
    <form method="post" action="LoginServlet">
      <input type="text" name="usuario" placeholder="Usuario">
      <input type="password" name="clave" placeholder="Contraseña">
      <p class="recover">
        <a href="#">Olvidé mi contraseña</a>
      </p>
      <button type="submit">Entrar</button>
    </form>
    <c:if test="${not empty requestScope.error}">
      <p class="error">${requestScope.error}</p>
    </c:if>
  </div>
</body>
</html>
