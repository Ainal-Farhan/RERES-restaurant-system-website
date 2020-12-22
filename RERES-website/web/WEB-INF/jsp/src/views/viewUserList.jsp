<%@page import="com.RERES.middleware.Customer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.RERES.middleware.Staff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View user List Page</title>
        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <style><%@include file="../../../css/style/global.css"%></style>
        <style><%@include file="../../../css/style/userList.css"%></style>
    </head>
    <body>
        <header>
            <%@include file = "../components/navigationBar.jsp" %>
        </header>
        
        <content>
            <div class="content-container">                
                <div class="container-custom">
            <% 
                final String USER_ADMIN = "admin";
                final String USER_STAFF = "staff";
                final String USER_CUSTOMER = "customer";

                String currentUserType = (String)request.getAttribute("currentUserType");
                String[] labels = (String[])request.getAttribute("labels");

                if(currentUserType.equalsIgnoreCase(USER_ADMIN)) {
                    out.println("<div class='button-view-by-admin'>");
                        out.println("<button class='btn btn-primary' id='btn-customer' onClick='changeViewList()'>");
                            out.println("Customer");
                        out.println("</button>");
                        out.println("<button class='btn btn-primary' id='btn-staff' onClick='changeViewList()'>");
                            out.println("Staff");
                        out.println("</button>");
                    out.println("</div");
                }

                if(currentUserType.equalsIgnoreCase(USER_ADMIN) || currentUserType.equalsIgnoreCase(USER_STAFF)) {
                    ArrayList<Staff> staff = (ArrayList<Staff>)request.getAttribute("staff");
                    
                    out.println("<div class='table-responsive'  id='staff-list'>");
                        out.println("<table class='table table-hover table-view-list'>");
                            out.println("<thead>");
                                out.println("<tr>");
                                    out.print("<th colspan='" + labels.length + "'><h1>" + USER_STAFF.toUpperCase() + "<h1></th>");
                                out.println("</tr>");
                                out.println("<tr>");
                                    for(int i = 0; i < labels.length; i++) {
                                        out.println("<th scope='col'>" + labels[i] + "</th>");
                                    }
                                out.println("</tr>");
                            out.println("</thead>");
                            out.println("<tbody>");
                                if(staff.isEmpty()) {
                                    out.println("<th scope='col' colspan='" + labels.length + "'> There is no data available</th>");
                                }
                                else {
                                    for(int i = 0; i < staff.size(); i++) {
                                        out.println("<th scope='row'>" + (i+1) + "</th>");
                                        out.println("<td>" + staff.get(i).getUsername() + "</td>");
                                        out.println("<td>" + staff.get(i).getPassword() + "</td>");
                                        out.println("<td>" + staff.get(i).getUserType() + "</td>");
                                        out.println("<td>" + staff.get(i).getStaffID() + "</td>");
                                        out.println("<td>" + staff.get(i).getName() + "</td>");
                                        out.println("<td>" + staff.get(i).getBirthDate() + "</td>");
                                        out.println("<td>" + staff.get(i).getAge() + "</td>");
                                        out.println("<td>" + staff.get(i).getEmail() + "</td>");
                                        out.println("<td>" + staff.get(i).getAddress() + "</td>");
                                        out.println("<td>" + staff.get(i).getGender() + "</td>"); 
                                    %>
                                        <td><img src='${pageContext.servletContext.contextPath}<% out.print(Path.PROFILE_PICTURE_STAFF_PATH + "/" + staff.get(i).getProfilePicturePath()); %>' width='30' height='30' /></td>
                                <%    }
                                }
                            out.println("</tbody>");
                        out.println("</table>");
                    out.println("</div>");
                }

                if(currentUserType.equalsIgnoreCase(USER_ADMIN) || currentUserType.equalsIgnoreCase(USER_CUSTOMER)) {
                    ArrayList<Customer> customers = (ArrayList<Customer>)request.getAttribute("customers");

                    out.println("<div class='table-responsive' id='customer-list' >");
                        out.println("<table class='table table-hover table-view-list'>");
                            out.println("<thead>");
                                out.println("<tr>");
                                    out.print("<th colspan='" + labels.length + "'><h1>" + USER_CUSTOMER.toUpperCase() + "<h1></th>");
                                out.println("</tr>");
                                out.println("<tr>");
                                    for(int i = 0; i < labels.length; i++) {
                                        out.println("<th scope='col'>" + labels[i] + "</th>");
                                    }
                                out.println("</tr>");
                            out.println("</thead>");
                            out.println("<tbody>");
                                if(customers.isEmpty()) {
                                    out.println("<th scope='col' colspan='" + labels.length + "'> There is no data available</th>");
                                }
                                else {
                                    for(int i = 0; i < customers.size(); i++) {
                                        out.println("<th scope='row'>" + (i+1) + "</th>");
                                        out.println("<td>" + customers.get(i).getUsername() + "</td>");
                                        out.println("<td>" + customers.get(i).getPassword() + "</td>");
                                        out.println("<td>" + customers.get(i).getUserType() + "</td>");
                                        out.println("<td>" + customers.get(i).getCustomerID() + "</td>");
                                        out.println("<td>" + customers.get(i).getName() + "</td>");
                                        out.println("<td>" + customers.get(i).getBirthDate() + "</td>");
                                        out.println("<td>" + customers.get(i).getAge() + "</td>");
                                        out.println("<td>" + customers.get(i).getEmail() + "</td>");
                                        out.println("<td>" + customers.get(i).getAddress() + "</td>");
                                        out.println("<td>" + customers.get(i).getGender() + "</td>"); 
                                    %>
                                        <td><img src='${pageContext.servletContext.contextPath}<% out.print(Path.PROFILE_PICTURE_CUSTOMER_PATH + "/" + customers.get(i).getProfilePicturePath()); %>' width='30' height='30' /></td>
                                <%    }
                                }
                            out.println("</tbody>");
                        out.println("</table>");
                    out.println("</div>");
                }
            %>
                </div>
            </div>
        </content>
        
        <%  if(currentUserType.equalsIgnoreCase(USER_ADMIN)) { %>
        <script>
            var viewCustomer = true;
            var viewStaff = false;

            changeView();

            function changeViewList() {
                viewCustomer = !viewCustomer;
                viewStaff = !viewStaff;
            }

            function changeView() {
                if(viewCustomer) {
                    document.getElementById('customer-list').style.display = "block";
                    document.getElementById('staff-list').style.display = "none";
                    document.getElementById('btn-customer').disabled = viewCustomer;
                    document.getElementById('btn-staff').disabled = viewStaff;
                }

                if(viewStaff) {
                    document.getElementById('customer-list').style.display = "none";
                    document.getElementById('staff-list').style.display = "block";
                    document.getElementById('btn-customer').disabled = viewCustomer;
                    document.getElementById('btn-staff').disabled = viewStaff;
                }
            }

        </script>
        <%    } %>
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
