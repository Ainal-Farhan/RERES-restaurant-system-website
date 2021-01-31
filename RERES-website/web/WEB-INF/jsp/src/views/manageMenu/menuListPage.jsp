<%-- 
    Document   : menuListPage
    Created on : Jan 27, 2021, 5:12:43 PM
    Author     : ainal farhan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Menu</title>
        <style><%@include file="../../../../css/style/global.css"%></style>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    </head>
    <body>
        <header>
            <%@include file = "../../components/navigationBar.jsp" %>
        </header>
        
        <div class="content-container">
            <div class="container-custom bgContent bg-light p-4">
                <div class="row">
                    <div class="col-10">
                        <table class="table table-striped mt-2">
                            <thead class="thead-dark">
                                <tr>
                                    <th>No</th>
                                    <th style="text-align:center;">Food Image</th>
                                    <th>Food Name</th>
                                    <th>Food Price</th>
                                    <th>Food Description</th>
                                    <th>Food Category</th>
                                    <th style="text-align:center;">Manage</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${requestScope.allFoodList}" var="food" varStatus="loop">
                                <tr>
                                    <td class="align-middle"><h5><c:out value="${loop.index + 1}" /></h5></td>
                                    <td class="align-middle"><img id="profilePicture" src='ManageFoodServlet?action=getFoodImage&foodID=<c:out value="${food.foodID}" />' alt="profile picture" class="mx-auto d-block custom-shadow" width="100" height="100" style="border-radius: 50%;"></td>
                                    <td class="align-middle"><c:out value="${food.foodName}" /></td>
                                    <td class="align-middle">RM <fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${food.foodPrice}"/></td>
                                    <td class="align-middle"><c:out value="${food.foodDescription}" /></td>
                                    
                                    <td class="align-middle"><c:out value="${food.foodCategory}" /></td>
                                    <td class="align-middle" style="text-align:center;">
                                        <div style="padding: 3px 3px 3px 3px;">
                                            <form action="ManageFoodServlet" method="POST">
                                                <input type="hidden" name="action" value="goToUpdateFood">
                                                <input type="hidden" name="foodID" value="<c:out value="${food.foodID}" />">
                                                <button tupe="submit" class="btn btn-info btn-sm" style="width:100px;" value="Update"><i class="far fa-edit"></i> Update</button>
                                            </form>
                                        </div>
                                            
                                        <div style="padding: 3px 3px 3px 3px;">
                                            <form action="ManageFoodServlet" method="POST" onsubmit="return confirmDelete()">
                                                <input type="hidden" name="action" value="deleteFood">
                                                <input type="hidden" name="foodID" value="<c:out value="${food.foodID}" />">
                                                <button type="submit" class="btn btn-sm btn-danger" style="width:100px;"><i class="far fa-trash-alt"></i> Delete</button>
                                            </form>
                                                
                                            <script>
                                                function confirmDelete() {
                                                    return confirm("Delete this menu? Please be advised that this action is nonreversible");
                                                }
                                            </script>
                                        </div>
                                    </td>
                                </tr>
                                
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="col-2">
                        <form action="ManageFoodServlet" method="POST">
                            <input type="hidden" name="action" value="goToAddNewFood">
                            <input type="submit" class="btn btn-success btn-block btn-lg mt-2" value="Add New Food">
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <footer>
            <%@include file = "../../components/footer.jsp" %>
        </footer>
    </body>
</html>
