package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.TransactionDAO;
import model.Sales;

/**
 * Servlet implementation class DisplayFinancialRecordsServlet
 */
@WebServlet("/DisplayFinancialRecordsServlet")
public class DisplayFinancialRecordsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DisplayFinancialRecordsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("PASOK dsplay finance manager");
		String filter = "Total";
		String subfilter = "Daily";
		
		if(request.getParameter("filter") != null) {
			filter = request.getParameter("filter");
		}
		
		if(request.getParameter("subfilter") != null) {
			subfilter = request.getParameter("subfilter");
		}
		
		TransactionDAO transactionDAO = new TransactionDAO();
		List<Sales> sales = null;
		
		if("Total".equals(filter)) {
			sales = transactionDAO.getTotalSales(subfilter);
		} else if("Category".equals(filter)) {
			sales = transactionDAO.getSalesPerCategory();
		} else if("Product".equals(filter)) {
			sales = transactionDAO.getSalesPerProduct();
		}
		
		double total = 0;
		for(Sales s : sales) {
			total += s.getTotal_sales();
		}
		
		request.setAttribute("filter", filter);
		request.setAttribute("subfilter", subfilter);
		request.setAttribute("sales", sales);
		request.setAttribute("total", total);
		
		request.getRequestDispatcher("accounting_manager.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
