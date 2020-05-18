package sampple.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import sampple.model.CusServ;
import sampple.model.Users;
import sampple.model.service.CusServService;
import sampple.model.service.UsersService;

@Controller
public class CustomerService {

	private String status = "0";

	private static final Logger logger = Logger.getLogger(CustomerService.class);

	private UsersService usersService;

	private CusServService cusService;

	@Autowired
	public CustomerService(UsersService usersService, CusServService cusService) {
		this.usersService = usersService;
		this.cusService = cusService;
	}

	@GetMapping("/chat")
	public void chat(HttpServletRequest request, HttpServletResponse response, Model model) {
		logger.info("status = " + status);
		String rtnMsg = "";
		if (status.equals("0")) {
			HttpSession session = request.getSession();
			Users mb = (Users) session.getAttribute("identity");
			if (mb != null) {
				status = "1";
				session.setAttribute("email", mb.getEmail());
				session.setAttribute("name", mb.getUinfo().getName());
				rtnMsg = "{\"success\":\"開啟對話\"}";
			} else {
				rtnMsg = "{\"login\":\"請先登入\"}";
			}
		} else {
			rtnMsg = "{\"fail\":\"客服忙線中\"}";
		}

		PrintWriter out = null;
		response.setContentType("application/json");
		StringBuilder jsonString = new StringBuilder();
		try {
			out = response.getWriter();
			jsonString.append(rtnMsg);
			out.print(jsonString.toString());
			out.flush();
		} catch (IOException e) {
			logger.error(e);
		}
	}

	@RequestMapping(path = "/customer")
	public String cusCreateChat(HttpServletRequest request) {
		HttpSession session = request.getSession();
		Users mb = (Users) session.getAttribute("identity");
		if (mb != null) {
			session.setAttribute("email", mb.getEmail());
			session.setAttribute("name", mb.getUinfo().getName());
		}
		return "chatroom";
	}

	@PostMapping(path = "/logout")
	public void logOut(@RequestParam("user") String email, @RequestParam("msg") String chatlog) {
		status = "0";
		try {
			CusServ csMain = new CusServ();
			csMain.setStatus("1");
			csMain.setuSysSn(usersService.query(email).getSysSn());
			csMain.setContent(chatlog);

			cusService.insert(csMain);
			
			System.out.println("insert OK!");
		} catch (Exception e) {
			logger.error(e);
		}
	}
	
}
