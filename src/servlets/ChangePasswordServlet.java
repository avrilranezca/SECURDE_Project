package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.User;
import database.UserDAO;

/**
 * Servlet implementation class ChangePasswordServlet
 */
@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePasswordServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		   Cookie[] cookies = request.getCookies();
           String username = "";
           
           if(cookies !=null){
               for(int i = 0; i < cookies.length; i++) {
                   Cookie c = cookies[i];
                   if (c.getName().equals("user")) {
                      username =  c.getValue();
                      System.out.println("---Change password----\n Cookie username: "+username);
                   }
               }
           }
           
           if(!"".equals(username)){
        	   //in progress not yet final
        	   //verify if this is correct
        	   HttpSession session = request.getSession();
        	   String sessionUser =  (String) session.getAttribute("user");
        	   
        	   UserDAO uDAO = new UserDAO();
        	   User user = uDAO.getUser(username, request.getParameter("oldpw"));
        	   
        	   if(user != null && uDAO.getUserSessionID(user) != ""){
        		  //update old password
        		   uDAO.updatePassword(user, request.getParameter("newpw"));
        		   System.out.println("Updating password success....");
        		   String encodedURL = response.encodeRedirectURL("index.jsp");
//          		response.sendRedirect(encodedURL)
        		   request.getRequestDispatcher(encodedURL).forward(request,response);
        	   }
           }else{
        	   request.setAttribute("error", "Incorrect password!");
        	   String encodedURL = response.encodeRedirectURL("changePassword.jsp");
//       		response.sendRedirect(encodedURL)
        	   request.getRequestDispatcher(encodedURL).forward(request,response);
        	   return;
           }
		
	}

}
