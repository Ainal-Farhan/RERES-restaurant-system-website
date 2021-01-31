<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <style><%@include file="../../../css/style/global.css"%></style>
        <style><%@include file="../../../css/style/home.css"%></style>
    </head>
    <body>        
        <header>
            <% if(session.getAttribute("isAuthenticated") != null && (Boolean)session.getAttribute("isAuthenticated")){ %>
                
            <%@include file = "../components/navigationBar.jsp" %>
            <% } else { %>
            <%@include file = "../components/homeNavigationBar.jsp" %>
            <% } %>
            
        </header>
        <content>
            <div class="content-container" style="background-image: none;padding-top: 0;">
                
                <div class="thumbnail text-center">
                    
                    <img class="img-responive" src="${pageContext.servletContext.contextPath}/assets/img/RERES/home.jpg" alt="home" style="width: 100%"/>
                    <% if(session.getAttribute("isAuthenticated") == null || !(Boolean)session.getAttribute("isAuthenticated")){ %>
                    <div class="caption">
                        <p class="p1">Best Dining Experience You Will Get</p>
                        <a href="#">
                            <form action="RegistrationServlet" method="POST">
                                <input type="hidden" name="action" value="redirectRegister">
                                <input class="bigHomeBtn" type="submit" class="nav-link" value="Book a table now!">
                            </form>
                        </a>
                    </div>
                <% } %>
                </div>
            </div>
            
        </content>
        
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
