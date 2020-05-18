package sampple.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import sampple.model.Product;
import sampple.model.dao.ProductDAO;

@Service
public class ProductService {

	@Autowired
	private ProductDAO productDao;

	@Transactional
	public void save(Product product) {
		productDao.save(product);
	}

	@Transactional(readOnly = true)
	public List<Product> list() {
		return productDao.list();
	}

	@Transactional
	public Product getProduct(int p_id) {
		return productDao.getProduct(p_id);
	}

	@Transactional
	public void updateProduct(Product product) {
		productDao.updateProduct(product);
	}

	@Transactional
	public void deleteProduct(int p_id) {
		productDao.deleteProduct(p_id);
	}

	public List<Product> phoneList() {
		return productDao.phoneList();
	}

	public List<Product> padList() {
		return productDao.padList();
	}

	public List<Product> macList() {
		return productDao.macList();
	}

	public List<Product> getallbyname(String p_name) {
		return productDao.getallbyname(p_name);
	}

	
	public List<Product> getchangeprice(String p_name, String storage) {
		return productDao.getchangeprice(p_name, storage);
	}

	public List<Product> getchangeimg(String p_name, String color) {
		return productDao.getchangeimg(p_name, color);
	}
	
	public List<Product> blurdetail(String p_type, String p_name) {
		return productDao. blurdetail(p_type,p_name);
	}

	public String query_serialseq() {
		return productDao.query_serialseq();
	}
	public List<Product> queryProductUrl(String p_name) {
		return productDao.queryProductUrl(p_name);
	}

}
