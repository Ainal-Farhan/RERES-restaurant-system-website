<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.RERES.path.Path"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    </head>
    <body>
        <nav class="navbar navbar-expand-sm bg-light navbar-light">
            <a class="navbar-brand ml-4" href="${pageContext.servletContext.contextPath}/index.jsp">
                <img src="${pageContext.servletContext.contextPath}/assets/img/RERES/RERES-logo.png" alt="logo" style="width: 90px;">
            </a>
            
            <div class="navbar-collapse collapse w-100 order-3 dual-collapse2">
                <ul class="navbar-nav ml-auto mr-4">
                    <li class="nav-item">
                      <a class="nav-link" href="#">
                        <form action="LoginServlet" method="POST">
                            <input type="hidden" name="action" value="redirectLogin">
                            <input class="btn  btn-warning" type="submit" class="nav-link" value="Login">
                        </form>
                      </a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" href="${pageContext.servletContext.contextPath}/RegistrationServlet">
                        <form action="RegistrationServlet" method="POST">
                            <input type="hidden" name="action" value="redirectRegister">
                            <input class="border border-warning btn  btn-light" type="submit" class="nav-link" value="Register">
                        </form>
                      </a>
                    </li>
                </ul>
            </div>
                
        </nav>
    </body>
</html>
