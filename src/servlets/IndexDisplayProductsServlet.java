package servlets;

import database.CategoryDAO;
import database.ProductDAO;
import log.Logger;
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

		System.out.println("here");

		String search =  request.getParameter("search");

    	ProductDAO dao = new ProductDAO();
    	ArrayList<Product> plist;
    	System.out.println("search: "+search);


		int page=1;
		if(request.getParameter("page")!=null) page = Integer.parseInt(request.getParameter("page"));
    	
    	if(search == null || "".equals(search)){
    		plist = dao.getAllProductsPagination((page-1)*16, 16);
   		 	request.setAttribute("products", plist);
   		 	search = null;
    	}else{
    		plist = dao.searchProductsPagination(search, (page-1)*16, 16);
     		request.setAttribute("products", plist);
     		request.setAttribute("searchQuery", search);
    	}
		CategoryDAO categoryDAO = new CategoryDAO();

		System.out.println("LIST: "+plist.size());

		int pages= dao.getNoOfProducts()/16;
		pages++;
		ArrayList<String> list = new ArrayList<>();
		if(pages>5){
			if(pages-page>=4) {
				request.setAttribute("ellipses", true);
				if(page==1){
					for (int i = page; i < page + 3; i++) {
						list.add(i + "");
					}
				}
				else {
					for (int i = page - 1; i < page + 2; i++) {
						list.add(i + "");
					}
				}
					list.add("..");
					list.add(pages+"");

			}
			else{
				request.setAttribute("ellipses", false);
				for (int i = pages-4; i <= pages; i++) {
					list.add(i + "");
				}
			}
		}
		else{
			request.setAttribute("ellipses", false);
			for (int i=1; i<=pages; i++){
				list.add(i+"");
			}
		}

		if(page==pages){
			request.setAttribute("nextbtn", false);
			request.setAttribute("fullnextbtn", false);
		}
		else{
			if(pages>5) request.setAttribute("fullnextbtn", true);
			request.setAttribute("nextbtn", true);
		}
		if(page==1){
			request.setAttribute("backbtn", false);
			request.setAttribute("fullbackbtn", false);
		}
		else{
			request.setAttribute("backbtn", true);
			if(pages>5) request.setAttribute("fullbackbtn", true);
		}

		request.setAttribute("max", pages);
		request.setAttribute("pages", list);
		request.setAttribute("page", page);
    	request.setAttribute("filter", "All");
        request.setAttribute("search", search);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
