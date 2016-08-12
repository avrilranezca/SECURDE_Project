package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Address;
import model.User;
import database.AddressDAO;
import database.UserDAO;

/**
 * Servlet implementation class CheckoutServlet
 */
@WebServlet("/CheckoutShippingServlet")
public class CheckoutShippingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
    public CheckoutShippingServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String userName = (String) request.getSession().getAttribute("user");
		
		String sessionID = request.getSession().getId();
		UserDAO uDAO = new UserDAO();
		User u = uDAO.getUser(userName);
		
		System.out.println("Username: "+ u.getUser_name());
		String uSessionID = uDAO.getUserSessionID(u);
		
		if(uSessionID.equals(sessionID)){
			
			if(u != null){
				System.out.println("not null si user inside checout hsipping");
				System.out.println("Shipping address iD: "+ u.getShipping_address_id());
	        	Address a =  uDAO.getShippingAddress(u.getShipping_address_id());
	        	if(a == null)
	        		System.out.println("null si address :( ");
	        	System.out.println("A: "+ a.getCity());
	        	
	            request.getSession().setAttribute("address", a);
			}
			
			String encodedURL = response.encodeRedirectURL("checkout_shipping.jsp");
			request.getRequestDispatcher(encodedURL).forward(request, response);
			
		}else{
			uDAO.setUserSessionID(u, null);
			String encodedURL = response.encodeRedirectURL("/index");
			response.sendRedirect(encodedURL);
		}        
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String sHouseNo = request.getParameter("sHouseNo");
		String sSubdivision = request.getParameter("sSubdivision");
		String sPostalCode = request.getParameter("sPostalCode");
		String sStreet = request.getParameter("sStreet");
		String sCity = request.getParameter("sCity");
		String sCountry = request.getParameter("sCountry");
		
		String userName = (String) request.getSession().getAttribute("user");
		String sessionID = request.getSession().getId();
	   
		UserDAO uDAO = new UserDAO();
		User u = uDAO.getUser(userName);
		String uSessionID = uDAO.getUserSessionID(u);
		String encodedURL = "";
		
		if(uSessionID.equals(sessionID)){
			if(u!= null){
				Address a = new Address(sHouseNo, sStreet, sSubdivision, sCity, sPostalCode, sCountry);
				AddressDAO aDAO = new AddressDAO();
				aDAO.updateAddress(u.getShipping_address_id(), a);
				encodedURL = response.encodeRedirectURL("checkout_billing.jsp");
		 		request.getRequestDispatcher(encodedURL).forward(request, response);
			}
		}else{
			uDAO.setUserSessionID(u, null);
			encodedURL = response.encodeRedirectURL("/index");
			response.sendRedirect(encodedURL);
		}
	}
}
