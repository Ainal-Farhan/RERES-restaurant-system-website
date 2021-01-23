<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
    </head>
    <body>
        <% request.setAttribute("selectedPage", "homePage"); %>
        <%@include file = "WEB-INF/jsp/src/views/home.jsp" %>
    </body>
</html>
