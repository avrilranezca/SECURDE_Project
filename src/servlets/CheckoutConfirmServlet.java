package servlets;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import model.Address;
import model.Transaction;
import model.TransactionEntry;
import model.User;
import database.ProductDAO;
import database.TransactionDAO;
import database.UserDAO;

/**
 * Servlet implementation class CheckoutConfirmServlet
 */
@WebServlet("/CheckoutConfirmServlet")
public class CheckoutConfirmServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckoutConfirmServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 UserDAO uDAO = new UserDAO();
		 String userName = checkUser(request);
         if (userName!=null) {
        	 User u = uDAO.getUser(userName);
        	 Address a =  uDAO.getBillingAddress(u.getBilling_address_id());
             request.setAttribute("billing", a);
             
             a = uDAO.getShippingAddress(u.getShipping_address_id());
             request.setAttribute("shipping", a);
        
         }else{
        	  request.setAttribute("billing", null);
        	  request.setAttribute("shipping", null);
         }
        
 		 request.getRequestDispatcher("checkout_confirm.jsp").forward(request, response);
 	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userName = checkUser(request);
		if(userName != null){
			
			TransactionDAO tDAO = new TransactionDAO();
			ProductDAO pDAO = new ProductDAO();
			ArrayList<TransactionEntry> entryList = new ArrayList<TransactionEntry>();
			
			Calendar cal = Calendar.getInstance(); 
			Transaction t = new Transaction(new UserDAO().getUser(userName).getId(), cal.getTime());
			
			String s = (String) request.getSession().getAttribute("item");
			JSONArray arr;
			
			try {
				arr = new JSONArray(s);
				for(int i=0; i<arr.length(); i++){
					JSONObject obj = arr.getJSONObject(i);
					int product_id = Integer.parseInt(obj.getString("id"));
					int quantity = obj.getInt("quantity");
					double price = pDAO.getProductOnID(product_id).getPrice();
					
					TransactionEntry  te = new TransactionEntry(product_id, quantity, quantity*price);
					entryList.add(te);
				}
				
				tDAO.addTransaction(t, entryList);
				
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public String checkUser(HttpServletRequest request){
  	  String userName="";
        boolean foundCookie = false;         
        if(request.getSession().getAttribute("user") != null){

            userName = (String) request.getSession().getAttribute("user");
            foundCookie=true;
        }
        Cookie[] cookies = request.getCookies();

        if(cookies !=null){
            for(int i = 0; i < cookies.length; i++) {
                Cookie c = cookies[i];
                if (c.getName().equals("user")) {
                    foundCookie = true;
                }
            }
        }
        
        if (foundCookie && userName!=null) {
      	  return userName;
        }
        
        return null;
	}
}
