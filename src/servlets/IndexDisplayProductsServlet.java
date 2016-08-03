package servlets;

import database.ProductDAO;
import model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

/**
 * Created by rissa on 8/1/2016.
 */
@WebServlet("/IndexDisplayProductsServlet")
public class IndexDisplayProductsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	String search[] =  request.getParameter("isSearch").toString().split("_");
        
    	ProductDAO dao = new ProductDAO();
    	ArrayList<Product> plist;
    	System.out.println("isSearch: "+search[0]);
    	
    	if("false".equals(search[0])){
    		 plist = dao.getAllProducts();
    		 request.setAttribute("products", plist);
    	}else if("true".equals(search[0])){
    		//String searchQuery = request.getParameter("searchQuery");
    		System.out.println("Searching for: "+ search[1]);
    		plist = dao.searchProducts(search[1]);
    		request.setAttribute("products", plist);
    		request.setAttribute("searchQuery", search[1]);
    	}
      
    	request.setAttribute("filter", "All");
        request.setAttribute("isSearch", search[0]);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
