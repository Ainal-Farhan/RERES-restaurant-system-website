<%-- 
    Document   : viewPaidStatus
    Created on : Jan 14, 2021, 3:23:47 PM
    Author     : ainal farhan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Table Page</title>
        <style><%@include file="../../../css/style/global.css"%></style>
        
        <style>
            .paid-status-container {
                width: 95%;
                display: block;
                margin-left: auto;
                margin-right: auto;
                margin-top: 10px;
                margin-bottom: auto;
                border-radius: 24px;
                background-color: white;
                padding: 30px 30px 30px 30px;
                box-shadow: rgba(50, 50, 93, 0.25) 0px 50px 100px -20px, rgba(0, 0, 0, 0.3) 0px 30px 60px -30px, rgba(10, 37, 64, 0.35) 0px -2px 6px 0px inset;
            }
        </style>
    </head>
    <body>
        <header>
            <%@include file = "../components/navigationBar.jsp" %>
        </header>
        
        <%
            String status = (String)request.getAttribute("PayStatus");
            
            if(status == null) {
                out.println("<h1>NULL VALUE DETECTED</h1>");
            }
        %>
        
        <div class="content-container">
            <div class="paid-status-container">
                <table class="table table-light">
                    <thead>
                        <tr>
                            <%  if(status.equalsIgnoreCase("success")) { %>
                            <th style="color:green;text-align: center;"><h1>Successfully paid</h1></th>
                            <%  } %>

                            <%  if(status.equalsIgnoreCase("failed")) { %>
                            <th style="color:green;text-align: center;"><h1>Failed to paid</h1></th>
                            <%  } %>
                        </tr>
                    </thead>
                </table>
            </div>
            
        </div>
        
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>


