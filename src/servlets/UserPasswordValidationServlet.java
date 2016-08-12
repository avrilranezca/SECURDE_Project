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
@WebServlet("/UserPasswordValidation")
public class UserPasswordValidationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserPasswordValidationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	   String userName = (String) request.getSession().getAttribute("user");
	   String sessionID = request.getSession().getId();
	   String password = request.getParameter("password");
	   
	   UserDAO uDAO = new UserDAO();
	   User u = uDAO.getUser(userName);
	   
	   String uSessionID = uDAO.getUserSessionID(u);
		
		if(uSessionID.equals(sessionID)){
			
			User temp = uDAO.getUser(userName,password);
			if(temp != null){
				String encodedURL = response.encodeRedirectURL("/index");
				response.sendRedirect(encodedURL);
			}else{
				request.setAttribute("error", "Incorrect password!");
				
				if(temp!=null || (temp!=null && uDAO.isLocked(temp.getId())!=null)){
					System.out.print("lck: ");
					System.out.println(request.getSession().getAttribute("lock"));
					
					int i = uDAO.getLogInAttempts(temp.getId());
		//					request.getSession().setAttribute("lock", i+1);
					uDAO.incrementLogInAttempts(temp.getId());
		
					if(i+1>=5){
						if(uDAO.isLocked(temp.getId())==null){
							System.out.println("here");
							uDAO.lock(temp.getId());
							Logger.write(temp.getId() + "", request.getRemoteAddr(), "locked out");
							request.setAttribute("error", "Incorrect password! Too many failed attempts at logging in. This account has been locked for five minutes.");
						}
						else{
							System.out.println("there");
							request.setAttribute("error", "Too many failed attempts at logging in. This account has been locked for five minutes.");
						}
					} else{
						Logger.write(temp.getId() + "", request.getRemoteAddr(), "unsuccessful password validation");
					}
					
					//if the password is wrong set redirected page to login
					String encodedURL = response.encodeRedirectURL("login.jsp");
					request.getRequestDispatcher(encodedURL).forward(request, response);
				}
			}
		}else{
			uDAO.setUserSessionID(u, null);
			String encodedURL = response.encodeRedirectURL("/index");
			response.sendRedirect(encodedURL);
			
		}
	}
}
