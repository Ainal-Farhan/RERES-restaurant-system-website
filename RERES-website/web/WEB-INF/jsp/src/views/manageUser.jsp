<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage User Page</title>
        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <style><%@include file="../../../css/style/global.css"%></style>
        <style><%@include file="../../../css/style/manageUser.css"%></style>
    </head>
    <body>
        <header>
            <%@include file = "../components/navigationBar.jsp" %>
        </header>
        
            <jsp:useBean id="selectedUser" scope="request" class="com.RERES.model.User" />
        
        <div class="content-container">
            <div class="container manage-user-container">
                <form action="UserServlet" method="POST" onsubmit="return performSubmit()">
                    <div class="form-group">
                        <h1 style="text-align: center">User Details</h1>
                    </div>
                    <%  
                        String path = request.getContextPath();
                        String userType = (String)request.getAttribute("selectedUserType");
                        String profilePhoto = (String)request.getAttribute("selectedUserProfilePhoto");
                        
                        if(userType.toLowerCase().equals("staff")) {
                            path += com.RERES.path.Path.PROFILE_PICTURE_STAFF_PATH + "/" + profilePhoto; 
                        }
                        else if(userType.toLowerCase().equals("customer")) {
                            path += com.RERES.path.Path.PROFILE_PICTURE_CUSTOMER_PATH + "/" + profilePhoto; 
                        }
                    %>
                    <div class="form-group" style="display:block;margin-right:auto;margin-left:auto;width: 20%;">
                        <label><img src='<%= path %>' alt="profile photo" width="100%" height="100%" style="border-radius: 50%;"></label>
                    </div>
                    <div class="form-group form-row align-items-center">
                        <div class="col-2">
                            <label for="name">Name</label>
                        </div>
                        <div class="col">
                            <input type="text" class="form-control" name="name" id="Name" value="<jsp:getProperty name="selectedUser" property="name"/>" required>
                        </div>
                    </div>

                    <div class="form-group form-row align-items-center">
                        <div class="col-2">
                            <label for="UserID">User ID</label>
                        </div>
                        <div class="col">
                            <label class="form-control-plaint-text"><jsp:getProperty name="selectedUser" property="userID"/></label>
                        </div>
                        <div class="col-2">
                            <label for="UserName">Username</label>
                        </div>
                        <div class="col">
                            <label class="form-control-plaint-text"><jsp:getProperty name="selectedUser" property="username"/></label>
                        </div>
                    </div>

                    <div class="form-group form-row align-items-center">
                        <div class="col-2">
                            <label for="UserAge">Age</label>
                        </div>
                        <div class="col">
                            <input type="number" class="form-control" name="user-age" id="UserAge" min="1" value="<jsp:getProperty name="selectedUser" property="age"/>" required>
                        </div>

                        <div class="col-2">
                            <label for="UserBirthDate">Birth Date</label>
                        </div>
                        <div class="col">
                            <input type="date" class="form-control" name="user-birth-date" id="UserBirthDate" value="<jsp:getProperty name="selectedUser" property="birthDate"/>" required>
                        </div>
                    </div>

                    <div class="form-group form-row align-items-center">
                        <div class="col-2">
                            <label for="UserType">Type</label>
                        </div>
                        <div class="col">
                            <label class="form-control-plaint-text"><jsp:getProperty name="selectedUser" property="userType"/></label>
                        </div>

                        <div class="col-2">
                            <label for="UserGender">Gender</label>
                        </div>
                        <div class="col">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="male" value="male" >
                                <label class="form-check-label" for="male">Male</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="female" value="female">
                                <label class="form-check-label" for="female">Female</label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group form-row align-items-center">
                        <div class="col-2">
                            <label for="UserEmail">Email</label>
                        </div>
                        <div class="col">
                            <input type="email" class="form-control" name="user-email" id="UserEmail" value="<jsp:getProperty name="selectedUser" property="email"/>" required>
                        </div>

                        <div class="col-2">
                            <label for="UserPhoneNo">Phone No</label>
                        </div>
                        <div class="col">
                            <input type="text" class="form-control" name="user-phone-no" id="UserPhoneNo" value="<jsp:getProperty name="selectedUser" property="phoneNumber"/>" required>
                        </div>
                    </div>

                    <div class="form-group form-row align-items-center">
                        <div class="col-2">
                            <label for="UserAddress">Address</label>
                        </div>
                        <div class="col">
                            <textarea class="form-control" name="user-address" id="UserAddress" cols="30" rows="6" required style="resize:none;"><jsp:getProperty name="selectedUser" property="address"/></textarea>
                        </div>
                    </div>

                    <div class="form-group form-row align-items-center">
                        <% if((currentUserType.equalsIgnoreCase("staff") && userType.equals("staff")) || (currentUserType.equalsIgnoreCase("customer")) || (currentUserType.equalsIgnoreCase("admin"))) { %>
                        <input type="hidden" name="action" value="updateOrDeleteUser" required>
                        <button type="button" class="btn btn-success btn-group-manage-user" onclick="changeInputStatus(false)" id="update-btn">Update</button>
                        <input type="submit" class="btn btn-success btn-group-manage-user" id="save-btn" name="save-button" value="Save" onclick="updateConfirmation()">
                        <button type="button" class="btn btn-primary btn-group-manage-user" id="back-btn" onclick="changeInputStatus(true)">Back</button>
                        <% } %>
                        
                        <% if(currentUserType.equalsIgnoreCase("admin")) { %>
                        <input type="submit" class="btn btn-danger btn-group-manage-user" id="delete-btn" name="delete-button" value="Delete" onclick="deleteConfirmation()">
                        <% } %>
                        
                        
                    </div>
                </form>
            </div>
        </div>
                        
        <script>
            var gender = "<jsp:getProperty name="selectedUser" property="gender"/>";
            changeInputStatus(true);
            
            if(gender === "male") {
                document.getElementById("male").checked = true;
                document.getElementById("male").disabled = false;
                document.getElementById("female").disabled = true;
            }
            else if(gender === "female") {
                document.getElementById("female").checked = true;
                document.getElementById("female").disabled = false;
                document.getElementById("male").disabled = true;
            }
            
            function changeInputStatus(status) {
                document.getElementById("Name").readOnly = status;
                document.getElementById("UserAge").readOnly = status;
                document.getElementById("UserBirthDate").readOnly = status;
                document.getElementById("UserEmail").readOnly = status;
                document.getElementById("UserPhoneNo").readOnly = status;
                document.getElementById("UserAddress").readOnly = status;
                if(status !== true) {                    
                    document.getElementById("female").disabled = status;
                    document.getElementById("male").disabled = status;
                    <% if((currentUserType.equalsIgnoreCase("staff") && userType.equals("staff")) || (currentUserType.equalsIgnoreCase("customer")) || (currentUserType.equalsIgnoreCase("admin"))) { %>
                    document.getElementById("update-btn").style.display="none";
                    document.getElementById("back-btn").style.display="block";
                    document.getElementById("save-btn").style.display="block";
                    <% } %>
                    <% if(currentUserType.equalsIgnoreCase("admin")) { %>
                    document.getElementById("delete-btn").style.display="none";
                    <% } %>
                    
                } else {
                    if(gender === "male") {
                        document.getElementById("male").checked = true;
                        document.getElementById("male").disabled = false;
                        document.getElementById("female").disabled = true;
                    }
                    else if(gender === "female") {
                        document.getElementById("female").checked = true;
                        document.getElementById("female").disabled = false;
                        document.getElementById("male").disabled = true;
                    }
                    <% if((currentUserType.equalsIgnoreCase("staff") && userType.equals("staff")) || (currentUserType.equalsIgnoreCase("customer")) || (currentUserType.equalsIgnoreCase("admin"))) { %>
                    document.getElementById("update-btn").style.display="block";
                    document.getElementById("back-btn").style.display="none";
                    document.getElementById("save-btn").style.display="none";
                    <% } %>
                    <% if(currentUserType.equalsIgnoreCase("admin")) { %>
                    document.getElementById("delete-btn").style.display="block";
                    <% } %>
                    
                }
            }
            
            var statusSubmit = false;
            
            <%  if(currentUserType.equalsIgnoreCase("admin")) { %>
                function deleteConfirmation() {
                    statusSubmit = confirm("Delete user? please be advised as this action in irreversible");
                }
                <% } %>
            <%  if((currentUserType.equalsIgnoreCase("staff") && userType.equals("staff")) || (currentUserType.equalsIgnoreCase("customer")) || (currentUserType.equalsIgnoreCase("admin"))) { %>
                    function updateConfirmation() {
                        statusSubmit = confirm("Update Information?");
                    }
            <%  } %>
            
            function performSubmit() {
                return statusSubmit;
            }
        </script>
        
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
