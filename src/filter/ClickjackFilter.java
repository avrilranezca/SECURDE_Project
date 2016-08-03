package filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by rissa on 8/3/2016.
 */
@WebFilter(filterName = "ClickjackFilter")
public class ClickjackFilter implements Filter {
    private String mode = "DENY";
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletResponse res = (HttpServletResponse)response;
        //If you have Tomcat 5 or 6, there is a known bug using this code.  You must have the doFilter first:
        chain.doFilter(request, response);
        res.addHeader("X-FRAME-OPTIONS", mode );
        //Otherwise use this:
        //res.addHeader("X-FRAME-OPTIONS", mode );
        //chain.doFilter(request, response);

    }

    public void destroy() {
    }

    public void init(FilterConfig filterConfig) {
        String configMode = filterConfig.getInitParameter("mode");
        if ( configMode != null ) {
            mode = configMode;
        }
    }

}
