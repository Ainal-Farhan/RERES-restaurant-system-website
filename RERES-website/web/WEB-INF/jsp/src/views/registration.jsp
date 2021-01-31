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
                                <div class="card custom-shadow container-register bg-info" style="width:900px">
                                    <div class="card-header custom-shadow bg-light">
                                        <h3>Register Here</h3>
                                    </div>

                                    <div class="card-body custom-shadow bg-light">
                                        <form action="UserServlet" method="POST">
                                            <div class="row">
                                                <div class="col">
                                                    <div class="form-group">
                                                        <label for="name">Full name:</label>
                                                        <input type="text" class="form-control form-control-lg" placeholder="Enter full name" name="fullname" id="name" required>
                                                    </div>
                                                </div>
                                                <div class="col">
                                                    <div class="form-group">
                                                        <label for="username">Username:</label>
                                                        <input type="text" class="form-control form-control-lg" placeholder="Enter username" name="username" id="username" required>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group row">
                                                <div class="col">
                                                    <div class="form-group">
                                                        <label for="birthdate" id="age-label">Date of Birth:</label>
                                                        <input type="hidden" id="age" name="age">
                                                        <input type="date" class="form-control form-control-lg" onchange="calcAge()" placeholder="Enter you date of birth" id="birthdate" name="birthdate">
                                                        
                                                        <script>
                                                            function calcAge() {
                                                                const today = new Date();
                                                                const birthDate = new Date(document.getElementById('birthdate').value);

                                                                yearsDifference = today.getFullYear() - birthDate.getFullYear();

                                                                if (
                                                                    today.getMonth() < birthDate.getMonth() ||
                                                                    (today.getMonth() === birthDate.getMonth() && today.getDate() < birthDate.getDate())
                                                                ) {
                                                                    yearsDifference--;
                                                                }

                                                                document.getElementById('age').value = yearsDifference;
                                                                document.getElementById('age-label').innerHTML = "Date of Birth: (" + yearsDifference + " years old)";
                                                            };
                                                        </script>
                                                        
                                                    </div>
                                                </div>
                                                
                                                <div class="col">
                                                    Gender: <br/>
                                                    <div class="form-check form-check-inline form-control-lg">
                                                        <input type="radio" class="form-check-input" id="gender-male" name="gender" value="male" checked>
                                                        <label class="form-check-label" for="gender-male">Male</label>
                                                    </div>
                                                    <div class="form-check form-check-inline form-control-lg">
                                                        <input type="radio" class="form-check-input" id="gender-female" name="gender" value="female">
                                                        <label class="form-check-label" for="gender-female">Female</label>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="row">
                                                <div class="col">
                                                    <div class="form-group">
                                                        <label for="email">Email address:</label>
                                                        <input type="email" class="form-control form-control-lg" placeholder="Enter email" name="email" id="email" required>
                                                    </div>
                                                </div>
                                                <div class="col">
                                                    <div class="form-group">
                                                        <label for="phoneNumber">Phone number:</label>
                                                        <input type="text" class="form-control form-control-lg" placeholder="Enter phone number" name="phoneNumber" id="phoneNumber" required>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="row">
                                                <div class="col">
                                                    <div class="form-group">
                                                        <label for="pwd">Password:</label>
                                                        <input type="password" class="form-control form-control-lg" placeholder="Enter password" name="pwd" id="pwd" required>
                                                    </div>
                                                </div>
                                                <div class="col">
                                                    <div class="form-group">
                                                        <label for="confirmPwd">Confirm password:</label>
                                                        <input type="password" class="form-control form-control-lg" placeholder="Confirm password" name="confirmPwd" id="confirmPwd" required>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label for="address">Address:</label>
                                                <input type="text" class="form-control form-control-lg" placeholder="Enter address" name="address" id="address">
                                            </div>
                                            <div class="form-group row">
                                                <div class="col">
                                                    <label for="city">City</label>
                                                    <input type="text" class="form-control form-control-lg" placeholder="Enter city" name="city" id="city">
                                                </div>
                                                <div class="col">
                                                    <label for="poscode">Post Code:</label>
                                                    <input type="text" class="form-control form-control-lg" placeholder="Enter poscode" name="poscode" id="poscode">
                                                </div>
                                                <div class="col">
                                                    <label for="state">State</label>
                                                    <select class="form-control form-control-lg" id="state" name="state">
                                                        <option>Johor</option>
                                                        <option>Kedah</option>
                                                        <option>Kelantan</option>
                                                        <option>Melaka</option>
                                                        <option>Negeri Sembilan</option>
                                                        <option>Pahang</option>
                                                        <option>Penang</option>
                                                        <option>Perak</option>
                                                        <option>Perlis</option>
                                                        <option>Sabah</option>
                                                        <option>Sarawak</option>
                                                        <option>Selangor</option>
                                                        <option>Terengganu</option>
                                                        <option>Wilayah Persekutuan Kuala Lumpur</option>
                                                        <option>Wilayah Persekutuan Labuan</option>
                                                        <option>Wilayah Persekutuan Putrajaya</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="mt-3">
                                                <input type="hidden" name="userType" value="customer">
                                                <input type="hidden" name="action" value="registerUser">
                                                <input type="submit" class="btn btn-success btn-block btn-lg" value="Register"/>
                                            </div>
                                        </form>
                                        <div class="card-footer">
                                            Already registered? <a href="${pageContext.servletContext.contextPath}/LoginServlet?action=redirectLogin">Login here</a>
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
