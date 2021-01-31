<%@page import="com.RERES.references.SessionReference"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <style>
            <%@include file="../../../css/style/global.css"%>
            <%@include file="../../../css/style/home.css"%>
            
            .custom-shadow {
                box-shadow: 
                rgba(50, 50, 93, 0.25) 0px 50px 100px -20px, 
                rgba(0, 0, 0, 0.3) 0px 30px 60px -30px, 
                rgba(10, 37, 64, 0.35) 0px -2px 6px 0px inset;
            }
        </style>
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
            <div class="content-container">
                <div class="thumbnail text-center" style="padding-top:250px;">
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
                <%  } else { %>
                    <div class="caption">
                        <img src='data:image/png;base64, <%= session.getAttribute(SessionReference.PROFILE_PICTURE) %>' alt='Profile picture' width='200' height="200" style='border-radius:50%'>
                        <p class="p1">Welcome Back</p>
                        <p class="p1"><b><%= session.getAttribute(SessionReference.NAME) %></b></p>
                    </div>
                <%  } %>
                </div>
            </div>
            
        </content>
        
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
