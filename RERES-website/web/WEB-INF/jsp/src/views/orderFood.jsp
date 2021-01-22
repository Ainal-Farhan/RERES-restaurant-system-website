<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Food Page</title>
        <style><%@include file="../../../css/style/global.css"%></style>
    </head>
    <body>
        <header>
            <%@include file = "../components/navigationBar.jsp" %>
        </header>s
        
        <content>
            <div class="content-container">
                <h1>Order Food Page</h1>
            </div>
            <form action="OrderFoodServlet" method="POST">
                <input type="hidden" name="action" value="test">
                <input type="submit" value="test">
            </form>
        </content>
        
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
