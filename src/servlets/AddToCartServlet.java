package servlets;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

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


        JSONArray arr = new JSONArray();
        if(null != request.getSession().getAttribute("item")){
            String s = (String) request.getSession().getAttribute("item");

            try {
                arr = new JSONArray(s);

                boolean exist=false;
                for (int i=0; i<arr.length()&&!exist; i++){
                    JSONObject obj = arr.getJSONObject(i);

                    if (obj.getString("id").equals(id)) {
                        obj.put("quantity", (obj.getInt("quantity"))+1);
                        exist=true;
                    }

                    arr.remove(i);

                    arr.put(obj);

//                    if(obj.get("quantity")==arr.getJSONObject(i).get("quantity")) System.out.println("YEY");
                }

                if(!exist){
                    JSONObject obj = new JSONObject();
                    obj.put("id", id);
                    obj.put("quantity", 1);

                    arr.put(obj);
                }
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
        else{
            JSONObject obj = new JSONObject();

            try {
                obj.put("id", id);
                obj.put("quantity", 1);

                arr.put(obj);
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }




        System.out.println("session: "+arr.toString());
            request.getSession().setAttribute("item", arr.toString());
//            Cookie cookie;
//            if(item==null) cookie= new Cookie("item", id );
//            else cookie=new Cookie("item", item+","+id);
//            item = new Cookie()
//            System.out.println(cookie.getValue());
//            response.addCookie(cookie);
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
