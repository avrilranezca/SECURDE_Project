package servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by rissa on 8/1/2016.
 */
@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("itemID").split("-")[1];
//        System.out.println(request.getSession().getAttribute("user"));

        Cookie[] cookies = request.getCookies();

        String username=null;
        if(cookies !=null){
            for(int i = 0; i < cookies.length; i++) {
                Cookie c = cookies[i];
                if (c.getName().equals("user")) {
                    username=c.getValue();
                }
            }
        }

        if(request.getSession().getAttribute("user")!=null && username!=null){
            Cookie item = new Cookie("item",id );
            response.addCookie(item);
        }
        else{
            request.getSession().invalidate();
            response.sendRedirect("login.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
