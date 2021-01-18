<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
        <title>Booking Table Page</title>
        <style><%@include file="../../../css/style/global.css"%></style>
        <style><%@include file="../../../css/style/bookingTable.css"%></style>
    </head>
    <body>
        <header>
            <%@include file = "../components/navigationBar.jsp" %>
            <%@include file = "../components/otherNavigationBar.jsp" %>
            <%@include file = "../components/bookNavigationBar.jsp" %>
        </header>
        
        <content>
            <div class="content-container bg-light bgContent">
                <div class="row topForm">
                    
                    <div class="col-3">
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                            </div>
                            
                            <input type="date" class="form-control form-control-lg" name="bookDate" required>
                        </div>
                    </div>
                    
                    <div class="col-3">
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="far fa-clock"></i></span>
                            </div>
                            
                            <select class="form-control form-control-lg" placeholder="Time" name="bookTime" id="sel1" required>
                            <option value="1">9 AM - 10AM</option>
                            <option value="2">10 AM - 11AM</option>
                            <option value="3">11 AM - 12PM</option>
                            <option value="4">12 PM - 1 PM</option>
                            <option value="5">1 PM - 2 PM</option>
                            <option value="6">2 PM - 3 PM</option>
                            <option value="7">3 PM - 4 PM</option>
                            <option value="8">4 PM - 5 PM</option>
                            <option value="9">5 PM - 6 PM</option>
                            <option value="10">6 PM - 7 PM</option>
                            <option value="11">7 PM - 8 PM</option>
                            <option value="12">8 PM - 9 PM</option>
                            <option value="14">9 PM - 10 PM</option>
                            <option value="15">10 PM - 11 PM</option>
                        </select>
                        </div>
                    </div>
                    
                    <div class="col-3">
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="far fa-user"></i></span>
                            </div>
                            
                            <select class="form-control form-control-lg" placeholder="Person(s)" name="bookPerson" id="sel1" required>
                            <option value="1">1 person</option>
                            <option value="2">2 persons</option>
                            <option value="3">3 persons</option>
                            <option value="4">4 persons</option>
                            <option value="5">5 persons</option>
                            <option value="6">6 persons</option>
                        </select>
                        </div>
                        
                    </div>
                    <div class="col-3">
                        <button class="btn btn-danger btn-block btn-lg" type="submit">Check Availability</button>
                    </div>
                </div>
<!--                <div class="input-group pt-5 pb-5 pl-5 pr-5 input-group-lg">
                    <input type="date" class="form-control" placeholder="Date">
                    
                    <select class="form-control" id="sel1">
                        <option>1</option>
                        <option>2</option>
                        <option>3</option>
                        <option>4</option>
                    </select>
                    
                    <select class="form-control" id="sel1">
                        <option>1</option>
                        <option>2</option>
                        <option>3</option>
                        <option>4</option>
                    </select>
                    
                    <button class="btn btn-danger" type="submit">Check Availability</button>
                    
                </div>-->
            </div>
        </content>
        
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
