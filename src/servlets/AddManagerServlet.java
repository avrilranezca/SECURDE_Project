package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.ProductDAO;
import database.UserDAO;
import log.Logger;
import model.AccountTypeEnum.AccountType;
import model.Product;
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
		
		String userName = (String) request.getSession().getAttribute("user");
		String sessionID = request.getSession().getId();
	   
		UserDAO uDAO = new UserDAO();
		User u = uDAO.getUser(userName);
		String uSessionID = uDAO.getUserSessionID(u);
		
		String password = request.getParameter("password");
		System.out.println("password inside checkout confirm: "+ password);

		if(uSessionID.equals(sessionID)){
			
			User temp = uDAO.getUser(userName,password);
			if(temp != null){
				String username = request.getParameter("username");
				String tempPassword = request.getParameter("temppass");
				String type = request.getParameter("type");
				
				System.out.println("temp apsword: "+tempPassword);
				
				if(AccountType.PRODUCT_MANAGER.toString().contains(type)) {
					type = AccountType.PRODUCT_MANAGER.toString();
				} else if(AccountType.ACCOUNTING_MANAGER.toString().contains(type)) {
					type = AccountType.ACCOUNTING_MANAGER.toString();
				}
				
				UserDAO userDAO = new UserDAO();
				userDAO.addUser(new User("", "", "", username, "", type, 1));
				System.out.println("finish adding user: "+username);
				//Logger.write(((User)request.getSession().getAttribute("user")).getId() + "", request.getRemoteAddr(), "added " + username + " as manager");
				request.getRequestDispatcher("/admin").forward(request, response);
			}else{
				System.out.println("malii password");
				
				if(temp!=null || (temp!=null && uDAO.isLocked(temp.getId())!=null)){
					System.out.print("lck: ");
					System.out.println(request.getSession().getAttribute("lock"));
					
					int i = uDAO.getLogInAttempts(temp.getId());
					request.getSession().setAttribute("lock", i+1);
					uDAO.incrementLogInAttempts(temp.getId());
		
					if(i+1>=5){
						if(uDAO.isLocked(temp.getId())==null){
							System.out.println("here");
							uDAO.lock(temp.getId());
							Logger.write(temp.getId() + "", request.getRemoteAddr(), "locked out");
							request.setAttribute("error", "Incorrect password! Too many failed attempts at logging in. This account has been locked for five minutes.");
							String encodedURL = response.encodeRedirectURL("login.jsp");
							request.getRequestDispatcher(encodedURL).forward(request, response);
						}
						else{
							System.out.println("there");
							request.setAttribute("error", "Too many failed attempts at logging in. This account has been locked for five minutes.");
							String encodedURL = response.encodeRedirectURL("login.jsp");
							request.getRequestDispatcher(encodedURL).forward(request, response);
						}
					} else{
						Logger.write(temp.getId() + "", request.getRemoteAddr(), "unsuccessful password validation");
					}
					
				}
				
				response.setContentType("text/plain");
			    response.setCharacterEncoding("UTF-8");
			    response.getWriter().write("-1");
			   
			}
			
		}else{
			System.out.println("mismatch session");
			uDAO.setUserSessionID(u, null);	
			String encodedURL = response.encodeRedirectURL("/index");
			response.sendRedirect(encodedURL);
		}	
	}

}
