package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;




import model.User;
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
		System.out.println("Sign up");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String first_name = request.getParameter("firstname");
		String last_name = request.getParameter("lastname");
		String middle_initial =  request.getParameter("middleInitial");
		String user_name = request.getParameter("username");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String account_type = User.customer; 
		int isActive = 1;
		
		
		User u = new User(first_name, last_name, middle_initial, user_name, email, account_type, isActive);
		u.setPassword(password);
		
		UserDAO uDao = new UserDAO();
		uDao.addUser(u);
		
		
	
	}

}
