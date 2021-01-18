<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Index Page</title>
    </head>
    <body>
        <%
            if(request.getParameter("currentUserType") == null || request.getParameter("currentUserType").equals("")) {
                session.setAttribute("currentUserType", "admin");   
                session.setAttribute("currentUserID", 1);
            }
            else {
                session.setAttribute("currentUserType", request.getParameter("currentUserType"));
                session.setAttribute("currentUserID", Integer.parseInt(request.getParameter("currentUserID")));
            }
        %>
        <%@include file = "WEB-INF/jsp/src/views/home.jsp" %>
    </body>
</html>
