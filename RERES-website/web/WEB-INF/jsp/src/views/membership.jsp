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
                margin:auto;
                display:inline-block;
            }
        </style>
    </head>
    <body>
        <header>
            <%@include file = "../components/navigationBar.jsp" %>
        </header>
        
        <div class="content-container">
            <div class="caption">
                <div class="container-sm">
                    <div class="d-flex justify-content-center mb-3">
                        <div class="card" style="width:800px">
                            <div class="card-header">
                                <h1>Membership Main Menu</h1>
                            </div>
                            <table class="table">
                                <thead>
                                    <tr><th colspan="5"><h2>Welcome To The Membership HomePage</h2></th></tr>
                                    <tr><th colspan="5" style="text-align:center;"><img src="${pageContext.servletContext.contextPath}/assets/img/Documentation/member.jpg" width="30%" height="40%"></th></tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th>Member Name</th>
                                        <td><label class="form-control-plaintext"><jsp:getProperty name="membership" property="memberName"/></label></td>
                                    </tr>
                                    <tr>
                                        <th>Member ID</th>
                                        <td><label class="form-control-plaintext"><jsp:getProperty name="membership" property="memberID"/></label></td>
                                    </tr>
                                    <tr>
                                        <th>Success Booking Made</th>
                                        <td><label class="form-control-plaintext"><jsp:getProperty name="membership" property="successBookingMade"/></label></td>
                                    </tr>
                                    <tr>
                                        <th>Status</th>
                                        <td><label class="form-control-plaintext"><jsp:getProperty name="membership" property="memberStatus"/></label></td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;">
                                            
                                            <form action="MembershipServlet" method="POST">
                                                <input type="hidden" name="action" value="ViewRewards">
                                                <input type="submit" value="View Rewards">
                                            </form>
                                        </td>
                                        <td style="text-align: left;">
                                            <form action="MembershipServlet" method="POST">
                                                <input type="hidden" name="action" value="RenewMembership">
                                                <input type="submit" value="Renew Membership">
                                            </form>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                                    
                    </div>
                </div>
            </div>
        </div>
        
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
