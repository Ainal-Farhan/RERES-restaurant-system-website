/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RERES.controller;

import com.RERES.database.Database;
import com.RERES.database.SQLStatementList;
import com.RERES.model.User;
import com.RERES.path.Path;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author PC
 */
public class UserServlet extends HttpServlet {

    private final String ACTION_VIEW_USER_LIST = "viewUserList";
    private final String ACTION_VIEW_A_USER = "ViewAUser";
    private final String ACTION_UPDATE_OR_DELETE_A_USER = "updateOrDeleteUser";
    
    private final String USER_TYPE_CUSTOMER = "customer";
    private final String USER_TYPE_STAFF = "staff";
    
    private static ArrayList<User> users;
    private static User user;
    
    final String[] PUBLIC_INFO_LABELS = {
        "No",
        "Name",
        "Age",
        "Email",
        "Profile Picture",
    };

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }
    
    private void setSpecificUserInformation(String userType) throws SQLException {
        try {
            users = new ArrayList<>();
                    
            Connection con = new Database().getCon();
            
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_RETRIEVE_ALL_SPECIFIC_USER_INFORMATION);
            st.setString(1, userType);
            
            Logger.getLogger(Database.class.getName()).log(Level.INFO, "GET All Users information with type : " + userType);
            ResultSet result = st.executeQuery();

            while(result.next()) {
                User user = new User();
                
                user.setUserID(result.getInt("user_id"));
                user.setUsername(result.getString("username"));
                user.setPassword(result.getString("password"));
                user.setUserType(result.getString("user_type"));
                user.setName(result.getString("name"));
                user.setAge(result.getInt("age"));
                user.setBirthDate(result.getDate("birth_date"));
                user.setEmail(result.getString("email"));
                user.setAddress(result.getString("address"));
                user.setGender(result.getString("gender"));
                user.setPhoneNumber(result.getString("phone_number"));
                user.setProfilePhoto(result.getString("profile_photo"));   
                
                users.add(user);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if(isStringIsNullOrEmpty(action)) {
            
        }
        else if(action.equals(ACTION_VIEW_USER_LIST)) {
            processViewUserList(request, response);
        }
        else if(action.equals(ACTION_VIEW_A_USER)) {
            processViewAUser(request, response);
        }
        else if(action.equals(ACTION_UPDATE_OR_DELETE_A_USER)) {
            try {
                processUpdateOrDeleteAUser(request, response);
            } catch (ParseException ex) {
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
    private boolean isStringIsNullOrEmpty(String inputString) {
        if(inputString == null || inputString.equals("")) {
            return true;
        }
        
        return false;
    }
    
    private boolean deleteSelectedUser(int userID) {
        Connection con;
        try {
            con = new Database().getCon();
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_DELETE_A_USER_INFORMATION);
            st.setInt(1, userID);
            
            int result = st.executeUpdate();
            
            if(result > 0) {
                if(users.size() == 1) {
                    users = new ArrayList<>();
                }
                else {
                    for(int i = 0; i < users.size(); i++) {
                        if(users.get(i).getUserID() == userID) {
                            users.remove(i);
                            break;
                        }
                    }
                }
                return true;
            } 
            return false;
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    private boolean updateSelectedUser(User selectedUser) {
        Connection con;
        try {
            con = new Database().getCon();
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_UPDATE_A_USER_INFORMATION);
            
            st.setString(1, selectedUser.getName());
            st.setInt(2, selectedUser.getAge());
            st.setDate(3, selectedUser.getBirthDate());
            st.setString(4, selectedUser.getEmail());
            st.setString(5, selectedUser.getAddress());
            st.setString(6, selectedUser.getGender());
            st.setString(7, selectedUser.getPhoneNumber());
            st.setString(8, selectedUser.getProfilePhoto());
            st.setInt(9, selectedUser.getUserID());
            
            int result = st.executeUpdate();
            
            if(result > 0) {
                if(users.size() == 1) {
                    users = new ArrayList<>();
                }
                else {
                    for(int i = 0; i < users.size(); i++) {
                        if(users.get(i).getUserID() == selectedUser.getUserID()) {
                            users.set(i, selectedUser);
                            user = selectedUser;
                            break;
                        }
                    }
                }
                return true;
            } 
            return false;
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    private void forwardPage(HttpServletRequest request, HttpServletResponse response,String pagePath)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher(pagePath);
        dispatcher.forward(request, response);
    }
    
    private void processUpdateOrDeleteAUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        String delete = request.getParameter("delete-button");
        String save = request.getParameter("save-button");
        
        if(user == null) {
            
        }
        else if(!isStringIsNullOrEmpty(delete) && isStringIsNullOrEmpty(save) && delete.equalsIgnoreCase("delete")) {
            if(deleteSelectedUser(user.getUserID())) {
                goToViewUserList(request, response, user.getUserType());
            }else {
                forwardPage(request, response, Path.USER_SERVLET_VIEW_PATH + "/manageUser.jsp");
            }
        }
        else if(!isStringIsNullOrEmpty(save) && isStringIsNullOrEmpty(delete) && save.equalsIgnoreCase("save")) {
            
            User selectedUser = user;
            
            selectedUser.setName(request.getParameter("name"));
            selectedUser.setAge(Integer.parseInt(request.getParameter("user-age")));
            
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            Date parsed = format.parse(request.getParameter("user-birth-date"));
            java.sql.Date updatedBirthDate = new java.sql.Date(parsed.getTime());
            
            selectedUser.setBirthDate(updatedBirthDate);
            
            selectedUser.setGender(request.getParameter("gender"));
            selectedUser.setEmail(request.getParameter("user-email"));
            selectedUser.setPhoneNumber(request.getParameter("user-phone-no"));
            selectedUser.setAddress(request.getParameter("user-address"));
            
            if(updateSelectedUser(selectedUser)) {
                goToManageAUserHttpServletRequest(request, response, selectedUser);
            }
        }
        else {
            PrintWriter out = response.getWriter();
            out.println(delete);
        }
    }
    
    private void processViewAUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userType = request.getParameter("userType");
        int userID = Integer.parseInt(request.getParameter("userID"));
        
        if(isStringIsNullOrEmpty(userType) || isStringIsNullOrEmpty(Integer.toString(userID))) {
            
        }
        else {
            if(!users.isEmpty() && users != null) {
                if(userType.equalsIgnoreCase(users.get(0).getUserType())) {
                    User selectedUser = new User();
                    
                    for(int i = 0; i < users.size(); i++) {
                        if(users.get(i).getUserID() == userID) {
                            selectedUser = users.get(i);
                            break;
                        }
                    }
                    user = selectedUser;
                    goToManageAUserHttpServletRequest(request, response, selectedUser);
                }
            }
        }
    }
    
    private void processViewUserList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String viewUserType = request.getParameter("viewUserType");
            
        if(isStringIsNullOrEmpty(viewUserType)) {

        }
        else if(viewUserType.equals(USER_TYPE_CUSTOMER)) {
            try {
                setSpecificUserInformation(USER_TYPE_CUSTOMER);
                goToViewUserList(request, response, USER_TYPE_CUSTOMER);
            } catch (SQLException ex) {
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        else if(viewUserType.equals(USER_TYPE_STAFF)) {
            try {
                setSpecificUserInformation(USER_TYPE_STAFF);
                goToViewUserList(request, response, USER_TYPE_STAFF);
            } catch (SQLException ex) {
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    
    private void goToViewUserList(HttpServletRequest request, HttpServletResponse response, String userType)
            throws ServletException, IOException {
        
        request.setAttribute("users", users);
        request.setAttribute("labels", this.PUBLIC_INFO_LABELS);
        request.setAttribute("userType", userType.toUpperCase());
        request.setAttribute("labelsLength", this.PUBLIC_INFO_LABELS.length);
        
        forwardPage(request, response, Path.USER_SERVLET_VIEW_PATH + "/viewUserListPage.jsp");
    }
    
    private void goToManageAUserHttpServletRequest(HttpServletRequest request, HttpServletResponse response, User selectedUser)
            throws ServletException, IOException {
        
        request.setAttribute("selectedUser", selectedUser);
        request.setAttribute("selectedUserType", selectedUser.getUserType());
        request.setAttribute("selectedUserProfilePhoto", selectedUser.getProfilePhoto());
        
        forwardPage(request, response, Path.USER_SERVLET_VIEW_PATH + "/manageUser.jsp");
    }
    
}
