package sampple.model;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;

public class ShoppingCart {
	
	private static final Logger logger = Logger.getLogger(ShoppingCart.class);
	
	private Map<String, OrdersDetail> cart = new LinkedHashMap<>();

	public ShoppingCart() {
	}

	public Map<String, OrdersDetail> getContent() {
		return cart;
	}

	public void addToCart(String pname, OrdersDetail oi) {
		if (oi.getQuantity() <= 0) {
			return;
		}
		// 如果客戶在伺服器端沒有此項商品的資料，則客戶第一次購買此項商品
		if (cart.get(pname) == null) {
			cart.put(pname, oi);
		} else {
			// 如果客戶在伺服器端已有此項商品的資料，則客戶『加購』此項商品
			OrdersDetail oib = cart.get(pname);
			// 加購的數量：oi.getQty()
			// 原有的數量：oib.getQty()
			oib.setQuantity(oi.getQuantity() + oib.getQuantity());
		}
	}

	public boolean modifyQty(String pname, int newQty) {
		if (cart.get(pname) != null) {
			OrdersDetail oi = cart.get(pname);
			oi.setQuantity(newQty);
			return true;
		} else {
			return false;
		}
	}

	// 刪除某項商品
	public int deleteProduct(String pname) {
		if (cart.get(pname) != null) {
			cart.remove(pname); // Map介面的remove()方法
			return 1;
		} else {
			return 0;
		}
	}

	public int getItemNumber() { // ShoppingCart.itemNumber
		return cart.size();
	}

	// 計算購物車內所有商品的合計金額(每項商品的單價*數量的總和)
	public double getSubtotal() {
		double subTotal = 0;
		Set<String> set = cart.keySet();
		for (String item : set) {
			double price = cart.get(item).getPrice();
			double discount = 1.0;
			int qty = cart.get(item).getQuantity();
			subTotal += price * discount * qty;
		}
		return subTotal;
	}

	public void listCart() {
		Set<String> set = cart.keySet();
		for (String item : set) {
			System.out.printf("ProductId=%3d,  Qty=%3d,  price=%5.2f,  discount=%6.2f\n", item, cart.get(item).getQuantity(),
					cart.get(item).getPrice(), 1.0);
		}
		logger.info("------------------");
	}
}
