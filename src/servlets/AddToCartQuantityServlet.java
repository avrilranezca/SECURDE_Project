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
 * Created by rissa on 8/4/2016.
 */
@WebServlet("/AddToCartQuantityServlet")
public class AddToCartQuantityServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("reached");
        String id = request.getParameter("index");
        int amt = Integer.parseInt(request.getParameter("value"));

        Cookie[] cookies = request.getCookies();
        String item = null;
        if(cookies !=null){
            for(int i = 0; i < cookies.length; i++) {
                Cookie c = cookies[i];
                if (c.getName().equals("item")) {
                    item=c.getValue();
                }
            }
        }
        JSONArray arr = new JSONArray();
        if(null != request.getSession().getAttribute("item")){
            String s = (String) request.getSession().getAttribute("item");

            try {
                arr = new JSONArray(s);

                boolean exist=false;
                for (int i=0; i<arr.length()&&!exist; i++){
                    JSONObject obj = arr.getJSONObject(i);

                    if (obj.getString("id").equals(id)) {
                        obj.put("quantity", (obj.getInt("quantity"))+amt);

                        arr.remove(i);
                        arr.put(obj);

                        exist=true;
                    }

//                    if(obj.get("quantity")==arr.getJSONObject(i).get("quantity")) System.out.println("YEY");
                }

                if(!exist){
                    JSONObject obj = new JSONObject();
                    obj.put("id", id);
                    obj.put("quantity", amt);

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
                obj.put("quantity", amt);

                arr.put(obj);
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }




        System.out.println("session: "+arr.toString());

        request.getSession().setAttribute("item", arr.toString());

        System.out.println("adding");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("reached");
        String id = request.getParameter("index");
        int amt = Integer.parseInt(request.getParameter("value"));

        Cookie[] cookies = request.getCookies();
        String item = null;
        if(cookies !=null){
            for(int i = 0; i < cookies.length; i++) {
                Cookie c = cookies[i];
                if (c.getName().equals("item")) {
                    item=c.getValue();
                }
            }
        }
        JSONArray arr = new JSONArray();
        if(null != request.getSession().getAttribute("item")){
            String s = (String) request.getSession().getAttribute("item");

            try {
                arr = new JSONArray(s);

                boolean exist=false;
                for (int i=0; i<arr.length()&&!exist; i++){
                    JSONObject obj = arr.getJSONObject(i);

                    if (obj.getString("id").equals(id)) {
                        obj.put("quantity", (obj.getInt("quantity"))+amt);

                        arr.remove(i);
                        arr.put(obj);

                        exist=true;
                    }

//                    if(obj.get("quantity")==arr.getJSONObject(i).get("quantity")) System.out.println("YEY");
                }

                if(!exist){
                    JSONObject obj = new JSONObject();
                    obj.put("id", id);
                    obj.put("quantity", amt);

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
                obj.put("quantity", amt);

                arr.put(obj);
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }




        System.out.println("session: "+arr.toString());

        request.getSession().setAttribute("item", arr.toString());

        System.out.println("adding");
    }
}
