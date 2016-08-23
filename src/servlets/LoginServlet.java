package servlets;

import database.UserDAO;
import log.Logger;
import model.AccountTypeEnum.AccountType;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Calendar;
import java.util.Date;

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
		//for displaying warning message when user wants to checkout bt yet logged in
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String token = request.getParameter("token");
		

		System.out.println("Login_username: "+ username);
		System.out.println("Login_password: "+ password);
		
		UserDAO dao = new UserDAO();
		User user = dao.getUser(username, password);
		User temp = dao.getUser(username);

		if(temp!=null && dao.isLocked(temp.getId())!=null){
			Date now = Calendar.getInstance().getTime();
			Date d = dao.isLocked(temp.getId());
			long diff = now.getTime() - d.getTime();
			long diffMinutes = diff / (60 * 1000) % 60;
			System.out.println("diff "+diffMinutes);
			if(diffMinutes>=5){
				dao.unlock(temp.getId());
//				request.getSession().setAttribute("lock", 0);
				dao.resetLogInAttempts(temp.getId());
				Logger.write(temp.getId() + "", request.getRemoteAddr(), "unlocked account");
			}
		}
		if (user != null && dao.isLocked(user.getId())==null)
		{
			String s=null;
			if(request.getSession().getAttribute("item")!=null){
				s= (String) request.getSession().getAttribute("item");
			}
			request.getSession().invalidate();
			HttpSession session = request.getSession();
			session.setAttribute("user", user.getUser_name());
			session.setAttribute( "activation-time", System.currentTimeMillis() );
			dao.setLastLogin(user.getId());
			dao.setUserSessionID(user, session.getId());
			
			if(s!=null) session.setAttribute("item", s);
			//setting session to expiry in 30 mins
						
			if(user.getAccount_type().equals(AccountType.CUSTOMER.toString())) {
				response.sendRedirect(response.encodeRedirectURL("index"));
			} else if(user.getAccount_type().equals(AccountType.ADMIN.toString())) {
				response.sendRedirect(response.encodeRedirectURL("admin"));
			} else if(user.getAccount_type().equals(AccountType.PRODUCT_MANAGER.toString())) {
				response.sendRedirect(response.encodeRedirectURL("product_manager"));
			} else if(user.getAccount_type().equals(AccountType.ACCOUNTING_MANAGER.toString())) {
				response.sendRedirect(response.encodeRedirectURL("accounting_manager"));
			}
			return;
		}else{

			if(username.equals("")||password.equals("")) 
				request.setAttribute("error", "Fill up all fields.");
			else{
				request.setAttribute("error", "Incorrect username/password!");

				if(temp!=null || (temp!=null&&dao.isLocked(temp.getId())!=null)){
					System.out.print("lck: ");System.out.println(request.getSession().getAttribute("lock"));
					int i = dao.getLogInAttempts(temp.getId());
//					request.getSession().setAttribute("lock", i+1);
					dao.incrementLogInAttempts(temp.getId());

					if(i+1>=5){
						if(dao.isLocked(temp.getId())==null){
							System.out.println("here");
							dao.lock(temp.getId());
							Logger.write(temp.getId() + "", request.getRemoteAddr(), "locked out");
							request.setAttribute("error", "Incorrect username/password! Too many failed attempts at logging in. This account has been locked for five minutes.");
						}
						else{
							System.out.println("there");
							request.setAttribute("error", "Too many failed attempts at logging in. This account has been locked for five minutes.");
						}
					} else{
						Logger.write(temp.getId() + "", request.getRemoteAddr(), "unsuccessful login");
					}
				}
			}

			String encodedURL = response.encodeRedirectURL("login.jsp");
			request.getRequestDispatcher(encodedURL).forward(request,response);
			return;
		}
	}

}
