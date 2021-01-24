<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Frequently Asked Question</title>
        <style>
        <%@include file="../../../css/style/global.css"%>
   
            body {
                background-image:url("${pageContext.servletContext.contextPath}/assets/img/Documentation/hallwways.jpg" );

                background-position: center;
                background-repeat: no-repeat;
                background-size:cover;
                position: relative;
             }
         
            .collapsible {
                background-color: #777;
                color: white;
                cursor: pointer;
                padding: 18px;
                width: 100%;
                border: none;
                text-align: left;
                outline: none;
                font-size: 15px;
            }

            .active, .collapsible:hover {
                background-color: #555;
            }

            .content {
                padding: 0 18px;
                display: none;
                overflow: hidden;
                background-color: #f1f1f1;
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
                                    <h1>Frequently Asked Question</h1>
                                </div>
                                <br>
                                <br>
                                <h2>Below you'll find answers to the questions we get asked the most</h2>
                
                 
                                <!-- Collapsible Set: -->
                                <button type="button" class="collapsible">Open Section 1</button>
                                <div class="content">
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                                </div>
                                <button type="button" class="collapsible">Open Section 2</button>
                                <div class="content">
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                                </div>
                                <button type="button" class="collapsible">Open Section 3</button>
                                <div class="content">
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                                </div>
                                    <button type="button" class="collapsible">Open Section 4</button>
                                <div class="content">
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                                </div>
                                <button type="button" class="collapsible">Open Section 5</button>
                                <div class="content">
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                                </div>
                                
                                <script>
                                    var coll = document.getElementsByClassName("collapsible");
                                    var i;

                                    for (i = 0; i < coll.length; i++) {
                                        coll[i].addEventListener("click", function() {
                                            this.classList.toggle("active");
                                            var content = this.nextElementSibling;
                                            if (content.style.display === "block") {
                                                content.style.display = "none";
                                            } else {
                                                content.style.display = "block";
                                            }
                                        });
                                    }
                                </script>
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
