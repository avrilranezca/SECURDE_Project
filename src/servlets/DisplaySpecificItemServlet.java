package servlets;

import database.ProductDAO;
import database.ReviewDAO;
import model.Product;
import model.Review;

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
@WebServlet("/DisplaySpecificItemServlet")
public class DisplaySpecificItemServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("fu "+request.getParameter("itemID"));
        String id = request.getParameter("itemID").split("-")[1];
        System.out.println(id);

        ProductDAO dao = new ProductDAO();
        ReviewDAO reviewDAO = new ReviewDAO();

        Product prod = dao.getProductOnID(Integer.parseInt(id));
        ArrayList<Review> reviews = reviewDAO.getReviewByProduct(prod);

        request.setAttribute("product", prod);
        request.setAttribute("productID", prod.getId());
        request.setAttribute("reviews", reviews);
        request.getRequestDispatcher("view-product.jsp").forward(request, response);
    }
}
