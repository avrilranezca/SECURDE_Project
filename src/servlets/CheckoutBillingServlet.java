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
 * Servlet implementation class CheckoutBillingServlet
 */
@WebServlet("/CheckoutBillingServlet")
public class CheckoutBillingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public CheckoutBillingServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 
		String userName = (String) request.getSession().getAttribute("user");
		String sessionID = request.getSession().getId();
	   
		UserDAO uDAO = new UserDAO();
		User u = uDAO.getUser(userName);
		String uSessionID = uDAO.getUserSessionID(u);
		String encodedURL = "";
		
		if(uSessionID.equals(sessionID)){
			if(u != null){
				Address a =  uDAO.getBillingAddress(u.getBilling_address_id());
	            request.getSession().setAttribute("address", a);
	            encodedURL = response.encodeRedirectURL("checkout_billing.jsp");
			}
			
			request.getRequestDispatcher(encodedURL).forward(request, response);

		}else{
			uDAO.setUserSessionID(u, null);
			encodedURL = response.encodeRedirectURL("/index");
			response.sendRedirect(encodedURL);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String sHouseNo = request.getParameter("bHouseNo");
		String sSubdivision = request.getParameter("bSubdivision");
		String sPostalCode = request.getParameter("bPostalCode");
		String sStreet = request.getParameter("bStreet");
		String sCity = request.getParameter("bCity");
		String sCountry = request.getParameter("bCountry");
		

		String userName = (String) request.getSession().getAttribute("user");
		String sessionID = request.getSession().getId();
	   
		UserDAO uDAO = new UserDAO();
		User u = uDAO.getUser(userName);
		String uSessionID = uDAO.getUserSessionID(u);
		String encodedURL = "";
		
		if(uSessionID.equals(sessionID)){
			if(u != null){
				Address a = new Address(sHouseNo, sStreet, sSubdivision, sCity, sPostalCode, sCountry);
				AddressDAO aDAO = new AddressDAO();
				aDAO.updateAddress(u.getShipping_address_id(), a);				
				encodedURL = response.encodeRedirectURL("CheckoutConfirmServlet");
		 		request.getRequestDispatcher(encodedURL).forward(request, response);
			}	 		
		}else{
			uDAO.setUserSessionID(u, null);
			encodedURL = response.encodeRedirectURL("/index");
			response.sendRedirect(encodedURL);
		}
	}
}
