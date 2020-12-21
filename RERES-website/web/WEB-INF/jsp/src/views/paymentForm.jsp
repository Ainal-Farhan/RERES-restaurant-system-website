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
        
        <content>
            <div class="content-container">
                <div class="container">
                    <form>
                        <div class="form-group">
                            <h1>Payment Form</h1>
                        </div>

                        <div class="form-group form-row align-items-center">
                            <div class="col">
                                <label for="TotalPayment">Total Payment</label>
                            </div>
                            <div class="col">
                                <input type="text" class="form-control" name="total-payment" id="TotalPayment">
                            </div>
                        </div>

                        <hr>

                        <div class="">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="PaymentOptions" id="visa" value="visa">
                                <label class="form-check-label" for="visa"><img src="" alt="VISA"></label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="PaymentOptions" id="mastercard" value="option2">
                                <label class="form-check-label" for="mastercard"><img src="" alt="MASTERCARD"></label>
                            </div>
                        </div>

                        <div class="form-group form-row align-items-center">
                            <div class="col">
                                <label for="NameOnCard">Name</label>
                            </div>
                            <div class="col">
                                <input type="text" class="form-control" name="name-on-card" id="NameOnCard">
                            </div>
                        </div>

                        <div class="form-group form-row align-items-center">
                            <div class="col">
                                <label for="CardNumber">Card Number</label>
                            </div>
                            <div class="col">
                                <input type="text" class="form-control" name="card-number" id="CardNumber">
                            </div>
                        </div>

                        <div class="form-group form-row align-items-center">
                            <div class="col">
                                <label for="CardExpiryDateMonth">Expiry Date</label>
                            </div>

                            <div class="form-inline col">    
                                <div class="mr-sm-2">
                                    <input type="number" min="1" max="12" class="form-control" name="card-expiry-date-month" id="CardExpiryDateMonth">
                                </div>
                                <div class="mr-sm-2">
                                    <label for="CardExpiryDateYear">/</label>
                                </div>
                                <div class="mr-sm-2">
                                    <input type="number" min="20" max="99" class="form-control" name="card-expiry-date-year" id="CardExpiryDateYear">
                                </div>
                            </div>

                            <div class="col">
                                <label for="CardCVC">CVC</label>
                            </div>
                            <div class="col">
                                <input type="number" min="100" max="999" class="form-control" name="card-cvc" id="CardCVC">
                            </div>
                        </div>

                        <div class="form-group">
                            <button class="btn btn-success btn-group-payment">Pay RM190.00</button>
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
