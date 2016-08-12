package servlets;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import log.Logger;
import model.Address;
import model.User;
import model.AccountTypeEnum.AccountType;
import database.AddressDAO;
import database.UserDAO;

/**
 * Servlet implementation class SignUpServlet
 */
@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignUpServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("adding user information");
		
		// TODO Auto-generated method stub
		String first_name = request.getParameter("firstname");
		String last_name = request.getParameter("lastname");
		String middle_initial =  request.getParameter("middleInitial");
		String user_name = request.getParameter("username");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String account_type = User.customer; 
		String bHouseNo = request.getParameter("bHouseNo");
		String bSubdivision = request.getParameter("bSubdivision");
		String bPostalCode = request.getParameter("bPostalCode");
		String bStreet = request.getParameter("bStreet");
		String bCity = request.getParameter("bCity");
		String bCountry = request.getParameter("bCountry");
		String sHouseNo = request.getParameter("sHouseNo");
		String sSubdivision = request.getParameter("sSubdivision");
		String sPostalCode = request.getParameter("sPostalCode");
		String sStreet = request.getParameter("sStreet");
		String sCity = request.getParameter("sCity");
		String sCountry = request.getParameter("sCountry");
		int isActive = 1;
		
		//add user to db
		User u = new User(first_name, last_name, middle_initial, user_name, email, account_type, isActive);
		u.setPassword(password);
		
		UserDAO uDao = new UserDAO();
		uDao.addUser(u);
		
		//add address to db
		u = uDao.getUser(user_name, password);
		Address bAddress = new Address(bHouseNo, bStreet, bSubdivision, bCity, bPostalCode, bCountry);
		Address sAddress = new Address(sHouseNo, sStreet, sSubdivision, sCity, sPostalCode, sCountry);
		
		AddressDAO aDao = new AddressDAO();
		aDao.addAddress(bAddress);
		aDao.addAddress(sAddress);
		
		uDao.updateBillingAddress(u, bAddress);
		uDao.updateShippingAddress(u, bAddress);
		
		String encodedURL = response.encodeRedirectURL("index");
		response.sendRedirect(encodedURL);
		return;
	}

}
