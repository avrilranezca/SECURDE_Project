package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import log.Logger;
import model.User;
import database.UserDAO;

/**
 * Servlet implementation class ChangePasswordServlet
 */
@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public ChangePasswordServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
           
		   String username = (String) request.getSession().getAttribute("user");
		   String sessionID = request.getSession().getId();
		   
		   UserDAO uDAO = new UserDAO();
		   User u = uDAO.getUser(username);
		   
		   String uSessionID = uDAO.getUserSessionID(u);

		   System.out.println("pasok change password servlet");
		   if(sessionID.equals(uSessionID)){
			   
			   User temp = uDAO.getUser(username,  request.getParameter("oldpw"));
			   if(temp != null){
				   //update old password
        		   uDAO.updatePassword(u, request.getParameter("newpw"));
        		   System.out.println("Updating password success....");
 
			   }else{
				   
				   	request.setAttribute("error", "Incorrect password!");
	        	   
	   				if(temp!=null || (temp!=null && uDAO.isLocked(temp.getId())!=null)){
	   					System.out.print("lck: ");
	   					System.out.println(request.getSession().getAttribute("lock"));
	   					
	   					int i = uDAO.getLogInAttempts(temp.getId());
	   					uDAO.incrementLogInAttempts(temp.getId());

	   					if(i+1>=5){
	   						if(uDAO.isLocked(temp.getId())==null){
	   							System.out.println("here");
	   							uDAO.lock(temp.getId());
	   							Logger.write(temp.getId() + "", request.getRemoteAddr(), "locked out");
	   							request.setAttribute("error", "Incorrect password! Too many failed attempts at logging in. This account has been locked for five minutes.");
	   							uDAO.setUserSessionID(u, null);
	   						    String encodedURL = response.encodeRedirectURL("login.jsp");
	   		   			        request.getRequestDispatcher(encodedURL).forward(request,response);
	   		   			       // return;
	   						}
	   						else{
	   							System.out.println("there");
	   							request.setAttribute("error", "Too many failed attempts at logging in. This account has been locked for five minutes.");
	   							String encodedURL = response.encodeRedirectURL("login.jsp");
	   		   			        request.getRequestDispatcher(encodedURL).forward(request,response);
	   						}
	   					} else
	   						Logger.write(temp.getId() + "", request.getRemoteAddr(), "unsuccessful password validation");
	   					
	   				}
	   				// if the password is wrong set redirected page to login.jsp
	   				response.setContentType("text/plain");
				    response.setCharacterEncoding("UTF-8");
				    response.getWriter().write("-1");
				    System.out.println("password fail");
			   }
			   
		   }else{
			   uDAO.setUserSessionID(u, null);
			   String encodedURL = response.encodeRedirectURL("/index");
    		   response.sendRedirect(encodedURL);
		   }	
	}
}
