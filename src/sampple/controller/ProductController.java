package sampple.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import sampple.model.Product;
import sampple.model.service.ProductService;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@Controller
@RequestMapping("/product")
public class ProductController {

	String[] monitorlist = { "4.7", "5.5", "5.8", "6.1", "6.5", "10.2", "10.5(Air)", "12.9", "13.3", "16" };
	String[] p_typelist = { "電腦", "平板", "手機" };
	String[] cpulist = { "A13", "A12 Bionic+M12", "A11", "A10 Fusion", "A9+M9", "A8+M8", "A7(1.3GHz雙核心)+M7",
			"A6(1.3GHz雙核心)", "A5(1GHz雙核心)" };
	String[] ramlist = { "4GB LPDDR4 DRAM", "3GB LPDDR4 DRAM", "2GB LPDDR4 DRAM", "1GB LPDDR4 DRAM" };
	String[] storagelist = { "64GB", "256GB", "512GB", "1TB" };
	String[] colorlist = { "星鑽銀", "太空灰", "香檳金" };

	private static final Logger logger = Logger.getLogger(ProductController.class);

	@Autowired
	private ProductService productService;

	@Autowired
	ServletContext context;

	@RequestMapping("")
	public String productpage(HttpServletRequest request, HttpServletResponse response) {
		List<Product> listProduct = productService.list();
		request.setAttribute("listProduct", listProduct);

		return "product-list";
	}

	@RequestMapping("/blurDetail")
	public String blurProductDetail(@RequestParam(value = "p_type", required = false) String p_type,
			@RequestParam(value = "p_name", required = false) String p_name, Model model) {
		Map<String, String> bothnull = new HashMap<>();
		model.addAttribute("bothkey", bothnull);

		if (p_type.length() == 0 && p_name.length() == 0) {
			bothnull.put("null", "不可都為空");
		}
		if (bothnull.isEmpty()) {
			List<Product> list = productService.blurdetail(p_type, p_name);
			model.addAttribute("listProduct", list);
			logger.info("11111");
			return "product-list2";
		}
		return "product-list2";
	}

	@RequestMapping("/list")
	protected String productPage(HttpServletRequest request, HttpServletResponse response) {
		List<Product> listProduct = productService.list();
		request.setAttribute("listProduct", listProduct);
		return "redirect:/product";
	}

	@RequestMapping("/add")
	protected String addProductPage(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("monitorlist", monitorlist);
		request.setAttribute("p_typelist", p_typelist);
		request.setAttribute("cpulist", cpulist);
		request.setAttribute("ramlist", ramlist);
		request.setAttribute("storagelist", storagelist);
		request.setAttribute("colorlist", colorlist);
		return "product-form";
	}

	@RequestMapping("/insert")
	protected String doInsert(HttpServletRequest request, HttpServletResponse response,
			@RequestParam("files") MultipartFile[] files) throws ServletException, IOException {
		try {
			Enumeration<String> s = request.getParameterNames();
			while (s.hasMoreElements()) {
				logger.info(s.nextElement());
			}

			String p_type = request.getParameter("p_type");
			String p_name = request.getParameter("p_name");
			String monitor = request.getParameter("monitor");
			String cpu = request.getParameter("cpu");
			String ram = request.getParameter("ram");
			String storage = request.getParameter("storage");
			String des = request.getParameter("des");
			String color = request.getParameter("color");
			int price = Integer.parseInt(request.getParameter("price"));
			double discount = Double.valueOf(request.getParameter("discount"));
			String delete_flag = request.getParameter("delete_flag");

			// test create number
			int serial_number;
			String serial_year;
			String serial_type;
			String serial_seq;

			// get serial_year
			Calendar cal = Calendar.getInstance();
			int year = cal.get(Calendar.YEAR);
			serial_year = String.valueOf(year); // 组合流水号前
			logger.info(">>>>>" + serial_year);

			// get serial_type
			if (p_type.equals("電腦")) {
				serial_type = "1";
			} else if (p_type.equals("手機")) {
				serial_type = "2";
			} else if (p_type.equals("平板")) {
				serial_type = "3";
			} else {
				serial_type = "4";
			}
			logger.info(">>>>" + serial_type);

			// get serial_seq
			serial_seq = productService.query_serialseq();

			//
			if (serial_seq == null) {
				serial_number = Integer.parseInt(serial_year + serial_type + "0001");
				logger.info("//////////" + serial_number);

			} else {
				serial_number = Integer.parseInt(serial_year + serial_type + "0001") + Integer.parseInt(serial_seq);
				logger.info(">>>>>" + serial_seq);
				logger.info("changethis>>>>>" + serial_year + serial_type + "0001");
				logger.info(">>>>>>>>>>>" + serial_number);
			}

			int p_id = serial_number;

			//////////////////////////////////////////////////////////
			MultipartFile img = files[0];
			String p_img = saveFile(img, request);

			String uri = "http://localhost:8080/FinalProject/productC/Detail?p_id=" + p_id;

			Product newProduct = new Product(p_id, p_name, p_type, p_img, monitor, cpu, ram, storage, des, color, price,
					uri, discount, delete_flag);

			logger.info(newProduct.toString());

			productService.save(newProduct);

			List<Product> listProduct = productService.list();
			request.setAttribute("listproduct", listProduct);
		} catch (Exception e) {
			logger.error(e);
		}
		return "redirect:/product/list";

	}

