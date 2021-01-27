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
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
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
    
    private final String VIEW_ORDER_FOOD = "viewOrderFood";
    private final String ADD_FOOD_TO_CART = "addFood";
    private final String DELETE_FOOD_IN_CART = "deleteFoodInCart";
    private final String CANCEL_ORDER_FOOD = "cancelOrderFood";
    private final String CONFIRM_ORDER_FOOD = "confirmOrderFood";

    private static ArrayList<Food> foodInCartList = new ArrayList<Food>();
    private static double totalFoodPrice;
    private static int bookingID;
    private static int timeCode;
    private static String foodCategory;
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
        else if(action.equals(VIEW_ORDER_FOOD)) {
            foodInCartList.removeAll(foodInCartList);
            getFoodList(request);
            forwardPage(request, response, Path.ORDER_FOOD_VIEW_PATH);
        }
        else if(action.equals(ADD_FOOD_TO_CART)) {
            foodInCartList.add(addFoodToCart(request));
            totalFoodPrice = calculateTotalPrice(foodInCartList);
            request.setAttribute("foodInCartList", foodInCartList);
            request.setAttribute("totalPrice", totalFoodPrice);
            request.setAttribute("isFoodAdded", true);
            getFoodList(request);
            forwardPage(request, response, Path.ORDER_FOOD_VIEW_PATH);
        }
        else if(action.equals(DELETE_FOOD_IN_CART)) {
            deleteFoodInCartList(request);
            totalFoodPrice = calculateTotalPrice(foodInCartList);
            request.setAttribute("foodInCartList", foodInCartList);
            request.setAttribute("totalPrice", totalFoodPrice);
            request.setAttribute("isFoodAdded", true);
            getFoodList(request);
            forwardPage(request, response, Path.ORDER_FOOD_VIEW_PATH);
        }
        else if(action.equals(CONFIRM_ORDER_FOOD)) {
            if(setFoodOrderIntoDatabase(request))
                forwardPage(request, response, "BookingServlet?action=viewBookingListForCustomer");
        }
        else if(action.equals(CANCEL_ORDER_FOOD)) {
            forwardPage(request, response, "BookingServlet?action=viewBookingListForCustomer");
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
            ArrayList<Food> foodList = new ArrayList<Food>();
            HttpSession session = request.getSession();
            timeCode = (Integer) session.getAttribute("timeCode");
            foodCategory = categoryPicker();
            System.out.println("Category" + foodCategory);
            Connection con = new Database().getCon();
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_RETRIEVE_FOOD_LIST);
            st.setString(1, foodCategory);
            ResultSet rs = st.executeQuery();
            
            while(rs.next()) {
                foodList.add(new Food(rs.getInt("food_id"), rs.getString("food_name"), rs.getDouble("food_price"), rs.getString("food_description"), rs.getString("food_photo")));
            }
            
            request.setAttribute("foodList", foodList);
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(OrderFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private Food addFoodToCart(HttpServletRequest request) {
        Food foodInCart;
        int foodID = Integer.parseInt(request.getParameter("foodID"));
        String foodName = request.getParameter("foodName");
        int foodQuantity = Integer.parseInt(request.getParameter("foodQuantity"));
        double foodPrice = Double.parseDouble(request.getParameter("foodPrice"));
        double totalPrice = foodPrice * foodQuantity;
        
        foodInCart = new Food(foodID, foodName, totalPrice, foodQuantity);
        
        Logger.getLogger(Database.class.getName()).log(Level.INFO, "INFO" + foodID + " " + foodName + " " + foodPrice + " " +  foodQuantity + " " + totalPrice);
        return foodInCart;
    }

    private boolean setFoodOrderIntoDatabase(HttpServletRequest request) {
        try {
            HttpSession session = request.getSession();
            int insertStatus = 0;
            bookingID = (Integer) session.getAttribute("bookingID");
            Connection con = new Database().getCon();
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_INSERT_ORDER_ITEM);
            
            for(Food f: foodInCartList) {
                st.setInt(1, f.getFoodQuantity());
                st.setDouble(2, f.getFoodPrice());
                st.setInt(3, bookingID);
                st.setInt(4, f.getFoodID());
                
                insertStatus += st.executeUpdate();
                
                Logger.getLogger(Database.class.getName()).log(Level.INFO, "INFO" + " " + bookingID + " " + f.getFoodQuantity() + " " + totalFoodPrice + " " + f.getFoodID() );
            }
            Logger.getLogger(Database.class.getName()).log(Level.INFO, "INFO" + " " + insertStatus + " " + foodInCartList.size());
            st.close();
            if(insertStatus == foodInCartList.size()) return true;
            
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(OrderFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }


    private void deleteFoodInCartList(HttpServletRequest request) {
        int indexOfFood = Integer.parseInt(request.getParameter("indexOfFood"));
        Logger.getLogger(Database.class.getName()).log(Level.INFO, "INFO" + indexOfFood);
        
        foodInCartList.remove(indexOfFood);
    }
    
    private double calculateTotalPrice(ArrayList<Food> foodInCartList) {
        double totalPrice = 0.0;
        for(Food foodInCart: foodInCartList) {
            totalPrice += foodInCart.getFoodPrice();
        }
        return totalPrice;
    }
    
    private void forwardPage(HttpServletRequest request, HttpServletResponse response,String pagePath)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher(pagePath);
        dispatcher.forward(request, response);
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
    
}
