package sampple.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.log4j.Logger;
import org.hibernate.SessionFactory;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class OpenSessionViewFilter implements Filter {

	private SessionFactory sessionFactory;
	private WebApplicationContext context;
	
	private static final Logger logger = Logger.getLogger(OpenSessionViewFilter.class);

	@Override
	public void init(FilterConfig config) throws ServletException {
		ServletContext application = config.getServletContext();
		context = WebApplicationContextUtils.getWebApplicationContext(application);
		sessionFactory = (SessionFactory) context.getBean("sessionFactory");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		try {
			sessionFactory.getCurrentSession().beginTransaction();
			chain.doFilter(request, response);
			sessionFactory.getCurrentSession().getTransaction().commit();
		} catch (Exception e) {
			sessionFactory.getCurrentSession().getTransaction().rollback();
			logger.error(e);
			chain.doFilter(request, response);
		} 
	}

	@Override
	public void destroy() {
		((ConfigurableApplicationContext) context).close();
	}

}
