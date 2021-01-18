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
            <%@include file = "../components/homeNavigationBar.jsp" %>
        </header>
        
        <content>
            <div class="content-container" style="background-image: none;padding-top: 0;">
                <div class="thumbnail">
                    <img class="img-responive" src="${pageContext.servletContext.contextPath}/assets/img/RERES/home.jpg" alt="home" style="width: 100%"/>
                    <div class="caption">
                        <div class="container-sm">
                            <div class="d-flex justify-content-center mb-3">
                                <div class="card" style="width:900px">
                                    <div class="card-header">
                                        <h3>Register Here</h3>
                                    </div>

                                    <div class="card-body">
                                        <form action="UserServlet" method="POST">
                                            <div class="row">
                                                <div class="col">
                                                    <div class="form-group">
                                                        <!--<label for="name">Full name:</label>-->
                                                        <input type="text" class="form-control form-control-lg" placeholder="Enter full name" name="fullname" id="name" required>
                                                    </div>

                                                    <div class="form-group">
                                                        <!--<label for="phoneNumber">Phone number:</label>-->
                                                        <input type="text" class="form-control form-control-lg" placeholder="Enter phone number" name="phoneNumber" id="phoneNumber" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <!--<label for="email">Email address:</label>-->
                                                        <input type="email" class="form-control form-control-lg" placeholder="Enter email" name="email" id="email" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <!--<label for="username">Username:</label>-->
                                                        <input type="text" class="form-control form-control-lg" placeholder="Enter username" name="username" id="username" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <!--<label for="pwd">Password:</label>-->
                                                        <input type="password" class="form-control form-control-lg" placeholder="Enter password" name="pwd" id="pwd" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <!--<label for="confirmPwd">Confirm password:</label>-->
                                                        <input type="password" class="form-control form-control-lg" placeholder="Confirm password" name="confirmPwd" id="confirmPwd" required>
                                                    </div>
                                                </div>
                                                
                                                <div class="col">
                                                    <div class="form-group">
                                                        <!--<label for="address">Address:</label>-->
                                                        <input type="text" class="form-control form-control-lg" placeholder="Enter address" name="address" id="address">
                                                        <input type="text" class="form-control form-control-lg" placeholder="Enter city" name="city" id="city">
                                                        <input type="text" class="form-control form-control-lg" placeholder="Enter poscode" name="poscode" id="poscode">
                                                        <input type="text" class="form-control form-control-lg" placeholder="Enter state" name="state" id="state">
                                                    </div>
                                                    <div class="form-group">
                                                        <input type="number" class="form-control form-control-lg" placeholder="Enter your age" name="age" min="1">
                                                    </div>
                                                    <div class="form-group">
                                                        <input type="date" class="form-control form-control-lg" placeholder="Enter you date of birth" name="birthdate">
                                                    </div>
                                                    <div class="form-check-inline form-control-lg">
                                                        <label class="form-check-label">
                                                            <input type="radio" class="form-check-input" name="gender" value="male">Male
                                                        </label>
                                                    </div>
                                                    <div class="form-check-inline form-control-lg">
                                                        <label class="form-check-label">
                                                          <input type="radio" class="form-check-input" name="gender" value="female">Female
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="mt-3">
                                            <input type="hidden" name="userType" value="customer">
                                            <input type="hidden" name="action" value="registerUser">
                                            <input type="submit" class="btn btn-danger btn-block btn-lg" value="Register"/>
                                            </div>
                                          </form>
                                    </div>

                                    <div class="card-footer">
                                        Already registered? <a href="${pageContext.servletContext.contextPath}/LoginServlet?action=redirectLogin">Login here</a>
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
