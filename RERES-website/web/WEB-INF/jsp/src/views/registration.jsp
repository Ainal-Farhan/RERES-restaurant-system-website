<%@page import="java.util.Calendar"%>
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
                                        <form action="UserServlet" method="POST" onSubmit='return validateForm()'>
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
                                                        <input type="text" class="form-control form-control-lg" autocomplete="username" placeholder="Enter username" name="username" id="username" required>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <% 
                                                Calendar calendar = Calendar.getInstance();

                                                // Getting the date a day after current date
                                                calendar.add(Calendar.YEAR, -16);

                                                // Getting the year of the date
                                                String yyyy = Integer.toString(calendar.get(Calendar.YEAR));

                                                // Create the date with the format of (YYYY-MM-DD), eg: 2020-01-31
                                                String maxDate = "" + yyyy + "-12-31";

                                            %>
                                            
                                            <div class="form-group row">
                                                <div class="col">
                                                    <div class="form-group">
                                                        <label for="birthdate" id="age-label">Date of Birth:</label>
                                                        <input type="hidden" id="age" name="age">
                                                        <input type="date" class="form-control form-control-lg" max="<%= maxDate %>" onchange="calcAge()" placeholder="Enter you date of birth" id="birthdate" name="birthdate">
                                                        <p id="ageErrorMessage" hidden></p>
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
                                                                
                                                                if(yearsDifference < 15) {
                                                                    document.getElementById("ageErrorMessage").hidden = false;
                                                                    document.getElementById("ageErrorMessage").innerHTML = "*You must be at least 15 years old to register";
                                                                    document.getElementById("ageErrorMessage").style.color = "red";
                                                                }
                                                                else {
                                                                    document.getElementById("ageErrorMessage").hidden = false;
                                                                    document.getElementById("ageErrorMessage").innerHTML = "*Looks Good";
                                                                    document.getElementById("ageErrorMessage").style.color = "green";
                                                                }

                                                                document.getElementById('age').value = yearsDifference;
                                                                document.getElementById('age-label').innerHTML = "Date of Birth: (" + yearsDifference + " years old)";
                                                            };
                                                        </script>
                                                        
                                                    </div>
                                                </div>
                                                
                                                <div class="col">
                                                    <div class="form-control-plaintext">
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
                                                        <input type="password" class="form-control form-control-lg" placeholder="Enter password" onchange="validatePassword()" name="pwd" id="pwd" autocomplete="new-password" required>
                                                        <p id='passMessage' hidden></p>
                                                    </div>
                                                </div>
                                                <div class="col">
                                                    <div class="form-group">
                                                        <label for="confirmPwd">Confirm password:</label>
                                                        <input type="password" class="form-control form-control-lg" placeholder="Confirm password" onchange="validatePassword()" autocomplete="new-password" name="confirmPwd" id="confirmPwd" required>
                                                        <p id='confirmPassMessage' hidden></p>
                                                    </div>
                                                </div>
                                                
                                                <script>
                                                    function validatePassword() {
                                                        const pass = document.getElementById("pwd").value;
                                                        const confirmPass = document.getElementById("confirmPwd").value;
                                                        
                                                        
                                                        if(pass.length < 8) {
                                                            document.getElementById("passMessage").innerHTML = "*Your password must be more than 7 characters";
                                                            document.getElementById("confirmPassMessage").innerHTML = "*Please fulfill our password requirement";
                                                            
                                                            document.getElementById("passMessage").hidden = false;
                                                            document.getElementById("confirmPassMessage").hidden = false;
                                                            
                                                            document.getElementById("passMessage").style.color = "red";
                                                            document.getElementById("confirmPassMessage").style.color = "red";
                                                            
                                                            document.getElementById("pwd").focus();
                                                            
                                                            return false;
                                                        }
                                                        else if(pass === confirmPass) {
                                                            document.getElementById("passMessage").innerHTML = "*Looks good";
                                                            document.getElementById("confirmPassMessage").innerHTML = "*Looks good";
                                                            
                                                            document.getElementById("passMessage").hidden = false;
                                                            document.getElementById("confirmPassMessage").hidden = false;
                                                            
                                                            document.getElementById("passMessage").style.color = "green";
                                                            document.getElementById("confirmPassMessage").style.color = "green";
                                                            
                                                            return true;
                                                        }
                                                        else {
                                                            document.getElementById("passMessage").innerHTML = "*Please enter the same password";
                                                            document.getElementById("confirmPassMessage").innerHTML = "*Please enter the same password";
                                                            
                                                            document.getElementById("passMessage").hidden = false;
                                                            document.getElementById("confirmPassMessage").hidden = false;
                                                            
                                                            document.getElementById("passMessage").style.color = "red";
                                                            document.getElementById("confirmPassMessage").style.color = "red";
                                                            
                                                            document.getElementById("confirmPwd").focus();
                                                            
                                                            return false;
                                                        }
                                                    }
                                                </script>
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
                                                        
                                        <script>
                                            function validateForm() {
                                                if (!validatePassword()) {
                                                    return false;
                                                }
                                                
                                                return true;
                                            }
                                        </script>
                                        <div class="card-footer">
                                            <p>Already registered? <a href="${pageContext.servletContext.contextPath}/LoginServlet?action=redirectLogin">Login here</a></p>
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
