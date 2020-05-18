package sampple.model.orm;

import java.util.List;

import javax.persistence.TypedQuery;
import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import sampple.model.Product;
import sampple.model.dao.ProductDAO;

@Repository
public class ProductDAOImpl implements ProductDAO {

	@Autowired
	private SessionFactory sessionFactory;

	public void save(Product product) {
		sessionFactory.getCurrentSession().save(product);
	}

	@Transactional
	public List<Product> list() {
		@SuppressWarnings("unchecked")
		TypedQuery<Product> query = sessionFactory.getCurrentSession().createQuery("from Product");
		return query.getResultList();
	}

	@Transactional
	public Product getProduct(int p_id) {
		return sessionFactory.getCurrentSession().get(Product.class, p_id);
	}

	@Transactional
	public void updateProduct(Product product) {
		sessionFactory.getCurrentSession().update(product);
	}

	@Transactional
	public void deleteProduct(int p_id) {
		Product product = sessionFactory.getCurrentSession().get(Product.class, p_id);
		if (product != null) {
			sessionFactory.getCurrentSession().delete(product);
			System.out.println("product is deleted");
		}
	}

	@Transactional
	public List<Product> phoneList() {
		@SuppressWarnings("unchecked")
		TypedQuery<Product> query = sessionFactory.getCurrentSession().createQuery("from Product where p_type='手機' and delete_flag='N'");
		return query.getResultList();
	}

	@Transactional
	public List<Product> padList() {
		@SuppressWarnings("unchecked")
		TypedQuery<Product> query = sessionFactory.getCurrentSession().createQuery("from Product where p_type='平板'  and delete_flag='N'");
		return query.getResultList();
	}

	@Transactional
	public List<Product> macList() {
		@SuppressWarnings("unchecked")
		TypedQuery<Product> query = sessionFactory.getCurrentSession().createQuery("from Product where p_type='電腦'  and delete_flag='N'");
		return query.getResultList();
	}

	@Override
	@Transactional
	public List<Product> getallbyname(String p_name) {
		@SuppressWarnings("unchecked")
		TypedQuery<Product> query = sessionFactory.getCurrentSession()
				.createQuery("from Product where p_name='" + p_name + "'");
		return query.getResultList();
	}

	@Override
	@Transactional
	public List<Product> getchangeprice(String p_name, String storage) {
		@SuppressWarnings("unchecked")
		TypedQuery<Product> query = sessionFactory.getCurrentSession()
				.createQuery("from Product where (p_name='" + p_name + "')and(storage='" + storage + "')");
		return query.getResultList();
	}

	@Override
	@Transactional
	public List<Product> getchangeimg(String p_name, String color) {
		@SuppressWarnings("unchecked")
		TypedQuery<Product> query = sessionFactory.getCurrentSession()
				.createQuery("from Product where (p_name='" + p_name + "')and(color='" + color + "')");
		return query.getResultList();
	}

	@Override
	public List<Product> blurdetail(String p_type, String p_name) {
		System.out.println("p_type>>>>>" + p_type);
		System.out.println("p_name>>>>>" + p_name);
		String hql = "from Product p where p.p_type like :type and p.p_name like :name";
		TypedQuery<Product> query = sessionFactory.getCurrentSession().createQuery(hql, Product.class);
		query.setParameter("type", "%" + p_type + "%");
		query.setParameter("name", "%" + p_name + "%");
		List<Product> list = query.getResultList();
		if (list != null) {
			System.out.println("list is not null");
		} else {
			System.out.println("list is null");
		}
		return list;
	}

	@Override
	public String query_serialseq() {
		String sql = "select max(cast(substring(cast(p_id as nvarchar(30)),6,4) as int)) from Product";
		Query<?> query = sessionFactory.getCurrentSession().createSQLQuery(sql);
		if (query.uniqueResult() == null) {
			return null;
		}
		int result = (int) query.uniqueResult();
		return String.valueOf(result);
	}

	@Override
	public List<Product> queryProductUrl(String p_name) {
		System.out.println("p_name:" + p_name);
		String hqlStr = "from Product where p_name like '%" + p_name + "%'";
		Query<Product> query = sessionFactory.getCurrentSession().createQuery(hqlStr, Product.class);
		return query.list();
	}
}
