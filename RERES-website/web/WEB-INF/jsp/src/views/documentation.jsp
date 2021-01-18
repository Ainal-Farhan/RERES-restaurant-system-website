<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Documentation Page</title>
        <style>
            <%@include file="../../../css/style/global.css"%>
   
         body{
          background-image:url("${pageContext.servletContext.contextPath}/assets/img/Documentation/hallwways.jpg" );
         
            background-position: center;
            background-repeat: no-repeat;
            background-size:cover;
            position: relative;
         }
         
         .card{
         margin-top:30px;
         padding:auto;
         }
           #search1{
           width:600px;
           margin:auto;
           
           }
       
           #search2{
           width:600px;
           margin:auto;
    
           }
          #button1
          {
            margin:2%; 
            float:left;
            position:relative;
            padding:0.2%;
          }
          
          #button2
          {
            margin:2%; 
            float:left;
            position:relative;
            padding:0.2%; 
            
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
                                <div class="card" style="width:600px">
               <div class="card-header">
                <h1>Documentation</h1>
               </div>
                <br>
                <br>
                <h3 id="search2" >
                    How May We Help You ?
                </h3>
                <br><br>
                <div id="search1">
                    <form>
                    <input type="text" name="search" style="width:500px;" value="Search here...">
  
                </form>
                </div>
                <div id="button1">
                <form action="">
                     <input type="submit" value="search">
                </form>
                </div>
                <div id="button2">
                <form action="FAQ.jsp">
                     <input type="submit" value="more FAQ">
                </form>
                </div>
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
