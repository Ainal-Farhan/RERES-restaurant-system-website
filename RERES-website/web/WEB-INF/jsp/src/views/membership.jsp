<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Membership Page</title>
        <style>
            <%@include file="../../../css/style/global.css"%>
            body{
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
            .custom-shadow {
                box-shadow: rgba(50, 50, 93, 0.25) 0px 50px 100px -20px, rgba(0, 0, 0, 0.3) 0px 30px 60px -30px, rgba(10, 37, 64, 0.35) 0px -2px 6px 0px inset;
            }

            .container-membership {
                padding: 10px 10px 10px 10px;
            }
        </style>
    </head>
    <body>
        <header>
            <%@include file = "../components/navigationBar.jsp" %>
        </header>
        
        <jsp:useBean id="membership" class="com.RERES.model.Membership" scope="request" />
        <div id="headlines">
            <h1 style="color:red; text-align: center;">Book Now!! When you can get up to 50% of discount after 3 times of booking!!</h1>
            
        </div>
        <div class="content-container">
            <div class="caption">
                <div class="container-sm container-membership">
                    <div class="d-flex justify-content-center mb-3">
                        <div class="card custom-shadow" style="width:800px">
                            <div class="card-header custom-shadow">
                                <h1 style="text-align:center;">Membership Main Menu</h1>
                            </div>
                            <div class="table-responsive custom-shadow">
                                <table class="table table-light table-striped" style="margin-bottom:0;">
                                    <thead class="thead-dark">
                                        <tr><th colspan="3" style="text-align:center;"><img src="https://cdn.shopify.com/s/files/1/0823/6989/articles/welcome_image_grande.png?v=1505830814" width="280" height="200"></th></tr>
                                    </thead>
                                    <tbody>
                                        <tr class="custom-shadow">
                                            <th class="align-middle">Member Name</th>
                                            <th class="align-middle">:</th>
                                            <td class="align-middle"><label class="form-control-plaintext"><jsp:getProperty name="membership" property="memberName"/></label></td>
                                        </tr>
                                        <tr class="custom-shadow">
                                            <th class="align-middle">Member ID</th>
                                            <th class="align-middle">:</th>
                                            <td class="align-middle"><label class="form-control-plaintext"><jsp:getProperty name="membership" property="memberID"/></label></td>
                                        </tr>
                                        <tr class="custom-shadow">
                                            <th class="align-middle">Successfully Present</th>
                                            <th class="align-middle">:</th>
                                            <%  if(membership.getMemberStatus().equalsIgnoreCase("member")) { %>
                                            <td class="align-middle"><label class="form-control-plaintext"><%= membership.getSuccessBookingMade() %><%= membership.getSuccessBookingMade() < 3? " (" + (3 - membership.getSuccessBookingMade()) + " more bookings to get 50% discount)" : " (Get 50% discount on your next booking)" %></label></td>
                                            <%  } else {%>
                                            <td class="align-middle"><label class="form-control-plaintext">(Renew your membership to get 50% discount on your fourth booking)</label></td>
                                            <%  } %>
                                        </tr>
                                        <tr class="custom-shadow">
                                            <th class="align-middle">Status</th>
                                            <th class="align-middle">:</th>
                                            <td class="align-middle"><label class="form-control-plaintext" style="color:<%= membership.getMemberStatus().toUpperCase().equals("MEMBER")? "green" : "red" %>"><%= membership.getMemberStatus().toUpperCase() %></label></td>
                                        </tr>

                                        <%  if(!membership.getMemberStatus().equalsIgnoreCase("member")) { %>
                                        <tr class="custom-shadow">
                                            <td colspan="3" class="align-middle" style="text-align:center;">
                                                <form action="MembershipServlet" method="POST">
                                                    <input type="hidden" name="action" value="RenewMembership">
                                                    <input type="submit" class="btn btn-success" value="Renew Membership">
                                                </form>
                                            </td>
                                        </tr>
                                        <%  } %>
                                    </tbody>
                                </table>
                            </div>
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
