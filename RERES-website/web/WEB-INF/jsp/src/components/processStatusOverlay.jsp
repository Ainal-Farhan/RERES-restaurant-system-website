<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <% String message = (String)request.getAttribute("processMessage"); %>
        <% String action = (String)request.getAttribute("action"); %>
        <% String servletName = (String)request.getAttribute("servletName"); %>
        
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
                    <%  if(!action.equalsIgnoreCase("none") && !servletName.equalsIgnoreCase("none")) { %>
                    <form action="<%= servletName %>" method="POST">
                        <input type="hidden" name="action" value="<%= action %>">
                        <%  if(request.getAttribute("nameLabels") != null && request.getAttribute("valueLabels") != null) { %>
                            <%
                                String[] nameLabels = (String[])request.getAttribute("nameLabels");
                                String[] valueLabels = (String[])request.getAttribute("valueLabels");

                                for(int i = 0; i < nameLabels.length; i++) {
                                    %><input type="hidden" name="<%= nameLabels[i] %>" value="<%= valueLabels[i] %>"><%
                                }
                            %>
                        <%  } %>
                        <input type="submit" class="btn btn-primary" value="Okay">
                    </form>
                    <%  } else { %>
                    <a class="btn btn-primary" href="${pageContext.servletContext.contextPath}/index.jsp" >Okay</a>
                    <%  } %>
                </div>
            </div>
        </div>
    </body>
</html>
