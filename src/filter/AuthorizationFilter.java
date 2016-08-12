package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.AuthorizationMatrixDAO;
import model.User;

/**
 * Servlet Filter implementation class AuthorizationFilter
 */
@WebFilter("/AuthorizationFilter")
public class AuthorizationFilter implements Filter {

    /**
     * Default constructor. 
     */
    public AuthorizationFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here
		
		// pass the request along the filter chain
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		AuthorizationMatrixDAO authorizationDAO = new AuthorizationMatrixDAO();
		String username = (String) httpRequest.getSession().getAttribute("user");
		String uri = httpRequest.getRequestURI();
		System.out.println("USERNAME: " + username);
		System.out.println("URI: " + uri);
		
		if (uri.indexOf("SECURDE_Project") > 0){
	        chain.doFilter(request, response);
		} else if(username == null ) {
			uri = "/" + uri.split("/")[uri.split("/").length-1];
			if(authorizationDAO.isAuthorized(username, uri)) {
				System.out.println("Authorized");
				chain.doFilter(request, response);
			} else {
				System.out.println("Unauthorized");
				HttpServletResponse httpResponse = (HttpServletResponse) response;
				httpRequest.getSession().setAttribute("user", null);
				//request.getRequestDispatcher("/index").forward(request, response);
				response.getWriter().append("You are not authorized to access this page!");
			}
		} 
		
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
