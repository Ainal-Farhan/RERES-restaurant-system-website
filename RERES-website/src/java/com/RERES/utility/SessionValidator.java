/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RERES.utility;

import com.RERES.view.View;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ainal farhan
 */
public class SessionValidator {
    public static boolean checkSession(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if(request.getSession(false) == null) {
            request.getRequestDispatcher("/index.jsp").include(request, response);
            View.setOverlayStatusMessage(request, response, "none", "Session Time Out", "none", null, null);
            View.includePage(request, response, "/index.jsp");
            
            request.getSession();
            
            return false;
        }
        return true;
    }
}
