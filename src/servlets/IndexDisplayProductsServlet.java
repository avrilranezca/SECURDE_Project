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
@WebServlet(name = "IndexDisplayProductsServlet")
public class IndexDisplayProductsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO dao = new ProductDAO();

        ArrayList<Product> plist = dao.getAllProducts();
        request.setAttribute("products", plist);
        request.setAttribute("filter", "All");
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
