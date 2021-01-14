<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.RERES.model.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List of Customers</title>
        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" crossorigin="anonymous">
        <style><%@include file="../../../css/style/global.css"%></style>
        <style><%@include file="../../../css/style/userList.css"%></style>
    </head>
    <body>
        <header>
            <%@include file = "../components/navigationBar.jsp" %>
        </header>
        
        <div class="content-container">                
            <div class="container-custom">
                <div class='table-responsive' id='customer-list'>
                    <table class='table table-hover table-view-list'>
                        <%  
                            // String currentUserType = (String)session.getAttribute("currentUserType");
                            String userType = (String)request.getAttribute("userType");
                            int length = (Integer)request.getAttribute("labelsLength");
                            
                            if(currentUserType.equalsIgnoreCase("admin")) {
                                length++;
                            }
                        %>
                        <thead>
                            <tr>
                                <th colspan='<c:out value="<%= length %>" />'><h1><c:out value="<%= userType %>" /></h1></th>
                            </tr>
                            <tr>
                                <c:forEach items="${requestScope.labels}" var="label" varStatus="loop">
                                    <th scope='col'><c:out value="${label}" /></th>
                                </c:forEach>
                                <%  
                                    if(currentUserType.equalsIgnoreCase("admin")) {
                                        out.println("<th scope='col'>Manage</th>");
                                    }
                                %>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var = "numberOfUsers" scope = "request" value = "${requestScope.users.size()}"/>

                            <c:if test = "${numberOfUsers == 0}">
                                <tr>
                                    <th scope='col' colspan='<c:out value="${fn:length(requestScope.labels)}" />'> There is no data available</th>
                                </tr>
                            </c:if>

                            <c:if test = "${numberOfUsers > 0}">                                    
                                <%  
                                    String path = "";
                                    if(userType.toLowerCase().equals("staff")) {
                                        path = com.RERES.path.Path.PROFILE_PICTURE_STAFF_PATH; 
                                    }
                                    else if(userType.toLowerCase().equals("customer")) {
                                        path = com.RERES.path.Path.PROFILE_PICTURE_CUSTOMER_PATH; 
                                    }
                                %>
                                <c:set var="profilePicturePath" value="<%= path %>" />
                                
                                <c:forEach items="${requestScope.users}" var="user" varStatus="loop">
                                    <tr>
                                        <th scope='row'><c:out value="${loop.index + 1}" /></th>
                                        <td><c:out value="${user.name}" /></td>
                                        <td><c:out value="${user.age}" /></td>
                                        <td><c:out value="${user.email}" /></td>
                                        <td><img src='<c:out value="${pageContext.servletContext.contextPath}${profilePicturePath}/${user.profilePhoto}"/>' width='30' height='30' alt="Profile Photo" /></td>
                                        <%  if(currentUserType.equalsIgnoreCase("admin")) { %>
                                        <td>
                                            <form action="UserServlet" method="POST">
                                                <input type="hidden" name="action" value="ViewAUser">
                                                <input type="hidden" name="userType" value="<%= userType %>">
                                                <input type="hidden" name="userID" value="<c:out value="${user.userID}" />">
                                                <input type="submit" class="btn btn-primary" style="height:30px;padding:0 5px 0 5px;border-radius:50%;" value="Go">
                                            </form>
                                        </td>
                                        <%    } %>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
                                
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
