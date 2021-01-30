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
import java.util.Iterator;
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
public class OrderFoodServlet extends HttpServlet {
    
    private final String ACTION_VIEW_ORDER_FOOD = "viewOrderFood";
    private final String ACTION_ADD_FOOD_TO_CART = "addFood";
    private final String ACTION_DELETE_FOOD_IN_CART = "deleteFoodInCart";
    private final String ACTION_CANCEL_ORDER_FOOD = "cancelOrderFood";
    private final String ACTION_CONFIRM_ORDER_FOOD = "confirmOrderFood";
    private final String ACTION_GET_FOOD_IMAGE = "getFoodImage";

    private static ArrayList<Food> foodList = new ArrayList<>();
    private static ArrayList<Food> foodInCartList = new ArrayList<>();
    private static double totalFoodPrice;
    private static int bookingID;
    private static int timeCode;
    private static String foodCategory;
    
    // get the bookingPrice from the Booking Servlet via request.getParameter()
    private static double bookingPrice = .0;
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
            System.out.println("getffodIMgeag");
            getFoodImage(response, foodID);
        }
        if(!com.RERES.utility.SessionValidator.checkSession(request, response)) return;
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
        if(!com.RERES.utility.SessionValidator.checkSession(request, response)) return;
        String action = request.getParameter("action");
        
        if(isStringIsNullOrEmpty(action)) {
            
        }
        else if(action.equals(ACTION_VIEW_ORDER_FOOD)) {
            // This is where the bookingPrice was initialized
            bookingPrice = Double.parseDouble(request.getParameter("bookingPrice"));
            foodList.clear();
            foodInCartList.removeAll(foodInCartList);
            getFoodList(request);
            forwardPage(request, response, Path.ORDER_FOOD_VIEW_PATH);
        }
        else if(action.equals(ACTION_ADD_FOOD_TO_CART)) {
            addFoodToCart(request);
            totalFoodPrice = calculateTotalPrice(foodInCartList);
            request.setAttribute("foodInCartList", foodInCartList);
            request.setAttribute("totalPrice", totalFoodPrice);
            request.setAttribute("isFoodAdded", true);
            foodList.removeAll(foodList);
            getFoodList(request);
            forwardPage(request, response, Path.ORDER_FOOD_VIEW_PATH);
        }
        else if(action.equals(ACTION_DELETE_FOOD_IN_CART)) {
            deleteFoodInCartList(request);
            totalFoodPrice = calculateTotalPrice(foodInCartList);
            request.setAttribute("foodInCartList", foodInCartList);
            request.setAttribute("totalPrice", totalFoodPrice);
            request.setAttribute("isFoodAdded", true);
            foodList.removeAll(foodList);
            getFoodList(request);
            forwardPage(request, response, Path.ORDER_FOOD_VIEW_PATH);
        }
        else if(action.equals(ACTION_CONFIRM_ORDER_FOOD)) {
            HttpSession session = request.getSession(false);
            int selectedBookingID = (Integer) session.getAttribute("bookingID");    
            
            if(setFoodOrderIntoDatabase(request, selectedBookingID)) {
                double payAmount = .0;
                
                // Calculate total Amount need to be paid
                payAmount = foodInCartList.stream().map((f) -> f.getFoodPrice()).reduce(payAmount, (accumulator, _item) -> accumulator + _item);
                payAmount += bookingPrice;
                
                String[] nameLabels = {"payAmount", "payName", "bookingID"};
                String[] valueLabels = {Double.toString(payAmount), "" ,Integer.toString(selectedBookingID)};
                
                View.setOverlayStatusMessage(request, response, "viewPaymentForm", "Please Pay Now, Your orders would not be processed if you did not pay for it", "PaymentServlet", nameLabels, valueLabels);
                
                View.includePage(request, response, Path.HOME_VIEW_PATH);
            }
        }
        else if(action.equals(ACTION_CANCEL_ORDER_FOOD)) {
            HttpSession session = request.getSession(false);
            int selectedBookingID = (Integer) session.getAttribute("bookingID");
            
            String[] nameLabels = {"bookingID"};
            String[] valueLabels = {Integer.toString(selectedBookingID)};
            
            View.setOverlayStatusMessage(request, response, "viewTheSelectedBooking", "You have cancelled the food order", "BookingServlet", nameLabels, valueLabels);
            View.includePage(request, response, Path.HOME_VIEW_PATH);
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
    
    
    private void getFoodList(HttpServletRequest request) {
        try {
            HttpSession session = request.getSession();
            timeCode = (Integer) session.getAttribute("timeCode");
            foodCategory = categoryPicker();
            Connection con = new Database().getCon();
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_RETRIEVE_FOOD_LIST_BY_CATEGORY);
            st.setString(1, foodCategory);
            ResultSet rs = st.executeQuery();
            
            while(rs.next()) {
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
                
                foodList.add(new Food(rs.getInt("food_id"), rs.getString("food_name"), rs.getDouble("food_price"), rs.getString("food_description"), base64Image));
            }
            
            request.setAttribute("foodList", foodList);
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(OrderFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(OrderFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void addFoodToCart(HttpServletRequest request) {
        Food foodInCart;
        int foodID = Integer.parseInt(request.getParameter("foodID"));
        String foodName = request.getParameter("foodName");
        int foodQuantity = Integer.parseInt(request.getParameter("foodQuantity"));
        double foodPrice = Double.parseDouble(request.getParameter("foodPrice"));
        double totalPrice = foodPrice * foodQuantity;
        System.out.println("id"+foodID+" name:"+foodName+" qty:"+foodQuantity+ " fpri:"+foodPrice+" tpri:"+totalPrice);
        
        foodInCart = new Food(foodID, foodName, totalPrice, foodQuantity);
        
        if(foodInCartList.isEmpty()) {
            System.out.println("empty then added");
            foodInCartList.add(foodInCart);
        }
        else {
            int foodIndex;
            if(checkIfFoodInCart(foodID) == 1)
            {
                System.out.println("same food");
                foodIndex = getIndexOfSameFood(foodID);
                System.out.println("foodID: " + foodID + "  " + "gotFoodIndex: "+foodIndex);
                foodInCartList.get(foodIndex).setFoodQuantity(foodQuantity + foodInCartList.get(foodIndex).getFoodQuantity());
                foodInCartList.get(foodIndex).setFoodPrice(foodInCartList.get(foodIndex).getFoodQuantity()*foodPrice);
            }
            else {
                System.out.println("not same food");
                foodInCartList.add(foodInCart);
            }
            
        }
    }

    private boolean setFoodOrderIntoDatabase(HttpServletRequest request, int selectedBookingID) {
        try {
            
            int insertStatus = 0;
            
            Connection con = new Database().getCon();
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_INSERT_ORDER_ITEM);
            
            for(Food f: foodInCartList) {
                st.setInt(1, f.getFoodQuantity());
                st.setDouble(2, f.getFoodPrice());
                st.setInt(3, selectedBookingID);
                st.setInt(4, f.getFoodID());
                
                insertStatus += st.executeUpdate();
            }
            
            st.close();
            
            if(insertStatus == foodInCartList.size()) return true;
            
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(OrderFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    private void deleteFoodInCartList(HttpServletRequest request) {
        int indexOfFood = Integer.parseInt(request.getParameter("indexOfFood"));
        
        foodInCartList.remove(indexOfFood);
    }
    
    private double calculateTotalPrice(ArrayList<Food> foodInCartList) {
        double totalPrice = 0.0;
        for(Food foodInCart: foodInCartList) {
            totalPrice += foodInCart.getFoodPrice();
        }
        return totalPrice;
    }
    
    private int getIndexOfSameFood(int foodID) {
        int same = 0;
        int indexOfFood = 0;
        for(int i = 0; i<foodInCartList.size(); i++) {
            if(foodID == foodInCartList.get(i).getFoodID()) {
                same += 1;
                indexOfFood = i;
            }
        }
        if(same == 1) return indexOfFood;
        else return -1;
    }
    
    private int checkIfFoodInCart(int foodID) {
        int same = 0;
        for(int i = 0; i<foodInCartList.size(); i++) {
            if(foodID == foodInCartList.get(i).getFoodID()) {
                same += 1;
            }
        }
        return same;
    }
    
    private void forwardPage(HttpServletRequest request, HttpServletResponse response,String pagePath)
            throws ServletException, IOException {
        View.forwardPage(request, response, pagePath);
    }
    
    private boolean isStringIsNullOrEmpty(String inputString) {
        return inputString == null || inputString.equals("");
    }
    
    private String categoryPicker() {
        if(timeCode >=1 && timeCode <=3) return "breakfast";
        else if(timeCode >=4 && timeCode <=9) return "lunch";
        else if(timeCode >=10 && timeCode <=14) return "dinner";
        else return null;
    }
    
    private void getFoodImage(HttpServletResponse response, int foodID) {
        for(Food f : foodList) {
            if(f.getFoodID() == foodID) {
                System.out.println(f.getFoodPhoto());
                try {
                    ImageUtility.displaySelectedImage(response, f.getFoodPhoto());
                } catch (ServletException | IOException ex) {
                    Logger.getLogger(ManageFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }
}
