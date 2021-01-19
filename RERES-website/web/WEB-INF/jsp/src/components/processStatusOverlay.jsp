<%-- 
    Document   : processStatusOverlay
    Created on : Jan 19, 2021, 10:44:26 AM
    Author     : ainal farhan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <% String message = (String)request.getAttribute("displayMessage"); %>
        
        <style>
            #overlay {
                position: fixed;
                display: block;
                width: 100%;
                height: 100%;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: rgba(0,0,0,0.5);
                z-index: 2;
            }

            .ovelay-content{
                position: absolute;
                top: 50%;
                left: 50%;
                font-size: 24px;
                background-color: #ccffff;
                box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
                text-align: center;
                border-radius: 24px;
                transform: translate(-50%,-50%);
                -ms-transform: translate(-50%,-50%);
            }
        </style>
    </head>
    
    <body>
        <div id="overlay">
            <div class="ovelay-content">
                <div class="card-body">
                    <p class="card-text"><%= message %></p>
                    <button type="button" class="btn btn-primary" onclick="off()">Okay</button>
                </div>
            </div>
        </div>
        
        <script>
            function off() {
                document.getElementById("overlay").style.display = "none";
            }
        </script>
    </body>
</html>

