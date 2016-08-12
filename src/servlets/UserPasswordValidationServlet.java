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
		String userName = checkUser(request);
		
		if(userName != null){
			String password = request.getParameter("password");
			
			UserDAO uDAO = new UserDAO();
			User u = uDAO.getUser(userName,password);
			User temp = uDAO.getUser(userName);
	
			if(u == null){
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
				}
			}
	 		//request.getRequestDispatcher("index.jsp").forward(request, response);
		}
	}
	
	public String checkUser(HttpServletRequest request){
  	  String userName="";
        boolean foundCookie = false;         
        if(request.getSession().getAttribute("user") != null){

            userName = (String) request.getSession().getAttribute("user");
            foundCookie=true;
        }
        Cookie[] cookies = request.getCookies();

        if(cookies !=null){
            for(int i = 0; i < cookies.length; i++) {
                Cookie c = cookies[i];
                if (c.getName().equals("user")) {
                    foundCookie = true;
                }
            }
        }
        
        if (foundCookie && userName!=null) {
      	  return userName;
        }
	        
	     return null;
	 }

}
