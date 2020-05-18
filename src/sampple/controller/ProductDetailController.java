package sampple.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import sampple.model.Product;
import sampple.model.service.ProductService;


@CrossOrigin(origins = "*", allowedHeaders = "*")
@Controller
@RequestMapping("/productC")
public class ProductDetailController {
	String[] storagelist = { "64GB", "256GB", "512GB" };
	String[] colorlist = { "星鑽銀", "太空灰", "香檳金" };
	
	private static final Logger logger = Logger.getLogger(ProductDetailController.class);
	
	@Autowired
	ServletContext context;

	@Autowired
	private ProductService productService;

	@RequestMapping("")
	public String ProductClient() {
		return "redirect:/productC/phone";
	}

	@RequestMapping("/phone")
	public String ProductXPhone(HttpServletRequest request, HttpServletResponse response) {
		logger.info("--------/phone-----------");
		List<Product> rsproduct = new ArrayList<Product>();
		List<Product> listProduct = productService.phoneList();
		if (listProduct != null && listProduct.size() > 0) {
			rsproduct.add(listProduct.get(0));
			for (int i = 0; i < listProduct.size() - 1; i++) {
				if (listProduct.get(i).getP_name().equals(listProduct.get(i + 1).getP_name())) {
					continue;
				}
				rsproduct.add(listProduct.get(i + 1));
			}
		}

		logger.info("list: " + rsproduct);
		request.setAttribute("listProduct", rsproduct);

		return "product-product";
	}

	@RequestMapping("/pad")
	public String ProductXPad(HttpServletRequest request, HttpServletResponse response) {
		logger.info("--------/pad-----------");
		List<Product> rsproduct = new ArrayList<Product>();
		List<Product> listProduct = productService.padList();
		if (listProduct != null && listProduct.size() > 0) {
			rsproduct.add(listProduct.get(0));
			for (int i = 0; i < listProduct.size() - 1; i++) {
				if (listProduct.get(i).getP_name().equals(listProduct.get(i + 1).getP_name())) {
					continue;
				}
				rsproduct.add(listProduct.get(i + 1));
			}
		}
		logger.info("list: " + rsproduct);
		request.setAttribute("listProduct", rsproduct);
		return "product-product";
	}

	@RequestMapping("/mac")
	public String ProductXMac(HttpServletRequest request, HttpServletResponse response) {
		logger.info("--------/mac-----------");
		List<Product> rsproduct = new ArrayList<Product>();
		List<Product> listProduct = productService.macList();
		if (listProduct != null && listProduct.size() > 0) {
			rsproduct.add(listProduct.get(0));
			for (int i = 0; i < listProduct.size() - 1; i++) {
				if (listProduct.get(i).getP_name().equals(listProduct.get(i + 1).getP_name())) {
					continue;
				}
				rsproduct.add(listProduct.get(i + 1));
			}
		}

		logger.info("list: " + rsproduct);
		request.setAttribute("listProduct", rsproduct);
		return "product-product";
	}

	@RequestMapping("/Detail")
	public String ProductDetail(HttpServletRequest request, HttpServletResponse response) {

		int p_id = Integer.parseInt(request.getParameter("p_id"));
		Product detail = productService.getProduct(p_id);

		request.setAttribute("img", detail.getP_img());
		request.setAttribute("p_name", detail.getP_name());
		request.setAttribute("price", detail.getPrice());
		request.setAttribute("color", detail.getColor());
		request.setAttribute("cpu", detail.getCpu());
		request.setAttribute("ram", detail.getRam());
		request.setAttribute("des", detail.getDes());
		request.setAttribute("storage", detail.getStorage());
		request.setAttribute("storagelist", storagelist);
		request.setAttribute("colorlist", colorlist);
		return "product-detail";
	}

	@RequestMapping("/changeprice")
	@ResponseBody
	public String changeprice(HttpServletRequest request, HttpServletResponse response) {

		String p_name = request.getParameter("p_name");
		String storage = request.getParameter("storage");

		JSONObject jo = new JSONObject();

		List<Product> list = productService.getchangeprice(p_name, storage);

		logger.info(list);

		int price = 0;
		for (Product p : list) {
			price = p.getPrice();
			logger.info(price);
			break;
		}
		jo.put("price", price);

		return jo.toString();
	}

	@RequestMapping("/changeimg")
	@ResponseBody
	public String changeimg(HttpServletRequest request, HttpServletResponse response) {

		String p_name = request.getParameter("p_name");
		String color = request.getParameter("color");
		


		JSONObject jo = new JSONObject();
		List<Product> list = productService.getchangeimg(p_name, color);

		logger.info(list);

		String p_img = "";
		for (Product p : list) {
			p_img = p.getP_img();
			break;
		}
		jo.put("p_img", p_img);

		return jo.toString();


	}

	@RequestMapping("/cart")
	public String GotoCart() {
		return "cart";
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
}