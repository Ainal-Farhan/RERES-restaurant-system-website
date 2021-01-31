<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment Form Page</title>
        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <style><%@include file="../../../css/style/global.css"%></style>
        <style><%@include file="../../../css/style/payment.css"%></style>
    </head>
    <body>
        <header>
            <%@include file = "../components/navigationBar.jsp" %>
        </header>
        
        <%
            double amountToPay = (Double)request.getAttribute("payAmount");
            String payName = (String)request.getAttribute("payName");
        %>
        
        <div class="content-container">
            <div class="payment-container">
                <form action="PaymentServlet" method="POST">
                    <div class="form-group">
                        <h1>Payment Form</h1>
                    </div>

                    <div class="form-group form-row align-items-center">
                        <div class="col-3">
                            <label for="TotalPayment">Total Payment</label>
                        </div>
                        <div class="col">
                            <label id="TotalPayment"><%= String.format("RM%.2f", amountToPay) %></label>
                            <input type="hidden" name="total-payment" value="<%= amountToPay %>">
                        </div>
                    </div>

                    <hr>

                    <div class="form-group form-check-inline">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="PaymentOptions" id="visa" value="visa" checked>
                            <label class="form-check-label" for="visa"><a href="https://www.freepnglogos.com/images/visa-logo-png-2022.html" title="Image from freepnglogos.com"><img src="https://www.freepnglogos.com/uploads/visa-inc-png-18.png" width="100" alt="visa inc png" /></a></label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="PaymentOptions" id="mastercard" value="mastercard">
                            <label class="form-check-label" for="mastercard"><a href="https://www.freepnglogos.com/images/discover-logo-png-pic-5681.html" title="Image from freepnglogos.com"><img src="https://www.freepnglogos.com/uploads/discover-png-logo/mastercard-discover-logo-png-22.png" width="100" alt="mastercard discover logo png" /></a></label>
                        </div>
                    </div>

                    <div class="form-group form-row align-items-center">
                        <div class="col-3">
                            <label for="NameOnCard">Name</label>
                        </div>
                        <div class="col">
                            <input type="text" class="form-control" name="name-on-card" id="NameOnCard" value="<%= payName %>" required>
                        </div>
                    </div>

                    <div class="form-group form-row align-items-center">
                        <div class="col-3">
                            <label for="CardNumber">Card Number</label>
                        </div>
                        <div class="col">
                            <input type="text" class="form-control" name="card-number" id="CardNumber" maxlength="16" onkeyup="this.value=this.value.replace(/[^\d]/,'')" required>
                        </div>
                    </div>

                    <div class="form-group form-row align-items-center">
                        <div class="col-3">
                            <label for="CardExpiryDateMonth">Expiry Date</label>
                        </div>

                        <div class="form-inline col-6">    
                            <div class="mr-sm-1">
                                <input type="number" min="1" max="12" class="form-control" name="card-expiry-date-month" id="CardExpiryDateMonth" required>
                            </div>
                            <div class="mr-sm-1">
                                <label for="CardExpiryDateYear">/</label>
                            </div>
                            <div class="mr-sm-1">
                                <input type="number" min="20" max="99" class="form-control" name="card-expiry-date-year" id="CardExpiryDateYear" required>
                            </div>
                        </div>

                        <div class="col-1">
                            <label for="CardCVC">CVC</label>
                        </div>
                        <div class="col-2">
                            <input type="number" min="100" max="999" class="form-control" name="card-cvc" id="CardCVC" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <input type="hidden" name="action" value="<%= request.getAttribute("actionPay") %>">
                        <input type="hidden" name="bookingID" value="<%= (Integer)request.getAttribute("ID") %>">
                        <input type="submit" class="btn btn-success btn-group-payment" value="Pay <%= String.format("RM%.2f", amountToPay) %>">
                    </div>
                </form>
                <form action="PaymentServlet" method="POST">
                    <div class="form-group">
                        <input type="hidden" name="action" value="<%= request.getAttribute("actionCancelPay") %>">
                        <input type="hidden" name="bookingID" value="<%= (Integer)request.getAttribute("ID") %>">
                        <input type="submit" class="btn btn-danger btn-group-payment" value="Cancel">
                    </div>
                </form>
            </div>
        </div>
        
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
