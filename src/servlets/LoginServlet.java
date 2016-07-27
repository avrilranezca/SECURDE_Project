package servlets;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


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
		int token = new SecureRandom().nextInt();
		request.getSession().setAttribute("token", token);
		ArrayList<String> tokens = (ArrayList<String>) getServletContext().getAttribute("tokens");
		if(tokens == null) {
			tokens = new ArrayList<String>();
		}
		synchronized(tokens) {
			tokens.add(String.valueOf(token));
			getServletContext().setAttribute("tokens", tokens);
		}
		request.getRequestDispatcher("index.jsp").forward(request, response);
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
		response.setContentType("text/plain");
		if(((ArrayList<String>) getServletContext().getAttribute("tokens")).contains(token)) {
			response.getWriter().write(token);
		} else {
			response.getWriter().write("boom punet walang token");
		}
		
		/*System.out.println("username: "+ username);
		System.out.println("password: "+ password);
		UserDAO dao = new UserDAO();
		User user = dao.getUser(username, password);
		
		System.out.println("name db:"+user.getFirst_name());

		response.setContentType("text/plain");
		if (user != null)
        {
			System.out.println("Helo pasok");
//			response.sendRedirect("index.jsp");

			response.getWriter().write(user.getFirst_name());
        }*/
	}

}
