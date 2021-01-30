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
import com.RERES.utility.ImageUtility;
import com.RERES.view.View;
import java.io.ByteArrayOutputStream;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Connection;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author PC
 */
public class UserServlet extends HttpServlet {

    private final String ACTION_VIEW_USER_LIST = "viewUserList";
    private final String ACTION_VIEW_A_USER = "ViewAUser";
    private final String ACTION_VIEW_PROFILE = "viewProfile";
    private final String ACTION_UPDATE_OR_DELETE_A_USER = "updateOrDeleteUser";
    private final String ACTION_REGISTER_USER = "registerUser";
    private final String ACTION_LOGIN_USER = "authLogin";
    private final String ACTION_LOGOUT_USER = "logout";
    private final String ACTION_VIEW_HOME_PAGE_AUTHENTICATED = "viewHomePageAuthenticated";
    private final String ACTION_UPDATE_USER_PROFILE_PICTURE = "updateUserProfilePicture";
    
    private final String ACTION_GET_SELECTED_USER_PROFILE_PICTURE = "getSelectedUserProfilePicture";
    
    private final String USER_TYPE_CUSTOMER = "customer";
    private final String USER_TYPE_STAFF = "staff";
    
    private static String errorMessage;
    
    private static ArrayList<User> users;
    private static User user;
    
    final String[] PUBLIC_INFO_LABELS = {
        "No",
        "Name",
        "Age",
        "Email",
        "Profile Picture",
    };
    
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
        if(!com.RERES.utility.SessionValidator.checkSession(request, response)) return;
        
        String action = request.getParameter("action");
                
