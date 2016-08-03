package servlets;

import database.ProductDAO;
import database.UserDAO;
import model.Product;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;

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
			request.getSession().invalidate();
			HttpSession session = request.getSession();
			session.setAttribute("user", user.getUser_name());
			session.setAttribute( "activation-time", System.currentTimeMillis() );
			//setting session to expiry in 30 mins

			Cookie userName = new Cookie("user", user.getUser_name());
			response.addCookie(userName);
			//Get the encoded URL string

			ProductDAO dao2 = new ProductDAO();

			ArrayList<Product> plist = dao2.getAllProducts();
			request.setAttribute("products", plist);
			request.setAttribute("filter", "All");
			String encodedURL = response.encodeRedirectURL("index.jsp");
			request.getRequestDispatcher(encodedURL).forward(request, response);
			return;
		}else{

			if(username.equals("")||password.equals("")) request.setAttribute("error", "Fill up all fields.");
				else request.setAttribute("error", "Incorrect username/password!");
			String encodedURL = response.encodeRedirectURL("login.jsp");
//			response.sendRedirect(encodedURL);
			request.getRequestDispatcher(encodedURL).forward(request,response);
			return;
		}
	}

}
