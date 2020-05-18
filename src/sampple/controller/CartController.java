package sampple.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import sampple.model.OrdersDetail;
import sampple.model.ShoppingCart;
import sampple.model.service.ProductService;

@Controller
@SessionAttributes({ "ShoppingCart" })
public class CartController {

	@Autowired
	ProductService service;
	private static final Logger logger = Logger.getLogger(CartController.class);
	
	@PostMapping(value = "/addCart")
	public void addCart(@RequestParam("qty") Integer qty, Model model, ServletRequest request,
			HttpServletResponse response, HttpSession session) {
		PrintWriter out = null;
		response.setContentType("application/json");
		StringBuilder jsonString = new StringBuilder();
		StringBuilder json = new StringBuilder();
		String line = null;
		try {
			BufferedReader reader = request.getReader();
			while ((line = reader.readLine()) != null) {
				json.append(line);
			}
		} catch (Exception e) {
			logger.error(e);
		}
		JsonObject jsonObject = new JsonParser().parse(json.toString()).getAsJsonObject();

		OrdersDetail item = new OrdersDetail();
		item.setpName(jsonObject.get("pname").getAsString());
		item.setColor(jsonObject.get("color").getAsString());
		item.setCpu(jsonObject.get("cpu").getAsString());
		item.setRam(jsonObject.get("ram").getAsString());
		item.setStorage(jsonObject.get("storage").getAsString());
		item.setPrice(Integer.parseInt(jsonObject.get("price").getAsString()));
		item.setQuantity(qty);

		ShoppingCart cart = (ShoppingCart) session.getAttribute("ShoppingCart");
		if (cart == null) {
			cart = new ShoppingCart();
		}
		cart.addToCart((jsonObject.get("pname").getAsString() + jsonObject.get("color").getAsString()
				+ jsonObject.get("storage").getAsString()), item);

		try {
			out = response.getWriter();
			jsonString.append("{\"success\":\"已加入購物車\"}");
			out.print(jsonString.toString());
			out.flush();
		} catch (IOException e) {
			
		}

		model.addAttribute("ShoppingCart", cart);
	}

	// 購物車頁面
	@RequestMapping("/cartConfirm")
	public String redirectCartConfirm(Model model) {
		return "cart";
	}

	// 取消本次購買，刪除購物車所有商品
	@RequestMapping(value = "/cancel")
	public String cancelCart(Model model, SessionStatus status) {
		status.setComplete();
		return "redirect:/";
	}

	// 取消購買購物車特定商品
	@RequestMapping(value = "/cancelProduct")
	public String cancelProduct(@RequestParam("pName") String pName, Model model, HttpSession session) {
		ShoppingCart cart = (ShoppingCart) session.getAttribute("ShoppingCart");
		System.out.println("pName = " + pName);
		cart.deleteProduct(pName);
		model.addAttribute("ShoppingCart", cart);
		return "cart";
	}

	@RequestMapping(value = "/cancelProductAJAJ")
	public void cancelProductAJAJ(@RequestParam("pName") String pName, Model model, HttpSession session,
			HttpServletResponse response) {
		ShoppingCart cart = (ShoppingCart) session.getAttribute("ShoppingCart");
		cart.deleteProduct(pName);
		Double total = cart.getSubtotal();
		DecimalFormat decimalFormat = new DecimalFormat("#,###,###");
		String formatTotal = decimalFormat.format(total);
		logger.info("formatTotal=" + formatTotal);

		Integer items = cart.getItemNumber();

		PrintWriter out = null;
		response.setContentType("application/json");
		StringBuilder jsonString = new StringBuilder();
		jsonString.append("{\"total\" : " + "\"" + formatTotal + "\"" + ", \"items\" :" + items + "}");

		try {
			out = response.getWriter();
			out.print(jsonString);
			logger.info(jsonString.toString());
			logger.info("total==" + total + ",items=" + items);
			out.flush();
		} catch (IOException e) {
			logger.error(e);
		}

	}

	@RequestMapping(value = "/modifyQty")
	public void modifyQty(@RequestParam("pName") String pName, @RequestParam("newQty") Integer newQty, Model model,
			HttpSession session, HttpServletResponse response) {
		ShoppingCart cart = (ShoppingCart) session.getAttribute("ShoppingCart");
		logger.info("pId==" + pName);
		logger.info("newQty==" + newQty);

		PrintWriter out = null;
		response.setContentType("application/json");

		if (newQty == null || newQty < 0) {
			newQty = 1;
			StringBuilder jsonObject = new StringBuilder();
			jsonObject.append("{\"error\":\"請輸入數字\" ," + "\"stock\":" + newQty + "}");
			try {
				out = response.getWriter();
				out.print(jsonObject);
				logger.info(jsonObject.toString());
				logger.info("newQty==" + newQty);
				out.flush();
			} catch (IOException e) {
				logger.error(e);
			}
		} else {
			cart.modifyQty(pName, newQty);
			Double newTotal = cart.getSubtotal();
			logger.info("newTotal==" + newTotal);
			try {
				out = response.getWriter();
				out.print(newTotal);
				out.flush();
			} catch (IOException e) {
				logger.error(e);
			}
		}
	}

}
