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
            <%@include file = "../components/homeNavigationBar.jsp" %>
        </header>
        
        <content>
            <div class="content-container" style="background-image: none;padding-top: 0;">
                <div class="thumbnail">
                    <img class="img-responive" src="${pageContext.servletContext.contextPath}/assets/img/RERES/home.jpg" alt="home" style="width: 100%"/>
                    <div class="caption">
                        <div class="container-sm">
                            <div class="d-flex justify-content-center mb-3">
                                <div class="card  custom-shadow container-login bg-info" style="width:600px">
                                    <div class="card-header custom-shadow bg-light">
                                        <h3>Login</h3>
                                    </div>

                                    <div class="card-body custom-shadow bg-light">
                                        <form action="UserServlet" method="POST">
                                            <div class="form-group">
                                                <label for="usernameOrEmail">Username/Email:</label>
                                                <input type="text" class="form-control form-control-lg" placeholder="Enter username" name="usernameOrEmail" id="username" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="pwd">Password:</label>
                                                <input type="password" class="form-control form-control-lg" placeholder="Enter password" name="pwd" id="pwd" required>
                                            </div>
                                            <input type="hidden" name="action" value="authLogin"/>
                                            <input type="submit" class="btn btn-success btn-block btn-lg" value="Login"/>
                                        </form>
                                        
                                        <div class="card-footer">
                                            New to RERES? <a href="${pageContext.servletContext.contextPath}/RegistrationServlet?action=redirectRegister">Register here</a>
                                        </div>
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
