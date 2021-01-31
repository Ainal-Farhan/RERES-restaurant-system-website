<%-- 
    Document   : bookNavigationBar
    Created on : Jan 9, 2021, 2:37:48 PM
    Author     : Hasan Mubarak
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style><%@include file="../../../css/style/navigationBar.css"%></style>
        <title>JSP Page</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
            
            <a class="navbar-brand ml-4" href="${pageContext.servletContext.contextPath}/index.jsp">
                <h2><i class="fas fa-angle-left"></i> Back</h2>
            </a>
            <h2 class="bookTitle">Select Date and time for your reservation</h2>
                
        </nav>
    </body>
</html>
