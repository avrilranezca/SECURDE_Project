package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import log.Logger;
import model.Address;
import model.User;
import database.UserDAO;

/**
 * Servlet implementation class UserPasswordValidation
 */
@WebServlet("/CheckUsernameServlet")
public class CheckUsernameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckUsernameServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	   String userName = request.getParameter("username");
	   String status = "0";
	   
	   System.out.println("usernmw: "+ userName);
	   System.out.println("checking username...");
	   UserDAO uDAO = new UserDAO();
	   if(userName != null){
		   if( uDAO.checkIfUserNameExists(userName)==true)
			   status = "-1";
		   else
			   status = "0";
	   }

	   System.out.println("status: "+ status);
		response.setContentType("text/plain");
	    response.setCharacterEncoding("UTF-8");
	    response.getWriter().write(status);
	}
}
