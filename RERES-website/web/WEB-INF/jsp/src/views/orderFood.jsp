<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.RERES.model.Food" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Food Page</title>
        <style><%@include file="../../../css/style/global.css"%></style>
        <style><%@include file="../../../css/style/orderFood.css"%></style>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    </head>
    <body>
        <header>
            <%@include file = "../components/navigationBar.jsp" %>
        </header>
        
        <div class="content-container">
            <div class="container-custom bgContent bg-light p-4">
                <div class="row">
                    <div class="col-lg-8 table-food-list">
                        <table class="table table-striped mt-2">
                            <thead class="thead-dark">
                                <tr>
                                    <th>No</th>
                                    <th>Food Name</th>
                                    <th>Food Price</th>
                                    <th>Food Description</th>
                                    <th style="text-align:center;">Food Image</th>
                                    <th style="text-align:center;">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%  if(((ArrayList<Food>)request.getAttribute("foodList")).size() == 0) { %>
                                <tr>
                                    <td colspan="6" style="text-align: center;">There is no menu available</td>
                                </tr>
                                <%  } %>
                            <c:forEach items="${requestScope.foodList}" var="food" varStatus="loop">
                                <tr>
                                    <td class="align-middle"><h5><c:out value="${loop.index + 1}" /></h5></td>
                                    <td class="align-middle"><c:out value="${food.foodName}"/></td>
                                    <td class="align-middle">RM <fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${food.foodPrice}"/></td>
                                    <td class="align-middle"><c:out value="${food.foodDescription}"/></td>
                                    <td class="align-middle"><img id="profilePicture" src='OrderFoodServlet?action=getFoodImage&foodID=<c:out value="${food.foodID}" />' alt="profile picture" class="mx-auto d-block custom-shadow" width="100" height="100" style="border-radius: 50%;"></td>
                                    <td class="align-middle" style="width: 250px; padding-left: 20px">
                                        <form action="OrderFoodServlet" method="POST" class="form-inline">
                                            <input type="hidden" name="foodID" value='<c:out value="${food.foodID}"/>'>
                                            <input type="hidden" name="foodName" value='<c:out value="${food.foodName}"/>'>
                                            <input type="hidden" name="foodPrice" value='<c:out value="${food.foodPrice}"/>'>
                                            <input type="hidden" name="action" value="addFood">
                                            Qty: <input type="number" class="form-control ml-2" name="foodQuantity" min="1" value="1" style="width: 60px;">
                                            <input type="submit" class="btn btn-warning ml-3" value="Add Food">  
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-lg table-your-order-list">
                        <table class="table table-striped mt-2" >
                            <thead class="thead-dark">
                                <tr>
                                    <th colspan="3" style="text-align: center;">Your Order</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%  if(request.getAttribute("foodInCartList") == null || ((ArrayList<Food>)request.getAttribute("foodInCartList")).size() == 0) { %>
                                <tr>
                                    <td colspan="3" style="text-align: center;">You have not select any menu</td>
                                </tr>
                                <%  } %>
                                <c:forEach items="${requestScope.foodInCartList}" var="foodInCart" varStatus="loop">
                                <c:set var="index" value="${requestScope.foodInCartList.indexOf(foodInCart)}"/>
                                <tr>
                                    <td><h5><c:out value="${foodInCart.foodName}"/> x <c:out value="${foodInCart.foodQuantity}"/></h5></td>
                                    <td><h5>RM <fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${foodInCart.foodPrice}"/></h5></td>
                                    <td>
                                        <form action="OrderFoodServlet" method="POST">
                                            <input type="hidden" name="indexOfFood" value='<c:out value="${index}"/>'>
                                            <input type="hidden" name="action" value="deleteFoodInCart">
                                            <button type="submit" class="btn btn-sm btn-danger"><i class="far fa-trash-alt"></i> Delete</button>
                                        </form>
                                    </td>
                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <nav class="navbar navbar-expand-sm bg-light navbar-light fixed-bottom pr-5">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <div aria-labelledby="navbarDropdown" >
                        <form action="OrderFoodServlet" method="POST">
                            <input type="hidden" name="action" value="cancelOrderFood">
                            <input type="submit" class="btn btn-danger btn-lg" value="Cancel Order Food">
                        </form>
                    </div>
                </li>
            </ul>
            <c:if test="${requestScope.isFoodAdded == true}">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <h1>Total Price: RM <fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${requestScope.totalPrice}"/></h1>
                </li>
                <li class="nav-item ml-4">
                    <div aria-labelledby="navbarDropdown" >
                        <form action="OrderFoodServlet" method="POST">
                            <input type="hidden" name="action" value="confirmOrderFood">
                            <input type="submit" class="btn btn-success btn-lg" value="Confirm">
                        </form>
                    </div>
                </li>
            </ul>
            </c:if>
        </nav>
                
        
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