        if(action == null) {
            
        }
        else if(action.equals(ACTION_GET_SELECTED_USER_PROFILE_PICTURE)) {           
            if(user != null) ImageUtility.displaySelectedImage(response, user.getProfilePhoto());
            else ImageUtility.displaySelectedImage(response, "");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.text.ParseException
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if(!com.RERES.utility.SessionValidator.checkSession(request, response)) return;
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        
        
        if(isStringIsNullOrEmpty(action)) {
            
        }
        else if(action.equals(ACTION_VIEW_HOME_PAGE_AUTHENTICATED)) {
            request.setAttribute("selectedPage", "homePage");
            View.forwardPage(request, response, Path.HOME_VIEW_PATH);
        }
        else if(action.equals(ACTION_VIEW_USER_LIST)) {
            processViewUserList(request, response);
        }
        else if(action.equals(ACTION_VIEW_A_USER)) {
            
            if(request.getParameter("userType").equalsIgnoreCase("staff") && ((String)session.getAttribute("currentUserType")).equalsIgnoreCase("admin")) request.setAttribute("selectedPage", "staffListPage");
            else if(request.getParameter("userType").equalsIgnoreCase("customer") && ((String)session.getAttribute("currentUserType")).equalsIgnoreCase("admin")) request.setAttribute("selectedPage", "customersListPage");
            else request.setAttribute("selectedPage", "profilePage");
                
            processViewAUser(request, response);
        }
        else if(action.equals(ACTION_UPDATE_USER_PROFILE_PICTURE)) {
            if(((String)session.getAttribute("currentUserType")).equalsIgnoreCase("admin") && user.getUserType().equalsIgnoreCase("staff")) request.setAttribute("selectedPage", "staffListPage");
            else if(((String)session.getAttribute("currentUserType")).equalsIgnoreCase("admin") && user.getUserType().equalsIgnoreCase("customer")) request.setAttribute("selectedPage", "customersListPage");
            else request.setAttribute("selectedPage", "profilePage");
            
            String uploadButton = request.getParameter("upload-btn");
            String defaultButton = request.getParameter("default-btn");
            
            byte[] translatedImage = null;
            String fileName = "";
            String uploadedImage = ImageUtility.USER_DEFAULT_PROFILE_PICTURE;
                            
            if(uploadButton != null) {
                uploadedImage = request.getParameter("uploadedBase64Image");
                translatedImage = ImageUtility.translateBase64ImageToBytes(uploadedImage);
                fileName = request.getParameter("uploadedFileName");
            }
            else if(defaultButton != null) {
                translatedImage = ImageUtility.translateBase64ImageToBytes(ImageUtility.USER_DEFAULT_PROFILE_PICTURE);
                fileName = "default picture";
            }
            
            String message;
            
            if(uploadButton != null || defaultButton != null) {
                
                if(updateSelectedUserProfilePictureIntoDatabase(translatedImage, uploadedImage)) {
                    message = "Successfully update the profile picture with " + fileName;
                }
                else {
                    message = "Failed to update the profile picture with " + fileName;
                }
            }
            else {
                message = "Bugs happened during updating profile picture";
            }
            
            String[] nameLabels = {"userType", "userID"};
            String[] valueLabels = {user.getUserType(), Integer.toString(user.getUserID())};

            View.setOverlayStatusMessage(request, response, ACTION_VIEW_A_USER, message, "UserServlet", nameLabels, valueLabels);

            setAttributesForManageAUser(request, response, user);
            
            View.includePage(request, response, Path.USER_SERVLET_VIEW_PATH + "/manageUser.jsp");
        }
        else if(action.equals(ACTION_VIEW_PROFILE)) {
            String currentUserType = (String)session.getAttribute("currentUserType");
            
            if(currentUserType.equalsIgnoreCase("admin") && request.getParameter("userType").equalsIgnoreCase("staff")) request.setAttribute("selectedPage", "staffListPage");
            else if(currentUserType.equalsIgnoreCase("admin") && request.getParameter("userType").equalsIgnoreCase("customer")) request.setAttribute("selectedPage", "customersListPage");
            else request.setAttribute("selectedPage", "profilePage");
            
            processViewProfile(request, response);
        }
        else if(action.equals(ACTION_UPDATE_OR_DELETE_A_USER)) {
            
            String currentUserType = (String)session.getAttribute("currentUserType");
            if(currentUserType.equalsIgnoreCase("admin") && user.getUserType().equalsIgnoreCase("staff")) request.setAttribute("selectedPage", "staffListPage");
            else if(currentUserType.equalsIgnoreCase("admin") && user.getUserType().equalsIgnoreCase("customer")) request.setAttribute("selectedPage", "customersListPage");
            else request.setAttribute("selectedPage", "profilePage");
            
            try {
                processUpdateOrDeleteAUser(request, response);
            } catch (ParseException ex) {
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        else if(action.equals(ACTION_REGISTER_USER)){
            try {
                processRegisterUser(request, response);
            } catch (ParseException ex) {
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        else if(action.equals(ACTION_LOGIN_USER)){
            try {
                processLoginUser(request, response);
            } catch (ParseException ex) {
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        else if(action.equals(ACTION_LOGOUT_USER)) {
            session.invalidate();
            request.setAttribute("selectedPage", "homePage");
            View.forwardPage(request, response, Path.HOME_VIEW_PATH);
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
    
    protected void processLoginUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        if(authenticateUser(request)) {
            request.setAttribute("selectedPage", "homePage");
            
            View.setOverlayStatusMessage(request, response, ACTION_VIEW_HOME_PAGE_AUTHENTICATED, "Successfully Login", "UserServlet", null, null);
            View.includePage(request, response, Path.HOME_VIEW_PATH);
        }
        else {
            request.setAttribute("selectedPage", "loginPage");
            View.setOverlayStatusMessage(request, response, "redirectLogin", "Invalid username, email or password", "LoginServlet", null, null);
            View.includePage(request, response, Path.LOGIN_VIEW_PATH);
        }
    }
    
    private void processRegisterUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        
        if(checkUserInput(request)) {
            if(setUserRegistrationIntoDatabase(request)) {

                request.setAttribute("selectedPage", "loginPage");
                View.setOverlayStatusMessage(request, response, "redirectLogin", "Successfully register a new customer. Now, please login with your login credential", "LoginServlet", null, null);
                View.includePage(request, response, Path.LOGIN_VIEW_PATH);
            }
            else {
                request.setAttribute("selectedPage", "registerPage");
                View.setOverlayStatusMessage(request, response, "redirectRegister", "Failed to register a new customer", "RegistrationServlet", null, null);
                View.includePage(request, response, Path.REGISTRATION_VIEW_PATH);
            }
        }
        else {
            request.setAttribute("selectedPage", "registerPage");
            View.setOverlayStatusMessage(request, response, "redirectRegister", errorMessage, "RegistrationServlet", null, null);
            View.includePage(request, response, Path.REGISTRATION_VIEW_PATH);
        }
    }
    
    private boolean authenticateUser(HttpServletRequest request)
            throws ServletException, IOException {
        try {
           String usernameOrEmail = request.getParameter("usernameOrEmail");
           String password = request.getParameter("pwd");
           
           Connection con = new Database().getCon();
           PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_RETRIEVE_USER_AUTHENTICATE);
           
           st.setString(1, password);
           st.setString(2, usernameOrEmail);
           st.setString(3, usernameOrEmail);
           
           ResultSet rs = st.executeQuery();
           
           while(rs.next()){
               HttpSession session = request.getSession();
               session.setAttribute("currentUserType", rs.getString("user_type"));
               session.setAttribute("currentUserID", rs.getInt("user_id"));
               session.setAttribute("isAuthenticated", true);
               return true;
           }
           
        } catch (SQLException | ClassNotFoundException  ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    private Blob getDefaultImageInBlob(Connection con) 
            throws ServletException, IOException, ClassNotFoundException {
            Blob imageBlob = null;

            try {
                byte[] fileContent;
                fileContent = java.util.Base64.getDecoder().decode(ImageUtility.USER_DEFAULT_PROFILE_PICTURE);
                imageBlob = con.createBlob();
                imageBlob.setBytes(1, fileContent);
            } 
            catch(SQLException ex) {
                Logger.getLogger(UserServlet.class.getName()).log(Level.INFO, ex.getMessage());
            }

            return imageBlob;
        }
    
    private boolean setUserRegistrationIntoDatabase(HttpServletRequest request)
            throws ServletException, IOException {
        
        try {
            String fullname = request.getParameter("fullname");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String poscode = request.getParameter("poscode");
            String state = request.getParameter("state");
            String fullAddress = address + ", " + city + ", " + poscode + " " + state;
            String phoneNumber = request.getParameter("phoneNumber");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String password = request.getParameter("pwd");
            String confirmPassword = request.getParameter("confirmPwd");
            String userType = request.getParameter("userType");
            String gender = request.getParameter("gender");
            String date = request.getParameter("birthdate");
            int age = Integer.parseInt(request.getParameter("age"));
            DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date myDate = formatter.parse(date);
            java.sql.Date sqlDate = new java.sql.Date(myDate.getTime());
            
            Connection con = new Database().getCon();
            
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_INSERT_REGISTER_USER);

            st.setString(1, username);
            st.setString(2, password);
            st.setString(3, userType);
            st.setString(4, fullname);
            st.setInt(5, age);
            st.setDate(6, sqlDate);
            st.setString(7, email);
            st.setString(8, fullAddress);
            st.setString(9, gender);
            st.setString(10, phoneNumber);
            st.setBlob(11, getDefaultImageInBlob(con));

            int count = st.executeUpdate();

            System.out.println(fullname + address + city + poscode + state + phoneNumber + email + username + password + confirmPassword + userType + age + sqlDate + gender + st.toString());

            if(count > 0)
            {
                return true;
            }
            
            st.close();
            
        } catch (SQLException | ClassNotFoundException | ParseException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return false;
    }
    
    private boolean updateSelectedUserProfilePictureIntoDatabase(byte[] imageBytes, String base64Image) {
        try {
            Connection connection = new Database().getCon();
            
            Blob imageBlob = connection.createBlob();
            imageBlob.setBytes(1, imageBytes);

            PreparedStatement statement = connection.prepareStatement(SQLStatementList.SQL_STATEMENT_UPDATE_USER_PROFILE_PICTURE);

            statement.setBlob(1, imageBlob);
            statement.setInt(2, user.getUserID());

            if(statement.executeUpdate() > 0) {
                user.setProfilePhoto(base64Image);
                
                if(users != null && !users.isEmpty()) {
                    for(int i = 0; i < users.size(); i++) {
                        if(users.get(i).getUserID() == user.getUserID()) {
                            users.set(i, user);
                            break;
                        }
                    }
                }
                connection = null;
                return true;
            }
            connection = null;
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return false;
    }
    
    private void setAllUsersInformationWithSelectedType(String userType) throws SQLException, IOException {
        try {
            users = new ArrayList<>();
                    
            Connection con = new Database().getCon();
            
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_RETRIEVE_ALL_SPECIFIC_USER_INFORMATION);
            st.setString(1, userType);
            
            System.out.println("GET All Users information with type : " + userType);
            ResultSet result = st.executeQuery();

            while(result.next()) {
                User tempUser = new User();
                
                tempUser.setUserID(result.getInt("user_id"));
                tempUser.setUsername(result.getString("username"));
                tempUser.setPassword(result.getString("password"));
                tempUser.setUserType(result.getString("user_type"));
                tempUser.setName(result.getString("name"));
                tempUser.setAge(result.getInt("age"));
                tempUser.setBirthDate(result.getDate("birth_date"));
                tempUser.setEmail(result.getString("email"));
                tempUser.setAddress(result.getString("address"));
                tempUser.setGender(result.getString("gender"));
                tempUser.setPhoneNumber(result.getString("phone_number"));
                
                Blob blob = result.getBlob("profile_photo");
                 
                ByteArrayOutputStream outputStream;
                String base64Image;
                try (InputStream inputStream = blob.getBinaryStream()) {
                    outputStream = new ByteArrayOutputStream();
                    byte[] buffer = new byte[4096];
                    int bytesRead = -1;
                    while ((bytesRead = inputStream.read(buffer)) != -1) {                  
                        outputStream.write(buffer, 0, bytesRead);
                    }   byte[] imageBytes = outputStream.toByteArray();
                    base64Image = Base64.getEncoder().encodeToString(imageBytes);
                }
                outputStream.close();
                
                tempUser.setProfilePhoto(base64Image);   
                
                users.add(tempUser);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private boolean isStringIsNullOrEmpty(String inputString) {
        return inputString == null || inputString.equals("");
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
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
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
                
                user = selectedUser;
                
                if(users != null && !users.isEmpty() && users.get(0).getUserType().equals(user.getUserType())) {
                    for(int i = 0; i < users.size(); i++) {
                        if(users.get(i).getUserID() == selectedUser.getUserID()) {
                            users.set(i, selectedUser);
                            break;
                        }
                    }
                }
                
                return true;
            } 
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    private void processUpdateOrDeleteAUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        String delete = request.getParameter("delete-button");
        String save = request.getParameter("save-button");
        
        if(user == null) {
            
        }
        else if(!isStringIsNullOrEmpty(delete) && isStringIsNullOrEmpty(save) && delete.equalsIgnoreCase("delete")) {
            if(deleteSelectedUser(user.getUserID())) {
                String[] nameLabels = {"viewUserType"};
                String[] valueLabels = {user.getUserType()};
                
                View.setOverlayStatusMessage(request, response, ACTION_VIEW_USER_LIST, "Successfully Deleting the User Information", "UserServlet", nameLabels, valueLabels);
                setAttributesForViewUserList(request, response, user.getUserType());
                View.includePage(request, response, Path.USER_SERVLET_VIEW_PATH + "/viewUserListPage.jsp");
            }else {
                String[] nameLabels = {"userType", "userID"};
                String[] valueLabels = {user.getUserType(), Integer.toString(user.getUserID())};
                
                View.setOverlayStatusMessage(request, response, ACTION_VIEW_A_USER, "Failed Deleting the User Information", "UserServlet", nameLabels, valueLabels);
                setAttributesForManageAUser(request, response, user);
                View.includePage(request, response, Path.USER_SERVLET_VIEW_PATH + "/manageUser.jsp");
            }
        }
        else if(!isStringIsNullOrEmpty(save) && isStringIsNullOrEmpty(delete) && save.equalsIgnoreCase("save")) {
            
            User selectedUser = user;
            
            selectedUser.setName(request.getParameter("name"));
            selectedUser.setAge(Integer.parseInt(request.getParameter("user-age")));
            selectedUser.setEmail(request.getParameter("user-email"));
            selectedUser.setPhoneNumber(request.getParameter("user-phone-no"));
            selectedUser.setAddress(request.getParameter("user-address"));
            
            String[] nameLabels = {"userType", "userID"};
            String[] valueLabels = {selectedUser.getUserType(), Integer.toString(selectedUser.getUserID())};
            
            if(updateSelectedUser(selectedUser)) {
                View.setOverlayStatusMessage(request, response, ACTION_VIEW_A_USER, "Successfully Updating the User Information", "UserServlet", nameLabels, valueLabels);
                setAttributesForManageAUser(request, response, selectedUser);
                View.includePage(request, response, Path.USER_SERVLET_VIEW_PATH + "/manageUser.jsp");
            } 
            else {
                View.setOverlayStatusMessage(request, response, ACTION_VIEW_A_USER, "Failed Updating the User Information", "UserServlet", nameLabels, valueLabels);
                setAttributesForManageAUser(request, response, selectedUser);
                View.includePage(request, response, Path.USER_SERVLET_VIEW_PATH + "/manageUser.jsp");
            }
        }
        else {
            PrintWriter out = response.getWriter();
            out.println(delete);
        }
    }
    
    private boolean setCurrentUser(String userType, int userID) throws IOException {
        Connection con;
        try {
            con = new Database().getCon();
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_RETRIEVE_A_USER_INFORMATION);
            
            st.setString(1, userType);
            st.setInt(2, userID);
            
            ResultSet result = st.executeQuery();
            
            if(user == null) 
                user = new User();
            
            if(result.next()) {                
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
                
                Blob blob = result.getBlob("profile_photo");
                 
                ByteArrayOutputStream outputStream;
                String base64Image;
                try (InputStream inputStream = blob.getBinaryStream()) {
                    outputStream = new ByteArrayOutputStream();
                    byte[] buffer = new byte[4096];
                    int bytesRead = -1;
                    while ((bytesRead = inputStream.read(buffer)) != -1) {                  
                        outputStream.write(buffer, 0, bytesRead);
                    }   byte[] imageBytes = outputStream.toByteArray();
                    base64Image = Base64.getEncoder().encodeToString(imageBytes);
                }
                outputStream.close();
                
                user.setProfilePhoto(base64Image); 
                
                return true;
            } 
            return false;
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    private void processViewAUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userType = request.getParameter("userType");
        int userID = Integer.parseInt(request.getParameter("userID"));
        
        if(isStringIsNullOrEmpty(userType) || isStringIsNullOrEmpty(Integer.toString(userID))) {
            
        }
        else {
            if(users != null && !users.isEmpty()) {
                if(userType.equalsIgnoreCase(users.get(0).getUserType())) {
                    User selectedUser = new User();
                    
                    for(int i = 0; i < users.size(); i++) {
                        if(users.get(i).getUserID() == userID) {
                            selectedUser = users.get(i);
                            break;
                        }
                    }
                    user = selectedUser;
                }
            }
            else {
                setCurrentUser(userType, userID);
            }
                        
            setAttributesForManageAUser(request, response, user);
            View.forwardPage(request, response, Path.USER_SERVLET_VIEW_PATH + "/manageUser.jsp");
        }
    }
    
    private void processViewProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userType = request.getParameter("userType");
        int userID = Integer.parseInt(request.getParameter("userID"));
        
        if(isStringIsNullOrEmpty(userType) || isStringIsNullOrEmpty(Integer.toString(userID))) {
            
        }
        else {
            if(user != null && user.getUserType().equals(userType) && user.getUserID() == userID) {
                setAttributesForManageAUser(request, response, user);
            }
            else {
                user = new User();
                if(setCurrentUser(userType, userID)) {
                    setAttributesForManageAUser(request, response, user);
                }
            }
            View.forwardPage(request, response, Path.USER_SERVLET_VIEW_PATH + "/manageUser.jsp");
        }
    }
    
    private void processViewUserList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String viewUserType = request.getParameter("viewUserType");
            
        if(isStringIsNullOrEmpty(viewUserType)) {

        }
        else if(viewUserType.equals(USER_TYPE_CUSTOMER)) {
            
            request.setAttribute("selectedPage", "customersListPage");
            try {
                setAllUsersInformationWithSelectedType(USER_TYPE_CUSTOMER);
                setAttributesForViewUserList(request, response, USER_TYPE_CUSTOMER);
                View.forwardPage(request, response, Path.USER_SERVLET_VIEW_PATH + "/viewUserListPage.jsp");
            } catch (SQLException ex) {
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        else if(viewUserType.equals(USER_TYPE_STAFF)) {
            
            request.setAttribute("selectedPage", "staffListPage");
            try {
                setAllUsersInformationWithSelectedType(USER_TYPE_STAFF);
                setAttributesForViewUserList(request, response, USER_TYPE_STAFF);
                View.forwardPage(request, response, Path.USER_SERVLET_VIEW_PATH + "/viewUserListPage.jsp");
            } catch (SQLException ex) {
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    
    private void setAttributesForViewUserList(HttpServletRequest request, HttpServletResponse response, String userType)
            throws ServletException, IOException {
        
        request.setAttribute("users", users);
        request.setAttribute("labels", this.PUBLIC_INFO_LABELS);
        request.setAttribute("userType", userType.toUpperCase());
        request.setAttribute("labelsLength", this.PUBLIC_INFO_LABELS.length);
    }
    
    private void setAttributesForManageAUser(HttpServletRequest request, HttpServletResponse response, User selectedUser)
            throws ServletException, IOException {
        
        request.setAttribute("selectedUser", selectedUser);
        request.setAttribute("selectedUserType", selectedUser.getUserType());
        request.setAttribute("selectedUserProfilePhoto", selectedUser.getProfilePhoto());
    }

    private boolean checkUserInput(HttpServletRequest request) {
        String phoneNumber = request.getParameter("phoneNumber");
        String password = request.getParameter("pwd");
        String confirmPassword = request.getParameter("confirmPwd");
        
        if(!phoneNumber.matches("^[0-9]+$")) {
            errorMessage = "Please enter a valid phone number";
            return false;
        }
        else if(!password.equals(confirmPassword)) {
            errorMessage = "The password you entered does not match";
            return false;
        }
        return true;
    }
}
