<%@page import="com.RERES.references.TopNavigationBarReference"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.RERES.path.Path"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
        
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
    </head>
    <body>
        <style>
            * {
                margin: 0;
                padding: 0;
            }
            i {
                margin-right: 10px;
            }
            /*----------multi-level-accordian-menu------------*/
            .navbar-logo{
                padding: 15px;
                color: #fff;
            }
            .navbar-mainbg{
                background-color: white;
                padding: 0px;
            }
            #navbarSupportedContent{
                overflow: hidden;
                position: relative;
            }
            #navbarSupportedContent ul{
                padding: 0px;
                margin: 0px;
            }
            #navbarSupportedContent ul li a i,
            #navbarSupportedContent ul li form a i{
                margin-right: 10px;
            }
            #navbarSupportedContent li {
                list-style-type: none;
                float: left;
            }
            #navbarSupportedContent ul li form a,
            #navbarSupportedContent ul li a{
                color: black;
                text-decoration: none;
                font-size: 15px;
                display: block;
                padding: 20px 20px;
                transition-duration:0.6s;
                    transition-timing-function: cubic-bezier(0.68, -0.55, 0.265, 1.55);
                position: relative;
            }
            #navbarSupportedContent>ul>li.active>a,
            #navbarSupportedContent>ul>li.active>form>div>a{
                color: white;
                background-color: transparent;
                transition: all 0.7s;
            }
            #navbarSupportedContent a:not(:only-child):after {
                position: absolute;
                right: 20px;
                top: 10px;
                font-size: 14px;
                font-family: "Font Awesome 5 Free";
                display: inline-block;
                padding-right: 3px;
                vertical-align: middle;
                font-weight: 900;
                transition: 0.5s;
            }
            #navbarSupportedContent .active>a:not(:only-child):after {
                transform: rotate(90deg);
            }
            .hori-selector{
                display:inline-block;
                position:absolute;
                height: 100%;
                top: 0px;
                left: 0px;
                transition-duration:0.6s;
                transition-timing-function: cubic-bezier(0.68, -0.55, 0.265, 1.55);
                background-color: black;
                border-top-left-radius: 15px;
                border-top-right-radius: 15px;
                margin-top: 10px;
            }
            .hori-selector .right,
            .hori-selector .left{
                position: absolute;
                width: 25px;
                height: 25px;
                background-color: black;
                bottom: 10px;
            }
            .hori-selector .right{
                right: -25px;
            }
            .hori-selector .left{
                left: -25px;
            }
            .hori-selector .right:before,
            .hori-selector .left:before{
                content: '';
                position: absolute;
                width: 50px;
                height: 50px;
                border-radius: 50%;
                background-color: white;
            }
            .hori-selector .right:before{
                bottom: 0;
                right: -25px;
            }
            .hori-selector .left:before{
                bottom: 0;
                left: -25px;
            }

            @media (max-width: 991px){
                #navbarSupportedContent ul li a{
                    padding: 12px 30px;
                }
                .hori-selector{
                    margin-top: 0px;
                    margin-left: 10px;
                    border-radius: 0;
                    border-top-left-radius: 25px;
                    border-bottom-left-radius: 25px;
                }
                .hori-selector .left,
                .hori-selector .right{
                    right: 10px;
                }
                .hori-selector .left{
                    top: -25px;
                    left: auto;
                }
                .hori-selector .right{
                    bottom: -25px;
                }
                .hori-selector .left:before{
                    left: -25px;
                    top: -25px;
                }
                .hori-selector .right:before{
                    bottom: -25px;
                    left: -25px;
                }
            }
            
            .nav-item-custom:hover {
                cursor: pointer;
                box-shadow: 
                    rgba(50, 50, 93, 0.25) 0px 50px 100px -20px, 
                    rgba(0, 0, 0, 0.3) 0px 30px 60px -30px, 
                    rgba(10, 37, 64, 0.35) 0px -2px 6px 0px inset;
                border-radius: 20px;
            }
        </style>
        
        <script>
            // ---------Responsive-navbar-active-animation-----------
            function test(){
                var tabsNewAnim = $('#navbarSupportedContent');
                var selectorNewAnim = $('#navbarSupportedContent').find('li').length;
                var activeItemNewAnim = tabsNewAnim.find('.active');
                var activeWidthNewAnimHeight = activeItemNewAnim.innerHeight();
                var activeWidthNewAnimWidth = activeItemNewAnim.innerWidth();
                var itemPosNewAnimTop = activeItemNewAnim.position();
                var itemPosNewAnimLeft = activeItemNewAnim.position();
                $(".hori-selector").css({
                    "top":itemPosNewAnimTop.top + "px", 
                    "left":itemPosNewAnimLeft.left + "px",
                    "height": activeWidthNewAnimHeight + "px",
                    "width": activeWidthNewAnimWidth + "px"
                });
                $("#navbarSupportedContent").on("click","li",function(e){
                    $('#navbarSupportedContent ul li').removeClass("active");
                    $(this).addClass('active');
                    var activeWidthNewAnimHeight = $(this).innerHeight();
                    var activeWidthNewAnimWidth = $(this).innerWidth();
                    var itemPosNewAnimTop = $(this).position();
                    var itemPosNewAnimLeft = $(this).position();
                    $(".hori-selector").css({
                      "top":itemPosNewAnimTop.top + "px", 
                      "left":itemPosNewAnimLeft.left + "px",
                      "height": activeWidthNewAnimHeight + "px",
                      "width": activeWidthNewAnimWidth + "px"
                    });
                });
            }
            $(document).ready(function(){
                setTimeout(function(){ test(); });
            });
            $(window).on('resize', function(){
                setTimeout(function(){ test(); }, 500);
            });
            $(".navbar-toggler").click(function(){
                setTimeout(function(){ test(); });
            });
        </script>
        
        <%
            String homeActive = "nav-item-custom";
            String loginActive = "nav-item-custom";
            String registerActive = "nav-item-custom";
            
            if(request.getAttribute(TopNavigationBarReference.SELECTED_PAGE) != null) {
                String selectedPage = (String)request.getAttribute(TopNavigationBarReference.SELECTED_PAGE);
                
                if(selectedPage.equals(TopNavigationBarReference.LOGIN_PAGE)) loginActive = "active";
                else if(selectedPage.equals(TopNavigationBarReference.REGISTRATION_PAGE)) registerActive = "active";
                else if(selectedPage.equals(TopNavigationBarReference.HOME_PAGE)) homeActive = "active";
            }
        %>
        
        <nav class="navbar navbar-expand-lg navbar-mainbg">
            <img class="navbar-logo" src="${pageContext.servletContext.contextPath}<% out.println(Path.RERES_LOGO_PATH); %>/RERES-logo.png" width="150" alt="RERES-logo"/>
            
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <i class="fas fa-bars text-white"></i>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ml-auto">
                    
                    <div class="hori-selector"><div class="left"></div><div class="right"></div></div>
                    
                    <li class="nav-item <%= homeActive %>">
                        <a class="nav-link" href="${pageContext.servletContext.contextPath}/index.jsp"><i class="fas fa-home"></i>HOME</a>
                    </li>
                    <li class="nav-item <%= loginActive %>">
                        <form action="LoginServlet" method="POST" name="login">
                            <div onClick="document.forms['login'].submit();">
                            <input type="hidden" name="action" value="redirectLogin">
                                <a class="nav-link" href="javascript:void(0);"><i class="fas fa-sign-in-alt"></i>LOGIN</a>
                            </div>
                        </form>
                    </li>
                    <li class="nav-item <%= registerActive %>">
                        <form action="RegistrationServlet" method="POST" name="register">
                            <div onClick="document.forms['register'].submit();">
                            <input type="hidden" name="action" value="redirectRegister">
                                <a class="nav-link" href="javascript:void(0);"><i class="fas fa-sign-out-alt"></i>REGISTER</a>
                            </div>
                        </form>
                    </li>
                </ul>
            </div>
                
        </nav>
    </body>
</html>
