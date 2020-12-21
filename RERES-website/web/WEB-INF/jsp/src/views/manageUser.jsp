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
        
        <content>
            <div class="content-container">
                <div class="container">
                    <form>
                        <div class="form-group">
                            <h1>User Details</h1>
                        </div>

                        <div class="form-group form-row align-items-center">
                            <div class="col-2">
                                <label for="UserName">User Name</label>
                            </div>
                            <div class="col">
                                <input type="text" class="form-control" name="user-name" id="UserName">
                            </div>
                        </div>

                        <div class="form-group form-row align-items-center">
                            <div class="col">
                                <label for="UserAge">Age</label>
                            </div>
                            <div class="col">
                                <input type="number" class="form-control" name="user-age" id="UserAge" min="1">
                            </div>

                            <div class="col">
                                <label for="UserBirthDate">Birth Date</label>
                            </div>
                            <div class="col">
                                <input type="date" class="form-control" name="user-birth-date" id="UserBirthDate">
                            </div>
                        </div>

                        <div class="form-group form-row align-items-center">
                            <div class="col">
                                <label for="UserEmail">Email</label>
                            </div>
                            <div class="col">
                                <input type="email" class="form-control" name="user-email" id="UserEmail">
                            </div>

                            <div class="col">
                                <label for="UserPhoneNo">Phone No</label>
                            </div>
                            <div class="col">
                                <input type="text" class="form-control" name="user-phone-no" id="UserPhoneNo">
                            </div>
                        </div>

                        <div class="form-group form-row align-items-center">
                            <div class="col-2">
                                <label for="UserAddress">Address</label>
                            </div>
                            <div class="col">
                                <textarea class="form-control" name="user-address" id="UserAddress" cols="30" rows="4"></textarea>
                            </div>
                        </div>

                        <div class="form-group btn-group-manage-user">
                            <button class="btn btn-success">Update</button>
                            <button class="btn btn-primary">Back</button>
                            <button class="btn btn-danger">Delete</button>
                        </div>
                    </form>
                </div>
            </div>
        </content>
        
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
