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
 * Servlet implementation class EditProductServlet
 */
@WebServlet("/EditProductServlet")
public class EditProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		
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
				System.out.println("action edit : "+request.getParameter("editId"));
				System.out.println("starting to edit.....");
				
				int id = Integer.parseInt(request.getParameter("editId"));
				String name = request.getParameter("editName");
				double price = Double.valueOf(request.getParameter("editPrice"));
				String type = request.getParameter("editType");
				String description = request.getParameter("editDescription");
				
				System.out.println("starting to edit ID....." + id);
				System.out.println("starting to edit TYPE....." + type);
				ProductDAO dao = new ProductDAO();
				dao.updateProduct(new Product(id, name, description, price, type, 1));
				System.out.println("finish updating editID....." + id);

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
