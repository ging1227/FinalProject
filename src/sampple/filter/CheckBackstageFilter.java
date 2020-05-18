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

public class CheckBackstageFilter implements Filter {

	private static final Logger logger = Logger.getLogger(CheckBackstageFilter.class);
	
	private FilterConfig filterConfig;
	private SessionFactory sessionFactory;
	private WebApplicationContext context;

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
		ServletContext application = filterConfig.getServletContext();
		context = WebApplicationContextUtils.getWebApplicationContext(application);
		sessionFactory = (SessionFactory) context.getBean("sessionFactory");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// 轉換物件
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		HttpServletResponse httpServletResponse = (HttpServletResponse) response;
		// 獲得訪問的路徑
		String uri = httpServletRequest.getRequestURI();
		String contextPath = httpServletRequest.getContextPath();
		uri = uri.substring(contextPath.length() - 1);
		// 獲得初始化引數
		String index = filterConfig.getInitParameter("index");
		String insert = filterConfig.getInitParameter("insert");
		String update = filterConfig.getInitParameter("update");
		String delete = filterConfig.getInitParameter("delete");
		// 如果訪問路徑包含管理頁面就過濾
		if (uri.contains(index) || uri.contains(insert) 
				|| uri.contains(update) || uri.contains(delete)) {
			HttpSession session = httpServletRequest.getSession();
			Users ub = (Users) session.getAttribute("identity");
			// 確認身分物件
			if (ub != null) {
				// U_type是"Y"才放行
				if(ub.getUinfo().getUtype().equalsIgnoreCase("Y")) {
					chain.doFilter(request, response);
				} else {
					httpServletResponse.sendRedirect("index.jsp");
				}
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
					// 重新加入身分物件
					if (ub != null) {
						if(ub.getUinfo().getUtype().equalsIgnoreCase("Y")) {
							httpServletRequest.getSession().setAttribute("identity", ub);
							chain.doFilter(request, response);
						} else {
							httpServletResponse.sendRedirect("index.jsp");
						}
					} 
					// cookie逾期，導回首頁
					else {
						httpServletResponse.sendRedirect("index.jsp");
					}
				} catch (Exception e) {
					logger.error(e);
				}
			}
		} 
		// 如果不是管理頁面直接放行
		else {
			chain.doFilter(request, response);
		}
	}

	@Override
	public void destroy() {
		
	}

}
