/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RERES.view;

import com.RERES.path.Path;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ainal farhan
 */
public class View {
    public static void setOverlayStatusMessage(HttpServletRequest request, HttpServletResponse response, String action, String processMessage, String servletName, String[] nameLabels, String[] valueLabels)
            throws ServletException, IOException {
        
        request.setAttribute("action", action);
        request.setAttribute("processMessage", processMessage);
        request.setAttribute("servletName", servletName);
        
        if(nameLabels != null && valueLabels != null) {
            request.setAttribute("nameLabels", nameLabels);
            request.setAttribute("valueLabels", valueLabels);
        }
        
        includePage(request, response, Path.COMPONENT_PROCESS_STATUS_OVERLAY_PATH);
    }
    
    public static void forwardPage(HttpServletRequest request, HttpServletResponse response,String pagePath)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher(pagePath);
        dispatcher.forward(request, response);
    }
    
    public static void includePage(HttpServletRequest request, HttpServletResponse response,String pagePath)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher(pagePath);
        dispatcher.include(request, response);
    }
}
