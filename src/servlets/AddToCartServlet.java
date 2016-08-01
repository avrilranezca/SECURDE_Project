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


//        System.out.println("yes!");
//        System.out.println(request.getSession().getAttribute("user"));

        Cookie[] cookies = request.getCookies();

//        String username=null;
        String item = null;
        if(cookies !=null){
            for(int i = 0; i < cookies.length; i++) {
                Cookie c = cookies[i];
//                if (c.getName().equals("user")) {
//                    username=c.getValue();
//                }
//                else
                if (c.getName().equals("item")) {
                    item=c.getValue();
                }
            }
        }

//        System.out.println("woot");

//        if(request.getSession().getAttribute("user")!=null && username!=null){
//            System.out.println("here");
            Cookie cookie;
            if(item==null) cookie= new Cookie("item", id );
            else cookie=new Cookie("item", item+","+id);
//            item = new Cookie()
//            System.out.println(cookie.getValue());
            response.addCookie(cookie);
//        }
//        else{
//            System.out.println("huhhh");
//            request.getSession().invalidate();
//            response.sendRedirect("login.jsp");
//        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
