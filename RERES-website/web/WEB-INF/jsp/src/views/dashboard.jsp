<%-- 
    Document   : dashBoard
    Created on : Jan 27, 2021, 7:47:36 AM
    Author     : Zahir
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%  
    ArrayList <String> dateYear = (ArrayList<String>)request.getAttribute("dateYear");
    ArrayList <String> dateMonth = (ArrayList<String>)request.getAttribute("dateMonth");
    ArrayList <String> dateDay = (ArrayList<String>)request.getAttribute("dateDay");
    ArrayList<Double> bookingPrice = (ArrayList<Double>)request.getAttribute("bookingPrice");

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard</title>
        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <style><%@include file="../../../css/style/global.css"%></style>
        
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    </head>
    <body>
        <%  com.RERES.utility.SessionValidator.checkSession(request, response); %>
        
        <header>
            <%@include file = "../components/navigationBar.jsp" %>
        </header>
        
        <script type="text/javascript">

            // Load Charts and the corechart package.
            google.charts.load('current', {'packages':['corechart']});
            
            google.charts.setOnLoadCallback(drawBookingPriceYearbarChart);
            
            function drawBookingPriceYearbarChart(){
                var data = google.visualization.arrayToDataTable([
                   ["Year","Booking Price (RM)"],
                   <% for(int i=0; i<dateYear.size()-1; i++){ %>
                    ["<%= dateYear.get(i)%>", <%= bookingPrice.get(i)%>] ,           
                   <% } %> 
                   ["<%= dateYear.get(dateYear.size()-1)%>", <%= bookingPrice.get(dateYear.size()-1)%>]                   
                ]);

                var view = new google.visualization.DataView(data);
                view.setColumns([0,1]);

                var options = {
                    title: "Booking Price per Year",
                    width: 450,
                    height: 300
                };
                var chart = new google.visualization.ColumnChart(document.getElementById("bar_graph_bookingPriceYear"));
                chart.draw(view, options);
            }
            
            google.charts.setOnLoadCallback(drawBookingPriceMonthbarChart);
            
            function drawBookingPriceMonthbarChart(){
                var data = google.visualization.arrayToDataTable([
                   ["Month","Booking Price (RM)"],
                   <% for(int i=0; i<dateMonth.size()-1; i++){ %>
                    ["<%= dateMonth.get(i)%>", <%= bookingPrice.get(i)%>] ,           
                   <% } %> 
                   ["<%= dateMonth.get(dateMonth.size()-1)%>", <%= bookingPrice.get(dateMonth.size()-1)%>]                   
                ]);

                var view = new google.visualization.DataView(data);
                view.setColumns([0,1]);

                var options = {
                    title: "Booking Price per Month",
                    width: 450,
                    height: 300
                };
                var chart = new google.visualization.ColumnChart(document.getElementById("bar_graph_bookingPriceMonth"));
                chart.draw(view, options);
            }
            
            google.charts.setOnLoadCallback(drawBookingPriceDaybarChart);
            
            function drawBookingPriceDaybarChart(){
                var data = google.visualization.arrayToDataTable([
                   ["Day","Booking Price (RM)"],
                   <% for(int i=0; i<dateDay.size()-1; i++){ %>
                    ["<%= dateDay.get(i)%>", <%= bookingPrice.get(i)%>] ,           
                   <% } %> 
                   ["<%= dateDay.get(dateDay.size()-1)%>", <%= bookingPrice.get(dateDay.size()-1)%>]                   
                ]);

                var view = new google.visualization.DataView(data);
                view.setColumns([0,1]);

                var options = {
                    title: "Booking Price per Day",
                    width: 450,
                    height: 300
                };
                var chart = new google.visualization.ColumnChart(document.getElementById("bar_graph_bookingPriceDay"));
                chart.draw(view, options);
            }

        </script>
        
        <div class="content-container">
            <div class="container-custom bg-light">
                <div>
                    <form action="DashboardServlet" method="POST">
                        
                    </form>
                </div>
                <div id="bar_graph_bookingPriceYear"></div>
                <div id="bar_graph_bookingPriceMonth"></div>
                <div id="bar_graph_bookingPriceDay"></div>

            </div>
        </div>
        
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
