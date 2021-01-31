<%-- 
    Document   : dashBoard
    Created on : Jan 27, 2021, 7:47:36 AM
    Author     : Zahir
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            
            google.charts.setOnLoadCallback(drawBookingPriceMonthbarChart);
            
            function drawBookingPriceMonthbarChart(){
                var data = google.visualization.arrayToDataTable([
                   ["Month","Booking Price (RM)"],
                   ["01", 21]
                   <% //coding looping %>
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
            
            
            // Second Graph
            google.charts.setOnLoadCallback(drawBookingPriceYearbarChart);
            
            function drawBookingPriceYearbarChart(){
                var data = google.visualization.arrayToDataTable([
                   ["Year","Booking Price (RM)"],
                   ["2020", 300]
                   <% //coding looping %>
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
        </script>
        
        <div class="content-container">
            <div class="container-custom bg-light">
                <div id="bar_graph_bookingPriceMonth"></div>
                <div id="bar_graph_bookingPriceYear"></div>
            </div>
        </div>
        
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
