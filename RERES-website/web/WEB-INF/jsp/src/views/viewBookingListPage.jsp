<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.RERES.model.Booking" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List of Booking</title>
        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" crossorigin="anonymous">
        <style><%@include file="../../../css/style/global.css"%></style>
        <style><%@include file="../../../css/style/bookingList.css"%></style>
    </head>
    <body>
        <header>
            <%@include file = "../components/navigationBar.jsp" %>
        </header>
        
        <div class="content-container"> 
            <div class="booking-list-container">
                <div class='table-responsive' id='customer-list'>
                    <table class='table table-hover table-view-list bg-light table-striped' style="border-radius:24px;text-align: center;">
                        <thead class="thead-dark">
                            <tr>
                                <th colspan='<c:out value="<%= (Integer)request.getAttribute("labelsLength") %>" />'><h1>Booking List</h1></th>
                            </tr>
                            <tr>
                                <c:forEach items="${requestScope.labels}" var="label" varStatus="loop">
                                    <th scope='col'><c:out value="${label}" /></th>
                                </c:forEach>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var = "numberOfBooking" scope = "request" value = "${requestScope.bookingList.size()}"/>

                            <c:if test = "${numberOfBooking == 0}">
                                <tr>
                                    <th scope='col' colspan='<c:out value="${fn:length(requestScope.labels)}" />'> There is no data available</th>
                                </tr>
                            </c:if>

                            <c:if test = "${numberOfBooking > 0}">                                            
                                <c:forEach items="${requestScope.bookingList}" var="booking" varStatus="loop">
                                    <tr>
                                        <th scope='row'><c:out value="${loop.index + 1}" /></th>
                                        <td><c:out value="${booking.bookingID}" /></td>
                                        <td><c:out value="${booking.bookingDate}" /></td>
                                        <td><c:out value="${booking.bookingStartTime.toString().substring(0, 5)}H" /></td>
                                        <td><c:out value="${booking.bookingDuration}" /></td>
                                        <td><c:out value="${booking.bookingStatus.toUpperCase()}" /></td>
                                        <td><c:out value="RM${booking.bookingPrice}" /></td>
                                        <td><c:out value="${booking.bookingDateCreated.toString().substring(0, 16)}H" /></td>
                                        <td>
                                            <form action="BookingServlet" method="POST">
                                                <input type="hidden" name="action" value="viewTheSelectedBooking">
                                                <input type="hidden" name="bookingID" value="<c:out value="${booking.bookingID}" />">
                                                <input type="submit" class="btn-custom" value="Go">
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
                                
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
