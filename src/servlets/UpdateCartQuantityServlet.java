package servlets;

import database.ProductDAO;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by rissa on 8/3/2016.
 */
@WebServlet("/UpdateCartQuantityServlet")
public class UpdateCartQuantityServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int ind = Integer.parseInt(request.getParameter("index"));
        int val = Integer.parseInt(request.getParameter("value"));
        JSONArray arr = new JSONArray();

        if(null != request.getSession().getAttribute("item")){
            String s = (String) request.getSession().getAttribute("item");

            try {
                arr = new JSONArray(s);
                float subtotal=0;
                if(val>0){
                    arr.getJSONObject(ind).put("quantity", val);
                    subtotal = (float) (val * (new ProductDAO()).getProductOnID(Integer.parseInt(arr.getJSONObject(ind).getString("id"))).getPrice());
                }
                else {
                    arr.remove(ind);
                    subtotal=-1;
                }

                if(arr.length()>0){
                    System.out.println("HEEEEEEEEEEEEEEEEEEERE");
                    float total=0;
                    int count =0 ;
                    boolean exist=false;
                    for (int i=0; i<arr.length(); i++){
                        JSONObject obj = arr.getJSONObject(i);
                        count+=obj.getInt("quantity");
                        total+=(obj.getInt("quantity")*(new ProductDAO()).getProductOnID(Integer.parseInt(obj.getString("id"))).getPrice());

                    }

//                JSONArray array = new JSONArray();
                    JSONObject member =  new JSONObject();
                    member.put("pName", (new ProductDAO()).getProductOnID(Integer.parseInt(arr.getJSONObject(arr.length()-1).getString("id"))).getName());
                    member.put("num", count);
                    member.put("price", (new ProductDAO()).getProductOnID(Integer.parseInt(arr.getJSONObject(arr.length()-1).getString("id"))).getPrice());
                    member.put("subtotal", subtotal);
                    member.put("totalsum", total);
//                array.put(member);

                    PrintWriter printWriter  = response.getWriter();
                    printWriter.println(member.toString());
                    printWriter.flush();

                    System.out.println("session: "+arr.toString());
                    request.getSession().setAttribute("item", arr.toString());
                }
                else{
                    request.getSession().removeAttribute("item");PrintWriter printWriter  = response.getWriter();
                    printWriter.println((new JSONObject()).toString());
                    printWriter.flush();
                }

            } catch (JSONException e) {
                e.printStackTrace();
            }
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
