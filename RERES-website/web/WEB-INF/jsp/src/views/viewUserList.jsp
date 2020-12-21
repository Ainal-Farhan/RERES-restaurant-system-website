<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View user List Page</title>
        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <style><%@include file="../../../css/style/global.css"%></style>
        <style><%@include file="../../../css/style/userList.css"%></style>
    </head>
    <body>
        <header>
            <%@include file = "../components/navigationBar.jsp" %>
        </header>
        
        <content>
            <div class="content-container">
                <div class="container">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th colspan="4">Staff/ Customer</th>
                                </tr>
                                <tr>
                                    <th scope="col">No</th>
                                    <th scope="col">First Name</th>
                                    <th scope="col">Age</th>
                                    <th scope="col">manage</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th scope="row">1</th>
                                    <td>Mark</td>
                                    <td>21</td>
                                    <td><button class="btn btn-primary btn-manage-user-list">Manage</button></td>
                                </tr>
                            </tbody>
                        </table>
                        <button class="btn btn-primary btn-back-user-list">Back</button>
                    </div>
                </div>
            </div>
        </content>
        
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