	private String saveFile(MultipartFile uploadFile, HttpServletRequest request) throws IOException {

		String filename = null;
		String storefilename = null;

		try {
			String realPath = context.getRealPath("/WEB-INF/uploads");
			filename = realPath + File.separator + uploadFile.getOriginalFilename();
			storefilename = uploadFile.getOriginalFilename();

			File transferFile = new File(filename);
			uploadFile.transferTo(transferFile);

		} catch (Exception e) {
			logger.error(e);
		}

		return storefilename;
	}

	@RequestMapping(name = "edit", path = { "/edit" })
	protected String doEdit(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		logger.info("1");
		System.out.println(">>>>>>>>" + request.getParameter("p_id"));
		int p_id = Integer.parseInt(request.getParameter("p_id"));
		logger.info(p_id);
		Product existingProduct = productService.getProduct(p_id);
		logger.info(existingProduct.toString());

		request.setAttribute("product", existingProduct);
		request.setAttribute("p_id", p_id);
		request.setAttribute("monitorlist", monitorlist);
		request.setAttribute("p_typelist", p_typelist);
		request.setAttribute("cpulist", cpulist);
		request.setAttribute("ramlist", ramlist);
		request.setAttribute("storagelist", storagelist);
		request.setAttribute("colorlist", colorlist);
		return "product-form";

	}

	@RequestMapping(name = "update", path = { "/update" })
	protected String doupdate(HttpServletRequest request, HttpServletResponse response,
			@RequestParam("files") MultipartFile[] files) throws ServletException, IOException {

		System.out.println(">>>>>" + request.getParameter("p_id"));
		int p_id = Integer.parseInt(request.getParameter("p_id"));
		String p_type = request.getParameter("p_type");
		String p_name = request.getParameter("p_name");
		String monitor = request.getParameter("monitor");
		String cpu = request.getParameter("cpu");
		String ram = request.getParameter("ram");
		String storage = request.getParameter("storage");
		String des = request.getParameter("des");
		String color = request.getParameter("color");
		int price = Integer.parseInt(request.getParameter("price"));
		double discount = Double.valueOf(request.getParameter("discount"));
		String delete_flag = request.getParameter("delete_flag");

		MultipartFile img = files[0];
		String p_img = saveFile(img, request);

		String uri = "http://localhost:8080/FinalProject/productC/Detail?p_id=" + p_id;

		Product Product = new Product(p_id, p_name, p_type, p_img, monitor, cpu, ram, storage, des, color, price, uri,
				discount, delete_flag);

		logger.info(Product.toString());

		// 更新資料
		productService.updateProduct(Product);

		// 重新取所有資料
		List<Product> listProduct = productService.list();
		request.setAttribute("listproduct", listProduct);

		return "redirect:/product/list";

	}

	@RequestMapping("/delete")
	protected String doDelete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int p_id = Integer.parseInt(request.getParameter("p_id"));

		productService.deleteProduct(p_id);

		List<Product> listProduct = productService.list();
		request.setAttribute("listproduct", listProduct);
		return "redirect:/product/list";
	}

	@SuppressWarnings("resource")
	@RequestMapping("/getImage")
	protected void getImage(HttpServletRequest request, HttpServletResponse response) throws IOException {
		InputStream input = null;
		OutputStream output = null;
		logger.info("/getImage...........");
		String filename = request.getParameter("img");
		logger.info("/getImage..........." + filename);

		String realPath = context.getRealPath("/WEB-INF/uploads");
		File file = new File(realPath + File.separator + filename);

		input = new FileInputStream(file);
		output = response.getOutputStream();
		response.setContentType("image/jpg");
		response.setContentLength((int) file.length());
		IOUtils.copy(input, output);

	}

	// 搜尋後跳轉
	@RequestMapping(value = "/query.value")
	protected @ResponseBody String queryPage(@RequestParam("query") String query, Model model,
			HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Map<String, String> data = new HashMap<>();
		data.put("queryTxt", query);
		request.getSession().setAttribute("queryData", data);
		String path = "http://localhost:8080/FinalProject/product/query.go";
		return path;
	}

	@RequestMapping(value = "/query.go")
	protected String queryGo(Model model, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		return "query";
	}

	// 撈出搜尋結果
	@RequestMapping(value = "/query.action", method = RequestMethod.POST)
	protected void queryProduct(@RequestParam("query") String query, Model model, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try (PrintWriter out = response.getWriter();) {
			List<Product> list = productService.queryProductUrl(query);
			JSONArray json = new JSONArray();
			for (Product pBean : list) {
				JSONObject jso = new JSONObject();
				logger.info("name: " + pBean.getP_name());
				jso.put("p_img", pBean.getP_img());
				jso.put("p_name", pBean.getP_name());
				jso.put("des", pBean.getDes());
				jso.put("price", pBean.getPrice());
				jso.put("uri", pBean.getUri());
				json.put(jso);
			}

			response.getWriter().print(json);
		} catch (Exception e) {
			logger.error(e);
		}
	}
}
