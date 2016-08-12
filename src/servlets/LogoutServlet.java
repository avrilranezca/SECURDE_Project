package servlets;

import database.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Created by rissa on 8/3/2016.
 */
@WebServlet( "/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        Cookie[] cookies = request.getCookies();
        if(cookies != null){
            for(Cookie cookie : cookies){
                if(cookie.getName().equals("JSESSIONID")){
                    System.out.println("JSESSIONID="+cookie.getValue());
                }
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }
        }
        
        
        //invalidate the session if exists
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("user");
        UserDAO uDAO = new UserDAO();
        User u = uDAO.getUser(username);
        uDAO.setUserSessionID(u, null);
        
        System.out.println("User="+username);
        if(session != null)
            session.invalidate();
        
        //no encoding because we have invalidated the session
        response.sendRedirect("login.jsp");
    }

}
