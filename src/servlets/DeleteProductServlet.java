package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.ProductDAO;
import database.UserDAO;
import log.Logger;
import model.Product;
import model.User;

/**
 * Servlet implementation class DeleteProductServlet
 */
@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
    public DeleteProductServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	
		
		String userName = (String) request.getSession().getAttribute("user");
		String sessionID = request.getSession().getId();
	   
		UserDAO uDAO = new UserDAO();
		User u = uDAO.getUser(userName);
		String uSessionID = uDAO.getUserSessionID(u);
		
		String password = request.getParameter("password");
		System.out.println("password inside checkout confirm: "+ password);

		if(uSessionID.equals(sessionID)){
			
			User temp = uDAO.getUser(userName,password);
			if(temp != null){
				System.out.println("action delete : "+request.getParameter("deleteProductId"));
				System.out.println("starting to delete.....");
				int id = Integer.valueOf(request.getParameter("deleteProductId"));
				System.out.println("delete pRODUCT ID: "+ id);
				ProductDAO productDAO = new ProductDAO();
				productDAO.deleteProduct(new Product(id, null, null, 0, null, 0));
				request.getRequestDispatcher("/product_manager").forward(request, response);
			}else{
				System.out.println("malii password");
				
				if(temp!=null || (temp!=null && uDAO.isLocked(temp.getId())!=null)){
					System.out.print("lck: ");
					System.out.println(request.getSession().getAttribute("lock"));
					
					int i = uDAO.getLogInAttempts(temp.getId());
					request.getSession().setAttribute("lock", i+1);
					uDAO.incrementLogInAttempts(temp.getId());
		
					if(i+1>=5){
						if(uDAO.isLocked(temp.getId())==null){
							System.out.println("here");
							uDAO.lock(temp.getId());
							Logger.write(temp.getId() + "", request.getRemoteAddr(), "locked out");
							request.setAttribute("error", "Incorrect password! Too many failed attempts at logging in. This account has been locked for five minutes.");
							String encodedURL = response.encodeRedirectURL("login.jsp");
							request.getRequestDispatcher(encodedURL).forward(request, response);
						}
						else{
							System.out.println("there");
							request.setAttribute("error", "Too many failed attempts at logging in. This account has been locked for five minutes.");
							String encodedURL = response.encodeRedirectURL("login.jsp");
							request.getRequestDispatcher(encodedURL).forward(request, response);
						}
					} else{
						Logger.write(temp.getId() + "", request.getRemoteAddr(), "unsuccessful password validation");
					}
					
				}
				
				response.setContentType("text/plain");
			    response.setCharacterEncoding("UTF-8");
			    response.getWriter().write("-1");
			   
			}
			
		}else{
			System.out.println("mismatch session");
			uDAO.setUserSessionID(u, null);	
			String encodedURL = response.encodeRedirectURL("/index");
			response.sendRedirect(encodedURL);
		}	
		
		
		
		
	}

}
