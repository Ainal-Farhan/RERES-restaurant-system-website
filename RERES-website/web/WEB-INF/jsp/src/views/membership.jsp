<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Membership Page</title>
        <style>
            <%@include file="../../../css/style/global.css"%>
         body{
          background-image:url("${pageContext.servletContext.contextPath}/assets/img/Documentation/hallwways.jpg" );
          width:100%;
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;
            position: relative;
         }
        #button1 , #button2 {
        display:inline-block;
            }
        
        
        </style>
    </head>
    <body>
        <header>
            <%@include file = "../components/navigationBar.jsp" %>
        </header>
        
        <content>
            <div class="content-container">
                <div class="caption">
                        <div class="container-sm">
                            <div class="d-flex justify-content-center mb-3">
                                <div class="card" style="width:800px">
               <div class="card-header">
                <h1>Membership Main Menu</h1>
            </div>
                                    <h2>Welcome To The Membership HomePage</h2>
               <br>
               <img src="${pageContext.servletContext.contextPath}/assets/img/Documentation/member.jpg" width="30%" height="40%">
               <br>
                    <button id="button1" >View Rewards</button>
                    <button id="button2" >Renew Your Membership</button>
             
               
               
               
               
               
               
               
               
               
               
               
               
                                </div>
                            </div>
                        </div>
                </div>
            </div>
                        
        </content>
        
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
