<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Navigation Bar</title>
        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <style><%@include file="../../../css/style/navigationBar.css"%></style>
    </head>
    <body>
        <nav class="navbar navbar-expand-md navbar-dark bg-dark">
            <div class="navbar-collapse collapse w-100 order-1 order-md-0 dual-collapse2">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#"><img src="${pageContext.servletContext.contextPath}/assets/img/RERES/RERES-logo.PNG" width="78" height="36" alt="RERES-logo"/></a>
                    </li>
                    <li class="nav-item">
                        <button class="btn btn-primary navigate-button-custom">
                            <a class="nav-link" href="${pageContext.servletContext.contextPath}/ManageBookingServlet">Manage Booking</a>
                        </button>
                    </li>
                    <li class="nav-item">
                        <button class="btn btn-primary navigate-button-custom">
                            <a class="nav-link" href="${pageContext.servletContext.contextPath}/ManageUserServlet">Manage User</a>
                        </button>
                    </li>
                    <li class="nav-item">
                        <button class="btn btn-primary navigate-button-custom">
                            <a class="nav-link" href="${pageContext.servletContext.contextPath}/PaymentServlet">Payment</a>
                        </button>
                    </li>
                    <li class="nav-item">
                        <button class="btn btn-primary navigate-button-custom">
                            <a class="nav-link" href="${pageContext.servletContext.contextPath}/UserServlet">User List</a>
                        </button>
                    </li>
                    <li class="nav-item">
                        <button class="btn btn-primary navigate-button-custom">
                            <a class="nav-link" href="${pageContext.servletContext.contextPath}/BookingTableServlet">Booking Table</a>
                        </button>
                    </li>
                    <li class="nav-item">
                        <button class="btn btn-primary navigate-button-custom">
                            <a class="nav-link" href="${pageContext.servletContext.contextPath}/OrderFoodServlet">Order Food</a>
                        </button>
                    </li>
                </ul>
            </div>
            <div class="mx-auto order-0">
                <a class="navbar-brand mx-auto" href="${pageContext.servletContext.contextPath}/index.jsp">RERES</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target=".dual-collapse2">
                    <span class="navbar-toggler-icon"></span>
                </button>
            </div>
            <div class="navbar-collapse collapse w-100 order-3 dual-collapse2">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <button class="btn btn-primary navigate-button-custom">
                            <a class="nav-link" href="${pageContext.servletContext.contextPath}/ProfileServlet">Profile</a>
                        </button>
                    </li>
                    <li class="nav-item">
                        <button class="btn btn-primary navigate-button-custom">
                            <a class="nav-link" href="${pageContext.servletContext.contextPath}/LoginServlet">Login</a>
                        </button>
                    </li>
                    <li class="nav-item">
                        <button class="btn btn-primary navigate-button-custom">
                            <a class="nav-link" href="${pageContext.servletContext.contextPath}/RegistrationServlet">Register</a>
                        </button>
                    </li>
                    <li class="nav-item">
                        <button class="btn btn-primary navigate-button-custom">
                            <a class="nav-link" href="${pageContext.servletContext.contextPath}/DocumentationServlet">Documentation</a>
                        </button>
                    </li>
                    <li class="nav-item">
                        <button class="btn btn-primary navigate-button-custom">
                            <a class="nav-link" href="${pageContext.servletContext.contextPath}/MembershipServlet">Membership</a>
                        </button>
                    </li>
                    <li class="nav-item">
                        <button class="btn btn-primary navigate-button-custom">
                            <a class="nav-link" href="${pageContext.servletContext.contextPath}/HelpChatServlet">Help Chat</a>
                        </button>
                    </li>
                </ul>
            </div>
        </nav>
    </body>
</html>
