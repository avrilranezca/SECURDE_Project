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
import database.UserDAO;

/**
 * Servlet implementation class CheckoutBillingServlet
 */
@WebServlet("/CheckoutBillingServlet")
public class CheckoutBillingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckoutBillingServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 UserDAO uDAO = new UserDAO();
		 String userName = checkUser(request);
         if (userName!=null) {
        	 User u = uDAO.getUser(userName);
        	 Address a =  uDAO.getBillingAddress(u.getBilling_address_id());
             request.setAttribute("address", a);
        
         }else{
        	  request.setAttribute("address", null);
         }
        
 		 request.getRequestDispatcher("checkout_billing.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String sHouseNo = request.getParameter("bHouseNo");
		String sSubdivision = request.getParameter("bSubdivision");
		String sPostalCode = request.getParameter("bPostalCode");
		String sStreet = request.getParameter("bStreet");
		String sCity = request.getParameter("bCity");
		String sCountry = request.getParameter("bCountry");
		
		String userName = checkUser(request);
		if(userName != null){
			UserDAO uDAO = new UserDAO();
			User u = uDAO.getUser(userName);
			Address a = new Address(sHouseNo, sStreet, sSubdivision, sCity, sPostalCode, sCountry);
			uDAO.updateBillingAddress(u, a);
	 		request.getRequestDispatcher("checkout_confirm.jsp").forward(request, response);
		}else
	 		request.getRequestDispatcher("checkout_billing.jsp").forward(request, response);
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
