package servlets;

import database.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

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
//		int token = new SecureRandom().nextInt();
//		request.getSession().setAttribute("token", token);
//		ArrayList<String> tokens = (ArrayList<String>) getServletContext().getAttribute("tokens");
//		if(tokens == null) {
//			tokens = new ArrayList<String>();
//		}
//		synchronized(tokens) {
//			tokens.add(String.valueOf(token));
//			getServletContext().setAttribute("tokens", tokens);
//		}
//		request.getRequestDispatcher("index.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		System.out.println("HELLLO");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String token = request.getParameter("token");

		System.out.println("username: "+ username);
		System.out.println("password: "+ password);
		UserDAO dao = new UserDAO();
		User user = dao.getUser(username, password);

		if (user != null)
		{
			HttpSession session = request.getSession();
			session.setAttribute("user", user.getFirst_name());
			//setting session to expiry in 30 mins
			session.setMaxInactiveInterval(30*60);
			Cookie userName = new Cookie("user", user.getFirst_name());
			response.addCookie(userName);
			//Get the encoded URL string
			String encodedURL = response.encodeRedirectURL("index.jsp");
			response.sendRedirect(encodedURL);
			return;
		}else{

			String encodedURL = response.encodeRedirectURL("login.jsp");
			response.sendRedirect(encodedURL);
			return;
		}
	}

}
