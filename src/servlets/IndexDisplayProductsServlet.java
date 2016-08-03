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
        
    	
    	String search =  request.getParameter("search");
        
    	ProductDAO dao = new ProductDAO();
    	ArrayList<Product> plist;
    	System.out.println("search: "+search);
    	
    	if(!("".equals(search) || "null".equals(search))){
    		System.out.println("Searching for: "+ search);
    		plist = dao.searchProducts(search);
    		request.setAttribute("products", plist);
    		request.setAttribute("searchQuery", search);
    	}else{
    		 plist = dao.getAllProducts();
    		 request.setAttribute("products", plist);
    		 search = null;
    	}
      
    	request.setAttribute("filter", "All");
        request.setAttribute("search", search);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
