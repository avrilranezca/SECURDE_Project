package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.UserDAO;
import log.Logger;
import model.AccountTypeEnum.AccountType;
import model.User;

/**
 * Servlet implementation class AddManagerServlet
 */
@WebServlet("/AddManagerServlet")
public class AddManagerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddManagerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = request.getParameter("username");
		String tempPassword = request.getParameter("temppass");
		String type = request.getParameter("type");
		
		if(AccountType.PRODUCT_MANAGER.toString().contains(type)) {
			type = AccountType.PRODUCT_MANAGER.toString();
		} else if(AccountType.ACCOUNTING_MANAGER.toString().contains(type)) {
			type = AccountType.ACCOUNTING_MANAGER.toString();
		}
		
		UserDAO userDAO = new UserDAO();
		userDAO.addUser(new User("", "", "", username, "", type, 1));
		Logger.write(((User)request.getSession().getAttribute("user")).getId() + "", request.getRemoteAddr(), "added " + username + " as manager");
		request.getRequestDispatcher("/admin").forward(request, response);
	}

}
