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
            <%@include file = "../components/navigationBar.jsp" %>
            <%@include file = "../components/homeNavigationBar.jsp" %>
        </header>
        
        <content>
            <div class="content-container">
                <div class="thumbnail text-center">
                    <img class="img-responive" src="${pageContext.servletContext.contextPath}/assets/img/RERES/home.jpg" alt="home" style="width: 100%"/>
                    <div class="caption">
                        <p class="p1">Best Dining Experience You Will Get</p>
                      <a href="${pageContext.servletContext.contextPath}/RegistrationServlet">
                          <button class="bigHomeBtn" type="button">Book a table now!</button>
                      </a>
                    </div>
                </div>
                
            </div>
            
        </content>
        
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
