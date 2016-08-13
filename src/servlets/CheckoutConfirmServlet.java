package servlets;

import database.ProductDAO;
import database.TransactionDAO;
import database.UserDAO;
import log.Logger;
import model.Address;
import model.Transaction;
import model.TransactionEntry;
import model.User;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;

/**
 * Servlet implementation class CheckoutConfirmServlet
 */
@WebServlet("/CheckoutConfirmServlet")
public class CheckoutConfirmServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public CheckoutConfirmServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userName = (String) request.getSession().getAttribute("user");
		String sessionID = request.getSession().getId();

		UserDAO uDAO = new UserDAO();
		User u = uDAO.getUser(userName);
		String uSessionID = uDAO.getUserSessionID(u);

		if(uSessionID.equals(sessionID)){
			if(u != null){
				Address a =  uDAO.getBillingAddress(u.getBilling_address_id());
				request.getSession().setAttribute("billing", a);

				a = uDAO.getShippingAddress(u.getShipping_address_id());
				request.getSession().setAttribute("shipping", a);

				String encodedURL = response.encodeRedirectURL("checkout_confirm.jsp");
				request.getRequestDispatcher(encodedURL).forward(request, response);
			}

		}else{
			uDAO.setUserSessionID(u, null);
			String encodedURL = response.encodeRedirectURL("/index");
			response.sendRedirect(encodedURL);
		}

        
 	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String userName = (String) request.getSession().getAttribute("user");
		String sessionID = request.getSession().getId();
	   
		UserDAO uDAO = new UserDAO();
		User u = uDAO.getUser(userName);
		String uSessionID = uDAO.getUserSessionID(u);
		
		String password = request.getParameter("password");
		System.out.println("password inside checkout confirm: "+ password);

		if(uSessionID.equals(sessionID)){
			
			User temp = uDAO.getUser(userName,password);
			if(temp != null){
				TransactionDAO tDAO = new TransactionDAO();
				ProductDAO pDAO = new ProductDAO();
				ArrayList<TransactionEntry> entryList = new ArrayList<TransactionEntry>();
				
				Calendar cal = Calendar.getInstance(); 
				Transaction t = new Transaction(temp.getId(), cal.getTime());
				
				String s = (String) request.getSession().getAttribute("item");
				JSONArray arr, arrTemp;
				try {
					arr = new JSONArray(s);
					int length = arr.length();
					
					for(int i=0; i<length; i++){
						JSONObject obj = arr.getJSONObject(i);
						int product_id = Integer.parseInt(obj.getString("id"));
						System.out.println("productID: "+ product_id);
						int quantity = obj.getInt("quantity");
						double price = pDAO.getProductOnID(product_id).getPrice();
						System.out.println("price: "+ price + product_id);
						TransactionEntry  te = new TransactionEntry(product_id, quantity, quantity*price);
						entryList.add(te);
						System.out.println("entryList: "+ entryList.size());
						//arr.remove(i);

					}
					System.out.println("2 entryList: "+ entryList.size());
					System.out.println("success! : "+ arr.length());
					tDAO.addTransaction(t, entryList);
					request.getSession().setAttribute("item",null);
					String encodedURL = response.encodeRedirectURL("/index");
					request.getRequestDispatcher(encodedURL).forward(request, response);
					
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					response.getWriter().append("I'm sorry. I died. Maybe it's 404.");
				}
								
			  //  arr.        
	          //  request.getSession().setAttribute("item", arr.toString());
				

			
			}else{
				System.out.println("malii password");
				
				if(temp!=null || (temp!=null && uDAO.isLocked(temp.getId())!=null)){
					System.out.print("lck: ");
					System.out.println(request.getSession().getAttribute("lock"));
					
					int i = uDAO.getLogInAttempts(temp.getId());
		//					request.getSession().setAttribute("lock", i+1);
					uDAO.incrementLogInAttempts(temp.getId());
		
					if(i+1>=5){
						if(uDAO.isLocked(temp.getId())==null){
							System.out.println("here");
							uDAO.lock(temp.getId());
							Logger.write(temp.getId() + "", request.getRemoteAddr(), "locked out");
						//	request.setAttribute("error", "Incorrect password! Too many failed attempts at logging in. This account has been locked for five minutes.");
							String encodedURL = response.encodeRedirectURL("login.jsp");
							request.getRequestDispatcher(encodedURL).forward(request, response);
						}
						else{
							System.out.println("there");
							String encodedURL = response.encodeRedirectURL("login.jsp");
							request.getRequestDispatcher(encodedURL).forward(request, response);
							//request.setAttribute("error", "Too many failed attempts at logging in. This account has been locked for five minutes.");
						}
					} else{
						Logger.write(temp.getId() + "", request.getRemoteAddr(), "unsuccessful password validation");
					}
					
					//if the password is wrong set redirected page to login
		
				
				}
				
				response.setContentType("text/plain");
			    response.setCharacterEncoding("UTF-8");
			    response.getWriter().write("-1");
			   System.out.println("send fail");
			   
			   //or this one?
			   //String encodedURL = response.encodeRedirectURL("CheckoutConfirmServlet");
			//   request.getRequestDispatcher(encodedURL).forward(request, response);
			}
			
		}else{
			System.out.println("mismatch session");
			uDAO.setUserSessionID(u, null);	
			String encodedURL = response.encodeRedirectURL("/index");
			response.sendRedirect(encodedURL);
		}	
	}
}
