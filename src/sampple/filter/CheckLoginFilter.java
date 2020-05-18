package sampple.filter;

import java.io.IOException;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.hibernate.SessionFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import sampple.model.Users;
import sampple.model.orm.UsersDAOImpl;
import sampple.model.service.UsersService;

//@WebFilter(urlPatterns = "/Order.jsp")
public class CheckLoginFilter implements Filter {

	private static final Logger logger = Logger.getLogger(CheckLoginFilter.class);
	
	private SessionFactory sessionFactory;
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		ServletContext application = filterConfig.getServletContext();
		WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		sessionFactory = (SessionFactory) context.getBean("sessionFactory");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// 轉換物件
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		HttpServletResponse httpServletResponse = (HttpServletResponse) response;

		HttpSession session = httpServletRequest.getSession();
		Users ub = (Users) session.getAttribute("identity");
		// 有身分物件就放行
		if (ub != null) {
			chain.doFilter(request, response);
		} else {
			// 沒有則確認cookie，cookie時間是2小時，若cookie還存在則重新驗證
			String userName = "";
			String userPwd = "";
			Cookie[] cookies = httpServletRequest.getCookies();
			for (int i = 0; cookies != null && i < cookies.length; i++) {
				if ("user".equals(cookies[i].getName())) {
					String string = cookies[i].getValue();
					String[] values = string.split("&");
					userName = values[0];
					userPwd = values[1];
				}
			}
			UsersService us = new UsersService(new UsersDAOImpl(sessionFactory));
			try {
				Map<String, Object> info = us.queryUser(new Users(userName, userPwd));
				ub = (Users) info.get("uBean");
				// 重新加入身分物件並放行
				if (ub != null) {
					httpServletRequest.getSession().setAttribute("identity", ub);
					chain.doFilter(request, response);
				}
				// cookie逾期，導回登入頁面
				else {
					httpServletResponse.sendRedirect("login.jsp");
				}
			} catch (Exception e) {
				logger.error(e);
			}
		}
	}

	@Override
	public void destroy() {
		
	}

}
