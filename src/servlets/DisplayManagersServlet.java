package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.UserDAO;
import model.User;

/**
 * Servlet implementation class DisplayManagersServlet
 */
@WebServlet("/DisplayManagersServlet")
public class DisplayManagersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DisplayManagersServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String filter = request.getParameter("filter");
		
		if(filter == null) {
			filter = "All";
		}
		
		UserDAO userDAO = new UserDAO();
		List<User> managers;
		
		if("Product".equals(filter)) {
			managers = userDAO.getAllProductManagers();
		} else if("Accounting".equals(filter)) {
			managers = userDAO.getAllAccountingManagers();
		} else {
			managers = userDAO.getAllUsers();
		}
		
		request.setAttribute("filter", filter);
		request.setAttribute("managers", managers);
		request.getRequestDispatcher("index_admin.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
