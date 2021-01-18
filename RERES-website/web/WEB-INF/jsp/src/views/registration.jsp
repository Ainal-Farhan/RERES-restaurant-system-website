<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration Page</title>
        <style><%@include file="../../../css/style/global.css"%></style>
        <style><%@include file="../../../css/style/registration.css"%></style>
    </head>
    <body>
        <header>
            <%@include file = "../components/navigationBar.jsp" %>
            <%@include file = "../components/homeNavigationBar.jsp" %>
        </header>
        
        <content>
            <div class="content-container" style="background-image: none;padding-top: 0;">
                <div class="thumbnail">
                    <img class="img-responive" src="${pageContext.servletContext.contextPath}/assets/img/RERES/home.jpg" alt="home" style="width: 100%"/>
                    <div class="caption">
                        <div class="container-sm">
                            <div class="d-flex justify-content-center mb-3">
                                <div class="card" style="width:600px">
                                    <div class="card-header">
                                        <h3>Registration</h3>
                                    </div>

                                    <div class="card-body">
                                        <form action="RegistrationServlet" method="POST">
                                            <div class="form-group">
                                                <label for="name">Full name:</label>
                                                <input type="text" class="form-control" placeholder="Enter full name" id="name" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="address">Address:</label>
                                                <input type="text" class="form-control" placeholder="Enter address" id="address">
                                                <input type="text" class="form-control" placeholder="Enter city" id="city">
                                                <input type="text" class="form-control" placeholder="Enter poscode" id="poscode">
                                                <input type="text" class="form-control" placeholder="Enter state" id="state">
                                            </div>
                                            <div class="form-group">
                                                <label for="phoneNumber">Phone number:</label>
                                                <input type="text" class="form-control" placeholder="Enter phone number" id="phoneNumber" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="email">Email address:</label>
                                                <input type="email" class="form-control" placeholder="Enter email" id="email" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="userName">Username:</label>
                                                <input type="text" class="form-control" placeholder="Enter username" id="userName" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="pwd">Password:</label>
                                                <input type="password" class="form-control" placeholder="Enter password" id="pwd" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="confirmPwd">Confirm password:</label>
                                                <input type="password" class="form-control" placeholder="Confirm password" id="confirmPwd" required>
                                            </div>
                                            <button type="submit" class="btn btn-danger btn-block btn-lg">Register</button>
                                          </form>
                                    </div>

                                    <div class="card-footer">
                                        Already registered? <a href="${pageContext.servletContext.contextPath}/LoginServlet">Login here</a>
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
