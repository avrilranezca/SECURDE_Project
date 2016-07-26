package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.UserDAO;
import model.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
<<<<<<< HEAD
=======

//		response.getWriter().append("Served at: ").append(request.getContextPath());
>>>>>>> master
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		System.out.println("HELLLO");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		System.out.println("username: "+ username);
		System.out.println("password: "+ password);
		UserDAO dao = new UserDAO();
		User user = dao.getUser(username, password);
		
		if (user != null)
        {			
			HttpSession session = request.getSession();
			session.setAttribute("user", user);
			//setting session to expiry in 30 mins
			session.setMaxInactiveInterval(30*60);
			
			Cookie userName = new Cookie("user", user.getUser_name());
			userName.setMaxAge(30*60);
			response.addCookie(userName);
			
			response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("True");
        }
	}

}
