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
	public static final String shippingStep = "Shipping";
	public static final String billingStep = "Billing";
	public static final String confirmStep = "Confirm";
	public static final String step_key = "Step";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckoutShippingServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    
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
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 System.out.println("PASOK CHECKOUT SERVLET");
		 UserDAO uDAO = new UserDAO();
		 String userName = checkUser(request);
         if (userName!=null) {
        	 User u = uDAO.getUser(userName);
        	 Address a =  uDAO.getShippingAddress(u.getShipping_address_id());
             request.setAttribute("address", a);
        
         }else{
        	  request.setAttribute("address", null);
         }
        
 		 request.getRequestDispatcher("checkout_shipping.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String sHouseNo = request.getParameter("sHouseNo");
		String sSubdivision = request.getParameter("sSubdivision");
		String sPostalCode = request.getParameter("sPostalCode");
		String sStreet = request.getParameter("sStreet");
		String sCity = request.getParameter("sCity");
		String sCountry = request.getParameter("sCountry");
		
		String userName = checkUser(request);
		if(userName != null){
			UserDAO uDAO = new UserDAO();
			User u = uDAO.getUser(userName);
			Address a = new Address(sHouseNo, sStreet, sSubdivision, sCity, sPostalCode, sCountry);
			uDAO.updateShippingAddress(u, a);
	 		request.getRequestDispatcher("checkout_billing.jsp").forward(request, response);
		}else
	 		request.getRequestDispatcher("checkout_shipping.jsp").forward(request, response);
	}
}
