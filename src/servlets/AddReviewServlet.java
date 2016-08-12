package servlets;

import database.ReviewDAO;
import database.UserDAO;
import model.Review;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Date;

/**
 * Created by rissa on 8/4/2016.
 */
@WebServlet("/AddReviewServlet")
public class AddReviewServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	String username = (String) request.getSession().getAttribute("user");
    	String sessionID = request.getSession().getId();
    	
    	UserDAO uDAO = new UserDAO();
    	User u = uDAO.getUser(username);
    	String uSessionID = uDAO.getUserSessionID(u);
    	
    	if(uSessionID.equals(sessionID)){
            ReviewDAO reviewDAO = new ReviewDAO();
            reviewDAO.addReview(new Review(username, Integer.parseInt((String) request.getParameter("product")), request.getParameter("reviewtext"), new Date(), Integer.parseInt((String)request.getParameter("rate"))));
    	}else{
    		uDAO.setUserSessionID(u, null);
    		response.sendRedirect("/index");
    	}

    }
}
