package sampple.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;

import sampple.model.Uinfo;
import sampple.model.Users;
import sampple.model.service.UsersService;
import sampple.util.CryptUtil;
import sampple.util.MailUtils;
import sampple.util.VerifyUtil;

@Controller
@SessionAttributes(names = { "identity" })
public class UserSystem {
	private UsersService usersService;

	private static final Logger logger = Logger.getLogger(UserSystem.class);

	private static final String LOGIN_PAGE = "loginSystem";
	private static final String SIGN_PAGE = "RigsterPage";
	private static final String HOME_PAGE = "index";
	private static final String UPDATE_PAGE = "updatePwdPage";
	private static final String FORGET_PAGE = "forgetPwdPage";
	private static final String UPDATE = "update";
	private static final String LOGOUT = "logout";

	@Autowired
	public UserSystem(UsersService usersService) {
		this.usersService = usersService;
	}

	// 導入登入頁面
	@GetMapping(path = "/login.return")
	public String loginReturn() {
		return LOGIN_PAGE;
	}

	// 導入註冊頁面
	@GetMapping(path = "/sign.return")
	public String signReturn() {
		return SIGN_PAGE;
	}

	// 導入忘記密碼頁面
	@GetMapping(path = "/forget.return")
	public String forgetReturn() {
		return FORGET_PAGE;
	}

	// 導入修改會員資料頁面
	@GetMapping(path = "/update.return")
	public String updateReturn() {
		return UPDATE;
	}

	// 導入主頁面
	@GetMapping(path = "/index.return")
	public String indexReturn() {
		return HOME_PAGE;
	}

	/* sign up controller */
	@PostMapping(path = "/signup")
	public String processSignUp(@RequestParam("email") String email, @RequestParam("password") String password,
			@RequestParam("name") String name, @RequestParam("id") String id, @RequestParam("addr") String addr,
			@RequestParam("gender") String gender, @RequestParam("birth") String birth, @RequestParam("tel") String tel,
			@RequestParam(defaultValue = "N", value = "ademail") String ademail, Model model)
			throws MessagingException, IOException, GeneralSecurityException {

		if ((email == null || email.length() == 0) && (password == null || password.length() == 0)) {
			if (!new VerifyUtil().chkLogin(email, password)) {
				return SIGN_PAGE;
			}
		}
		
		// 送出註冊驗證信狀態
		String type = "sign";

		// Step1. check user Input is match or not
		Users users = new Users();
		users.setEmail(email);
		users.setPassword(new CryptUtil().encoding(password));
		users.setStatus("N");
		users.setDeleteFlag("N");

		Uinfo uinfo = new Uinfo();
		uinfo.setName(name);
		uinfo.setId(id);
		uinfo.setAddr(addr);
		uinfo.setGender(gender);
		uinfo.setBirth(birth);
		uinfo.setTel(tel);
		uinfo.setAdemail(ademail);
		uinfo.setUtype("N");
		uinfo.setPicture("user_img/head.jpg");

		users.setUinfo(uinfo);
		uinfo.setUsers(users);

		// 註冊失敗導入失敗畫面，再導回首頁
		if (!usersService.insert(users)) {
			// ERROR HANDLER
			return "SignUpFailed";
		}

		// Step2. Send Verify Email to user
		String url = "<a href='http://localhost:8080/FinalProject/signup.action?sys_sn=" + users.getSysSn()
				+ "  '>按此進行作業</a>";
		try {
			MailUtils.sendMail(type, users, url);
		} catch (MessagingException e) {
			logger.error(e);
		}

		// home page
		// 註冊成功導入成功畫面，再導回首頁
		return "SignUpSuccess";
	}

	// 信箱註冊驗證信激活
	@GetMapping(path = "/signup.action")
	public String processSignUpAction(@RequestParam("sys_sn") int syssn, Model model) {
		if (!usersService.updateStatus(syssn)) {
			// ERROR HANDLER 導入啟動錯誤畫面，再導回登入頁
			return "ActionFailed";
		} else {
			// 導入啟動成功畫面，再導回登入頁
			return "ActionSuccesss";
		}

	}

	/* forgot password controller */
	@PostMapping(path = "/memorycover")
	public String processCoverPw(@RequestParam("email") String email, Model model)
			throws MessagingException, UnsupportedEncodingException, GeneralSecurityException {
		String type = "memorycover";
		// Step1. check user Input is match or not

		boolean status = usersService.verifyEmail(email);

		Map<String, String> errors = new HashMap<>();
		model.addAttribute("errors", errors);

		if (!status) {
			errors.put("no", "查無此帳號!");
			return FORGET_PAGE;
		}

		// Step2. Send Verify Email to user
		String url = "<a href='http://localhost:8080/FinalProject/updatePwdPage.controller?email=" + email
				+ "  '>按此進行作業</a>";
		Users user = usersService.query(email);

		try {
			MailUtils.sendMail(type, user, url);
		} catch (MessagingException e) {
			logger.error(e);
		}
		// 有此帳號，導入收取修改信頁面
		return "GetUpdateMail";// login page
	}

