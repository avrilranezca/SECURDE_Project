package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.PageContext;

import database.CategoryDAO;
import database.ProductDAO;
import database.UserDAO;
import model.Category;
import model.Product;
import model.User;

/**
 * Servlet implementation class DisplayProductsServlet
 */
@WebServlet("/DisplayProductsServlet")
public class DisplayProductsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DisplayProductsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String filter = "All";
		String username = (String) request.getSession().getAttribute("user");
		UserDAO  uDAO = new UserDAO();
		User u = uDAO.getUser(username);
		if(u.getPassword_permanent() == 0)
			request.setAttribute("isPermanent", false);
		else
			request.setAttribute("isPermanent", true);

		
		if(request.getParameter("filter") != null) {
			filter = request.getParameter("filter");
		}
		
		request.setAttribute("filter", filter);
		
		CategoryDAO categoryDAO = new CategoryDAO();
		List<String> categories = categoryDAO.getCategories();
		request.setAttribute("categories", categories);
		
		ProductDAO productDAO = new ProductDAO();
		List<Product> products;
		
		if("All".equals(filter)) {
			products = productDAO.getAllProducts();
		} else {
			products = productDAO.getProductOnCategory(new Category(filter));
		}
		
		
		request.setAttribute("products", products);
		
		request.getRequestDispatcher("product_manager.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
