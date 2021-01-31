/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RERES.controller;

import com.RERES.database.Database;
import com.RERES.path.Path;
import com.RERES.model.Food;
import com.RERES.database.SQLStatementList;
import com.RERES.utility.ImageUtility;
import com.RERES.view.View;
import java.io.ByteArrayOutputStream;
import java.sql.*;
import java.io.IOException;
import java.io.InputStream;
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
 * @author ainal farhan
 */
public class ManageFoodServlet extends HttpServlet {
    private static final String ACTION_VIEW_LIST_OF_MENU = "viewListOfMenu";
    private static final String ACTION_GO_TO_ADD_NEW_FOOD = "goToAddNewFood";
    private static final String ACTION_GO_TO_UPDATE_FOOD = "goToUpdateFood";
    private static final String ACTION_ADD_NEW_FOOD = "addNewFood";
    private static final String ACTION_DELETE_FOOD = "deleteFood";
    private static final String ACTION_GET_FOOD_IMAGE = "getFoodImage";
    private static final String ACTION_UPDATE_FOOD = "updateFood";
    
    private static ArrayList<Food> allFoodList = new ArrayList<Food>();
            
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
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
        String action = request.getParameter("action");
        int foodID = Integer.parseInt(request.getParameter("foodID"));
        
        if(isStringIsNullOrEmpty(action)) {
            
        }
        else if(action.equals(ACTION_GET_FOOD_IMAGE)) {
            System.out.println(foodID);
            getFoodImage(response, foodID);
        }
//        processRequest(request, response);
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
        if(!com.RERES.utility.SessionValidator.checkSession(request, response)) return;
        
        String action = request.getParameter("action");
        System.out.println(action);
        