	// 忘記密碼信箱驗證信
	@GetMapping(path = "/updatePwdPage.controller")
	public String updatePwdPageController(@RequestParam("email") String email, Model model) {
		model.addAttribute("email", email);
		return UPDATE_PAGE;
	}

	// 忘記密碼頁面
	@RequestMapping(path = "/memorycover.action")
	public String processCoverPwAction(@RequestParam("password") String password, @RequestParam("email") String email,
			Model model) {
		usersService.updatePassword(email, password);

		return "UpdateSucess";
	}

	@GetMapping(path = "/check")
	public void processRepeatAction(@RequestParam("email") String email, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		logger.info("======start to check Sign UP data======");
		logger.info("User: " + email);
		PrintWriter out = response.getWriter();
		response.setContentType("text/html;charset=UTF-8");

		// 驗證Email格式
		if (new VerifyUtil().chkEmail(email)) {
			boolean status = usersService.verifyEmail(email);
			logger.info("Status: " + status);
			out.print(status);
		}
		logger.info("======check data finish======");
	}

	@PostMapping(path = "/login")
	public String processLoginSystemAction(@RequestParam("email") String email,
			@RequestParam("password") String password, Model model, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) throws IOException {
		Map<String, String> errors = new HashMap<>();
		response.setContentType("text/html;charset=UTF-8");

		model.addAttribute("errors", errors);

		// 驗證帳號、密碼格式
		if ((email == null || email.length() == 0) && (password == null || password.length() == 0)) {
			if (!new VerifyUtil().chkLogin(email, password)) {
				return LOGIN_PAGE;
			}
		}

		String msg = null;
		Map<String, Object> info = usersService.queryUser(new Users(email, password));
		if (info.get("msg") != null) {
			logger.info("msg: " + msg);
			msg = (String) info.get("msg");
			switch (msg) {
			case "09":
				errors.put("msg", "找不到帳號");
				break;
			case "04":
				errors.put("msg", "帳號已被凍結");
				break;
			case "03":
				errors.put("msg", "請至信箱收取驗證信");
				break;
			case "02":
				errors.put("msg", "密碼錯誤");
				break;
			case "01":
				// 建立身分物件存於Session
				Users ub = (Users) info.get("uBean");
				model.addAttribute("identity", ub);
				logger.info("name: " + ub.getUinfo().getName());
				// 建立cookie來儲存使用者資訊
				Cookie cookie = new Cookie("user", email + "&" + password);
				cookie.setPath("/");
				cookie.setMaxAge(1 * 60 * 60 * 2); // 二小時的有效時間
				response.addCookie(cookie);

				// 轉至首頁
				String uType = ub.getUinfo().getUtype();
				if (uType.equals("N")) {
					return HOME_PAGE;
				} else if (uType.equals("Y")) {
					redirectAttributes.addFlashAttribute("uType", uType);
					return "redirect:/back";
				}
			default:
				logger.info("Error login, email: " + email);
			}
		}

		// 若有錯誤返回登入頁面
		if (!errors.isEmpty()) {
			return LOGIN_PAGE;
		}

		return LOGIN_PAGE;
	}

	@RequestMapping(path = "/toLogin")
	public String toLogin() {
		return LOGIN_PAGE;
	}

	// 顯示基本資料頁面
	@GetMapping(path = "/update.action")
	public String processUpdateAction(HttpServletRequest request, HttpServletResponse response, Model model) {
		Users ub = (Users) request.getSession().getAttribute("identity");

		Users result = usersService.query(ub.getEmail());
		Map<String, String> data = new HashMap<>();
		model.addAttribute("data", data);
		// 取得基本資料
		data.put("nickName", result.getUinfo().getName());
		data.put("gender", result.getUinfo().getGender());
		data.put("birth", result.getUinfo().getBirth());
		data.put("phone", result.getUinfo().getTel());
		data.put("address", result.getUinfo().getAddr());
		data.put("picture", result.getUinfo().getPicture());
		
		return UPDATE;
	}

	// 修改基本資料
	@RequestMapping(path = "/updateData.action", method = RequestMethod.POST)
	public void processUpdateData(@RequestParam("name") String name, @RequestParam("birth") String birth,
			@RequestParam("tel") String tel, @RequestParam("addr") String addr, Model model,
			HttpServletResponse response, HttpServletRequest request) throws IOException {
		System.out.println("name:"+name);
		// 更新資料
		Users users = (Users) request.getSession().getAttribute("identity");

		Uinfo uinfo = new Uinfo();
		uinfo.setName(name);
		uinfo.setBirth(birth);
		uinfo.setTel(tel);
		uinfo.setAddr(addr);

		users.setUinfo(uinfo);
		uinfo.setUsers(users);

		usersService.update(users);
		//ajax
		PrintWriter out = response.getWriter();
		JSONArray js=new JSONArray();
		JSONObject jo =new JSONObject();
		jo.put("nickName", name);
		jo.put("birth", birth);
		jo.put("phone", tel);
		jo.put("address", addr);
		js.put(jo);
	
		//將JSONArray輸出到前端給QueryAllPage接收
		out.print(js);
		out.flush();
		
		out.close();
	}

