package servlets;

import database.ReviewDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by rissa on 8/4/2016.
 */
@WebServlet("/AddReviewServlet")
public class AddReviewServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        String username=null;
        if(cookies != null){
            for(Cookie cookie : cookies){
                if(cookie.getName().equals("user")){
                    username=cookie.getValue();
                }
            }
        }

        ReviewDAO reviewDAO = new ReviewDAO();
//        reviewDAO.addReview(new Review(username, request.getParameter("product"), request.getParameter("reviewtext"), new Date(), request.getParameter("rate")));
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}