        if(isStringIsNullOrEmpty(action)) {
            
        }
        else if(action.equals(ACTION_VIEW_LIST_OF_MENU)) {
            request.setAttribute("selectedPage", "manageFoodPage");
            allFoodList.removeAll(allFoodList);
            getFoodMenuList(request);
            View.forwardPage(request, response, Path.MENU_LIST_VIEW_PATH);
        }
        else if(action.equals(ACTION_GO_TO_ADD_NEW_FOOD)) {
            request.setAttribute("selectedPage", "manageFoodPage");
            View.forwardPage(request, response, Path.ADD_NEW_FOOD_VIEW_PATH);
        }
        else if(action.equals(ACTION_GO_TO_UPDATE_FOOD)) {
            System.out.println(request.getParameter("foodID"));
            request.setAttribute("selectedPage", "manageFoodPage");
            processGetFoodDetailsForUpdate(request, response);
        }
        else if(action.equals(ACTION_ADD_NEW_FOOD)) {
            request.setAttribute("selectedPage", "manageFoodPage");
            processAddNewFood(request, response);
        }
        else if(action.equals(ACTION_DELETE_FOOD)) {
            request.setAttribute("selectedPage", "manageFoodPage");
            processDeleteAFood(request, response);
        }
        else if(action.equals(ACTION_UPDATE_FOOD)) {
            request.setAttribute("selectedPage", "manageFoodPage");
            processUpdateFoodDetails(request, response);
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
    
    private void processGetFoodDetailsForUpdate(HttpServletRequest request, HttpServletResponse response) {
        if(getFoodDetailsByFoodID(request)) {
            try {
                System.out.println("Suppose go to update food");
                View.forwardPage(request, response, Path.UPDATE_FOOD_VIEW_PATH);
            } catch (ServletException | IOException ex) {
                Logger.getLogger(ManageFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        else System.out.println("Fail to go to update food");
    }

    private void processAddNewFood(HttpServletRequest request, HttpServletResponse response) {
        try {
            String message;
            
            if(setNewFoodIntoDatabase(request)) message = "New food added succesfully";
            else message = "Failed to add new food";

            View.setOverlayStatusMessage(request, response, ACTION_VIEW_LIST_OF_MENU, message, "ManageFoodServlet", null, null);

            View.includePage(request, response, Path.MENU_LIST_VIEW_PATH);
        } catch (ServletException | IOException ex) {
            Logger.getLogger(ManageFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }

    private void processUpdateFoodDetails(HttpServletRequest request, HttpServletResponse response) {
        try {
            String message;
            
            if(updateFoodDetails(request)) message = "Food details updated succesfully";
            else message = "Failed update food details";

            View.setOverlayStatusMessage(request, response, ACTION_VIEW_LIST_OF_MENU, message, "ManageFoodServlet", null, null);

            View.includePage(request, response, Path.MENU_LIST_VIEW_PATH);
        } catch (ServletException | IOException ex) {
            Logger.getLogger(ManageFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void processDeleteAFood(HttpServletRequest request, HttpServletResponse response) {
        try {
            String message;
            
            if(deleteAFoodFromDatabase(request)) message = "Food deleted succesfully";
            else message = "Failed to delete food";

            View.setOverlayStatusMessage(request, response, ACTION_VIEW_LIST_OF_MENU, message, "ManageFoodServlet", null, null);

            View.includePage(request, response, Path.MENU_LIST_VIEW_PATH);
        } catch (ServletException | IOException ex) {
            Logger.getLogger(ManageFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void getFoodMenuList(HttpServletRequest request) {
        try {
            Connection con = new Database().getCon();
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_RETRIEVE_FOOD_LIST);
            ResultSet result = st.executeQuery();
            
            while(result.next()) {
                Blob blob = result.getBlob("food_photo");
                ByteArrayOutputStream outputStream = null;
                String base64Image = null;
                try (InputStream inputStream = blob.getBinaryStream()) {
                    outputStream = new ByteArrayOutputStream();
                    byte[] buffer = new byte[4096];
                    int bytesRead = -1;
                    while ((bytesRead = inputStream.read(buffer)) != -1) {                  
                        outputStream.write(buffer, 0, bytesRead);
                    }   byte[] imageBytes = outputStream.toByteArray();
                    base64Image = Base64.getEncoder().encodeToString(imageBytes);
                } catch (IOException ex) {
                    Logger.getLogger(ManageFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                outputStream.close();
                
                allFoodList.add(new Food(result.getInt("food_id"), result.getString("food_name"), result.getDouble("food_price"), result.getString("food_description"), base64Image, result.getString("food_category")));
            }
            
            request.setAttribute("allFoodList", allFoodList);
            
        } catch (SQLException | ClassNotFoundException | IOException ex) {
            Logger.getLogger(ManageFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private boolean setNewFoodIntoDatabase(HttpServletRequest request) {
        try {
            String foodName = request.getParameter("foodName");
            double foodPrice = Double.parseDouble(request.getParameter("foodPrice"));
            String foodDesc = request.getParameter("foodDescription");
            String foodCategory = request.getParameter("foodCategory");
            String uploadedImage = request.getParameter("uploadedBase64Image");
            byte[] translatedImage = ImageUtility.translateBase64ImageToBytes(uploadedImage);
            String fileName = request.getParameter("uploadedFileName");
            
            Connection con = new Database().getCon();
            
            Blob imageBlob = con.createBlob();
            imageBlob.setBytes(1, translatedImage);
            
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_INSERT_NEW_FOOD);
            
            st.setString(1, foodName);
            st.setDouble(2, foodPrice);
            st.setString(3, foodDesc);
            st.setString(4, foodCategory);
            st.setBlob(5, imageBlob);
            
            
            if(st.executeUpdate() > 0) {
                return true;
            }
            
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(ManageFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    private boolean updateFoodDetails(HttpServletRequest request) {
        try {
            int foodID = Integer.parseInt(request.getParameter("foodID"));
            String foodName = request.getParameter("foodName");
            double foodPrice = Double.parseDouble(request.getParameter("foodPrice"));
            String foodDesc = request.getParameter("foodDescription");
            String foodCategory = request.getParameter("foodCategory");
            String uploadedImage = request.getParameter("uploadedBase64Image");
            byte[] translatedImage = ImageUtility.translateBase64ImageToBytes(uploadedImage);
            String fileName = request.getParameter("uploadedFileName");
            
            Connection con = new Database().getCon();
            
            Blob imageBlob = con.createBlob();
            imageBlob.setBytes(1, translatedImage);
            
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_UPDATE_FOOD_DETAILS);
            
            st.setString(1, foodName);
            st.setDouble(2, foodPrice);
            st.setString(3, foodDesc);
            st.setString(4, foodCategory);
            st.setBlob(5, imageBlob);
            st.setInt(6, foodID);
            
            if(st.executeUpdate() > 0) {
                return true;
            }
            
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(ManageFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    private boolean deleteAFoodFromDatabase(HttpServletRequest request) {
        try {
            int foodID = Integer.parseInt(request.getParameter("foodID"));
            
            Connection con = new Database().getCon();
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_DELETE_A_FOOD);
            
            st.setInt(1, foodID);
            
            if(st.executeUpdate() > 0) {
                return true;
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(ManageFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    private boolean getFoodDetailsByFoodID(HttpServletRequest request) {
        try {
            Food food = new Food();
            int foodID = Integer.parseInt(request.getParameter("foodID"));
            
            Connection con = new Database().getCon();
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_RETRIEVE_FOOD_LIST_BY_FOODID);
            
            st.setInt(1, foodID);
            
            ResultSet rs = st.executeQuery();
            
            while(rs.next()) {
                food.setFoodID(rs.getInt("food_id"));
                food.setFoodName(rs.getString("food_name"));
                food.setFoodPrice(rs.getDouble("food_price"));
                food.setFoodDescription(rs.getString("food_description"));
                food.setFoodCategory(rs.getString("food_category"));
                
                Blob blob = rs.getBlob("food_photo");
                ByteArrayOutputStream outputStream = null;
                String base64Image = null;
                try (InputStream inputStream = blob.getBinaryStream()) {
                    outputStream = new ByteArrayOutputStream();
                    byte[] buffer = new byte[4096];
                    int bytesRead = -1;
                    while ((bytesRead = inputStream.read(buffer)) != -1) {                  
                        outputStream.write(buffer, 0, bytesRead);
                    }   byte[] imageBytes = outputStream.toByteArray();
                    base64Image = Base64.getEncoder().encodeToString(imageBytes);
                } catch (IOException ex) {
                    Logger.getLogger(ManageFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                outputStream.close();
                
                food.setFoodPhoto(base64Image);
                
                request.setAttribute("food", food);
                return true;
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(ManageFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(ManageFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    private boolean isStringIsNullOrEmpty(String inputString) {
        return inputString == null || inputString.equals("");
    }

    private void getFoodImage(HttpServletResponse response, int foodID) {
        for(Food f : allFoodList) {
            if(f.getFoodID() == foodID) {
                try {
                    ImageUtility.displaySelectedImage(response, f.getFoodPhoto());
                } catch (ServletException | IOException ex) {
                    Logger.getLogger(ManageFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }
}