	// 跳轉修改密碼頁面
	@GetMapping(path = "/updatePwd")
	public String updatePwd(HttpServletRequest request, Model model) {
		Users ub = (Users) request.getSession().getAttribute("identity");
		Users result = usersService.query(ub.getEmail());
		
		Map<String, String> data = new HashMap<>();
		model.addAttribute("data", data);
		data.put("picture", result.getUinfo().getPicture());
		
		return "updatePwd2";
	}

	// 修改密碼
	@PostMapping(path = "/updatePwd.action")
	public String updatePwdAction(@RequestParam("password") String password, HttpServletRequest request, Model model) {
		Users ub = (Users) request.getSession().getAttribute("identity");
		usersService.updatePassword(ub.getEmail(), password);
		
		
		return "UpdateSucess2";
	}

	// 上傳頭像
	@PostMapping(path = "/upload.action")
	public String processUploadAction(@RequestParam("files") MultipartFile picture, HttpServletResponse response,
			HttpServletRequest request) throws IllegalStateException, IOException {

		Users users = (Users) request.getSession().getAttribute("identity");

		// 取得檔名
		String fileName = picture.getOriginalFilename();
		// 存到資料庫的路徑名稱
		String flie = "/user_img/" + users.getEmail() + fileName;
		// 上傳至資料夾存放
		String savePath = "C:/GitHubDesktop/FinalProject/WebContent/WEB-INF/static/user_img/" + users.getEmail()
				+ fileName;
		File saveFile = new File(savePath);
		picture.transferTo(saveFile);

		// 將圖片路徑存到資料庫
		Uinfo uinfo = new Uinfo();
		uinfo.setPicture(flie);
		users.setUinfo(uinfo);
		uinfo.setUsers(users);

		usersService.updatePicture(users);

		return UPDATE;
	}

	// 登出
	@GetMapping(path = "/logout.return")
	public String processLogoutAction(HttpServletRequest request) throws IOException {
		request.getSession().invalidate();
		return LOGOUT;
	}

	// google第三方登入
	@PostMapping(path = "/googlelogin")
	public String googleLogin(@RequestParam("id_token") String idtokenstr, Model model, HttpServletResponse response,
			@RequestParam("genders") String genders, @RequestParam("residences") String residences,
			@RequestParam("birth") String birth) throws IOException {

		String gender = genders.replaceAll("\"", "");
		String addr = residences.replaceAll("\"", "");

		GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(),
				JacksonFactory.getDefaultInstance())
						.setAudience(Collections.singletonList(
								"639020830248-o9oclhac3crknk5jsqadqeaeg36c7m6e.apps.googleusercontent.com"))
						.build();
		GoogleIdToken idToken = null;

		try {
			idToken = verifier.verify(idtokenstr);
		} catch (GeneralSecurityException e) {
			logger.info("驗證時出現GeneralSecurityException異常");
		} catch (IOException e) {
			logger.info("驗證時出現IOException異常");
		}
		if (idToken != null) {
			logger.info("驗證成功.");
			Payload payload = idToken.getPayload();
			// 取得使用者資料
			String email = payload.getEmail();
			String name = (String) payload.get("name");

			// 沒有這個帳號存在才加入資料庫
			if (!usersService.verifyEmail(email)) {

				Users users = new Users();
				users.setEmail(email);
				// 給他預設密碼
				users.setPassword("A00000000");
				users.setStatus("Y");
				users.setDeleteFlag("N");

				Uinfo uinfo = new Uinfo();
				uinfo.setName(name);
				uinfo.setId("身分證未提供");
				uinfo.setAddr(addr);
				uinfo.setGender(gender);
				uinfo.setBirth(birth);
				uinfo.setTel("電話未提供");
				uinfo.setAdemail("N");
				uinfo.setUtype("N");
				uinfo.setPicture("/user_img/head.jpg");

				users.setUinfo(uinfo);
				uinfo.setUsers(users);
				usersService.insert(users);

				model.addAttribute("identity", users);
				response.setContentType("text/html;charset=UTF-8");
				try (PrintWriter out = response.getWriter();) {
					out.print(name);
					out.flush();
				} catch (Exception e) {
					logger.error(e);
				}

				return HOME_PAGE;
			}
			// 已經有此帳號
			Users users = usersService.query(email);
			model.addAttribute("identity", users);

			response.setContentType("text/html;charset=UTF-8");
			try (PrintWriter out = response.getWriter();) {
				out.print(name);
				out.flush();
			} catch (Exception e) {
				logger.error(e);
			}

			return HOME_PAGE;
		} else {
			logger.info("Invalid ID token.");
			return HOME_PAGE;
		}

	}

}
