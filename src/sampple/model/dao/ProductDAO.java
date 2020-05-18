package sampple.model.dao;

import java.util.List;

import sampple.model.Product;

public interface ProductDAO {
	void save(Product product);

	List<Product> list();

	List<Product> phoneList();

	Product getProduct(int p_id);

	void updateProduct(Product product);

	void deleteProduct(int p_id);

	List<Product> padList();

	List<Product> macList();

	List<Product> getallbyname(String p_name);

	List<Product> getchangeimg(String p_name, String color);

	List<Product> getchangeprice(String p_name, String storage);
	
	List<Product> blurdetail(String p_type, String p_name);
	String query_serialseq();
	
	List<Product> queryProductUrl(String p_name);
}
