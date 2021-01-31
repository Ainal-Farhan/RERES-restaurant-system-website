<%-- 
    Document   : dashBoard
    Created on : Jan 27, 2021, 7:47:36 AM
    Author     : Zahir
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%  
    final String[] MONTHS = {
        "January",
        "February",
        "March",
        "April",
        "May",
        "Jun",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
    };

    final int START_YEAR = 2021;
    final int NEXT_TOTAL_YEAR = 5;

    Calendar calendar = Calendar.getInstance();

    // Get Current Year
    int currentYear = calendar.get(Calendar.YEAR);

    int totalYear = (currentYear - START_YEAR + 1) + NEXT_TOTAL_YEAR;

    int[] YEARS = new int[totalYear];

    for(int i = 0; i < totalYear; i++) YEARS[i] = START_YEAR + i;

    String selectedYear = (String)request.getAttribute("dateSelectedYear");
    String selectedMonth = (String)request.getAttribute("dateSelectedMonth");
    ArrayList<String> dateDays = (ArrayList<String>)request.getAttribute("dateDays");  

    Double[] bookingPriceMonth = (Double[])request.getAttribute("bookingPricePerMonth");
    ArrayList<Double> bookingPriceDay = (ArrayList<Double>)request.getAttribute("bookingPricePerDay");

    ArrayList<String> years = (ArrayList<String>)request.getAttribute("years");
    ArrayList<Double> totalBookingPricePerYear = (ArrayList<Double>)request.getAttribute("totalBookingPricePerYear");
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard</title>
        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <style><%@include file="../../../css/style/global.css"%></style>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
        
        
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
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
                    <%   if(years.size() > 0) { %>
                        <% for(int i=0; i<years.size()-1; i++){ %>
                         ["<%= years.get(i)%>", <%= totalBookingPricePerYear.get(i)%>] ,           
                        <% } %> 
                        ["<%= years.get(years.size()-1)%>", <%= totalBookingPricePerYear.get(years.size()-1)%>]  
                    <%  } else { %>
                        ["-", 0]
                    <%  } %>
                ]);

                var view = new google.visualization.DataView(data);
                view.setColumns([0,1]);

                var options = {
                    title: "Booking Price per Year",
                    width: 1200,
                    height: 450
                };
                var chart = new google.visualization.ColumnChart(document.getElementById("bar_graph_bookingPriceYear"));
                chart.draw(view, options);
            }
            
            google.charts.setOnLoadCallback(drawBookingPriceMonthbarChart);
            
            function drawBookingPriceMonthbarChart(){
                var data = google.visualization.arrayToDataTable([
                   ["Month","Booking Price (RM)"],
                   <% for(int i=0; i<MONTHS.length-1; i++){ %>
                    ["<%= MONTHS[i] %>", <%= bookingPriceMonth[i] %>] ,           
                   <% } %> 
                   ["<%= MONTHS[MONTHS.length-1] %>", <%= bookingPriceMonth[MONTHS.length-1] %>]                   
                ]);

                var view = new google.visualization.DataView(data);
                view.setColumns([0,1]);

                var options = {
                    title: "Booking Price per Month For Year <%= selectedYear %>",
                    width: 600,
                    height: 300
                };
                var chart = new google.visualization.ColumnChart(document.getElementById("bar_graph_bookingPriceMonth"));
                chart.draw(view, options);
            }
            
            google.charts.setOnLoadCallback(drawBookingPriceDaybarChart);
            
            function drawBookingPriceDaybarChart(){
                var data = google.visualization.arrayToDataTable([
                    ["Day","Booking Price (RM)"],
                    <%   if(dateDays.size() > 0) { %>
                        <% for(int i=0; i<dateDays.size()-1; i++){ %>
                         ["<%= dateDays.get(i)%> - <%= MONTHS[Integer.parseInt(selectedMonth) -1].substring(0,3) %>", <%= bookingPriceDay.get(i)%>] ,           
                        <% } %> 
                        ["<%= dateDays.get(dateDays.size()-1)%> - <%= MONTHS[Integer.parseInt(selectedMonth) -1].substring(0,3) %>", <%= bookingPriceDay.get(dateDays.size()-1)%>]       
                    <%  } else { %>
                        ["-", 0]
                    <%  } %>
                ]);

                var view = new google.visualization.DataView(data);
                view.setColumns([0,1]);

                var options = {
                    title: "Booking Price per Day For Month <%= MONTHS[Integer.parseInt(selectedMonth) -1] %>",
                    width: 600,
                    height: 300
                };
                var chart = new google.visualization.ColumnChart(document.getElementById("bar_graph_bookingPriceDay"));
                chart.draw(view, options);
            }

        </script>
        
        <style>
            .graph-main-container,
            .select-year-month-container,
            .graph-container {
                width: 95%;
                display: block;
                margin-right: auto;
                margin-left: auto;
                padding: 10px 10px 10px 10px;
            }
            
            .graph-main-container {
                
            }
            
            .graph-container {
                
            }
        </style>
        
        <div class="content-container">
            <div class="container-custom bg-light">
                <div class="graph-main-container">                    
                    <div class="graph-container">
                        <table class="table table-striped">
                            <tbody>
                                <tr>
                                    <td colspan="2" style="text-align:center;">
                                        <div class="graph-container" style="width:1200px; margin:0 auto;">
                                            <div id="bar_graph_bookingPriceYear"></div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="text-align:center">
                                        <div class="select-year-month-container">
                                            <form action="DashboardServlet" method="POST">
                                                <div class="form-group row">
                                                    <label for="year" class="col-1 col-form-label">Year</label>
                                                    <div class="col">
                                                        <select id="year" name="selectedYear" class="form-control" >
                                                            <%  for(int i = 0 ; i < totalYear; i++) { %>
                                                                <% if(YEARS[i] == Integer.parseInt(selectedYear)) { %>
                                                                    <option selected><%= YEARS[i] %></option>
                                                                <% } else { %>
                                                                    <option><%= YEARS[i] %></option>
                                                                <% } %>
                                                            <%  } %>
                                                        </select>
                                                    </div>
                                                    <label for="month" class="col-1 col-form-label">Month</label>
                                                    <div class="col">
                                                        <select id="month" name="selectedMonth" class="form-control">
                                                            <%  for(int i = 0 ; i < MONTHS.length; i++) { %>
                                                                <% if((i+1) == Integer.parseInt(selectedMonth)) { %>
                                                                    <option value="<%= i+1 %>" selected><%= MONTHS[i] %></option>
                                                                <% } else { %>
                                                                    <option value="<%= i+1 %>"><%= MONTHS[i] %></option>
                                                                <% } %>
                                                            <% } %>
                                                        </select>
                                                    </div>
                                                    <div class="col-1">
                                                        <input type="hidden" name="action" value="viewBookingMoneyGainedForSelectedYearAndMonth">
                                                        <input type="submit" class="btn btn-primary" value="Go">
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-middle">
                                        <div id="bar_graph_bookingPriceMonth" style="width:600px; margin:0 auto;"></div>
                                    </td>
                                    <td class="align-middle">
                                        <div id="bar_graph_bookingPriceDay" style="width:600px; margin:0 auto;"></div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
