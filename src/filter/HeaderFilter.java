package filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by rissa on 8/3/2016.
 */
@WebFilter(filterName = "HeaderFilter")
public class HeaderFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletResponse res = (HttpServletResponse)response;
        res.addHeader("X-FRAME-OPTIONS", "DENY");
        res.addHeader("Strict-Transport-Security", "max-age=31536000 ; includeSubDomains");
        res.addHeader("X-XSS-Protection", "1; mode=block");
        res.addHeader("X-Content-Type-Options", "nosniff");
        res.addHeader("Content-Security-Policy", "unsafe-inline 'unsafe-eval'; connect-src 'self'; img-src 'self'; object-src 'self'; media-src 'self';");
        chain.doFilter(request, response);
    }

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}
}
