<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <style><%@include file="../../../css/style/global.css"%></style>
        <style><%@include file="../../../css/style/login.css"%></style>
    </head>
    <body>
        <header>
            <%@include file = "../components/navigationBar.jsp" %>
            <%@include file = "../components/homeNavigationBar.jsp" %>
        </header>
        
        <content>
            <div class="content-container">
                <div class="thumbnail">
                    <img class="img-responive" src="${pageContext.servletContext.contextPath}/assets/img/RERES/home.jpg" alt="home" style="width: 100%"/>
                    <div class="caption">
                        <div class="container-sm">
                            <div class="d-flex justify-content-center mb-3">
                                <div class="card" style="width:600px">
                                    <div class="card-header">
                                        <h3>Login</h3>
                                    </div>

                                    <div class="card-body">
                                        <form action="LoginServlet" method="POST">
                                            <div class="form-group">
                                                <label for="name">Full name:</label>
                                                <input type="text" class="form-control" placeholder="Enter full name" id="name" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="pwd">Password:</label>
                                                <input type="password" class="form-control" placeholder="Enter password" id="pwd" required>
                                            </div>
                                            
                                            <button type="submit" class="btn btn-danger btn-block btn-lg">Login</button>
                                            
                                          </form>
                                    </div>

                                    <div class="card-footer">
                                        <a href="#">Forgot Password?</a><br/>
                                        New to RERES? <a href="${pageContext.servletContext.contextPath}/LoginServlet">Register here</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>    
            </div>
        </content>
        
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
