package filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by rissa on 8/3/2016.
 */
@WebFilter(filterName = "SessionFilter")
public class SessionFilter implements Filter {
    private long maxPeriod;

    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpSession session = request.getSession( false );
        if ( session != null ) {
            if(session.getAttribute("activation-time")!=null){

                long activated = (long) session.getAttribute( "activation-time" );
                if ( System.currentTimeMillis() > ( activated + maxPeriod ) ) {
                    session.invalidate();
                }
            }
        }
        chain.doFilter(req, res);
    }

    public void init(FilterConfig config) throws ServletException {
        //Get init parameter
        if ( config.getInitParameter("max-period") == null ) {
            throw new IllegalStateException( "max-period must be provided" );
        }
        maxPeriod = new Long( config.getInitParameter("max-period") );
    }

    public void destroy() {
        //add code to release any resource
    }

}
