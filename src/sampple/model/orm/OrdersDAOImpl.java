package sampple.model.orm;

import java.util.List;

import javax.persistence.TypedQuery;
import javax.transaction.Transactional;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import sampple.model.Orders;
import sampple.model.OrdersDetail;
import sampple.model.dao.OrdersDAO;

@Repository
public class OrdersDAOImpl implements OrdersDAO {

	@Autowired
	private SessionFactory sessionFactory;

	private static final Logger logger = Logger.getLogger(OrdersDAOImpl.class);

	@Autowired
	public OrdersDAOImpl(@Qualifier(value = "sessionFactory") SessionFactory sessionFacotry) {
		this.sessionFactory = sessionFacotry;
	}

	private static final String HQL_QUERY_CUSTOMER_ORDER = "From ORDERS WHERE O_SYS_SN = :sysSn";
	
	private static final String HQL_QUERY_USER_ORDER = "From Orders od, Users u WHERE u.EMAIL = :name AND od.U_SYS_SN = u.SYS_SN";

	private static final String HQL_QUERY_ALL_ORDER = "From Orders";

	@Override
	public boolean insertOrder(Orders order) {
		boolean status = false;
		try {
			Session session = sessionFactory.getCurrentSession();
			session.saveOrUpdate(order);

			status = true;
		} catch (Exception e) {

			logger.error(e);
		}
		return status;
	}

	@Transactional
	public List<Orders> userOrder(int name) {
		@SuppressWarnings("unchecked")
		TypedQuery<Orders> query = sessionFactory.getCurrentSession()
//				.createQuery("From orders od, users u WHERE u.email = :name AND od.u_sys_sn = u.sys_sn");
				.createQuery("From Orders WHERE u_sys_sn ='" + name + "'");

		return query.getResultList();
	}

//	@Override
	public List<Orders> userOrder1(String name) {
		List<Orders> result = null;
		try {
			Session session = sessionFactory.getCurrentSession();

			session.beginTransaction();
			String hql = HQL_QUERY_USER_ORDER;

			List<Orders> queryList = session.createQuery(hql).setParameter("name", name).getResultList();
			return queryList;

		} catch (Exception e) {

			logger.error(e);
		}
		return result;
	}

	@Override
	public Orders customerOrder(int sysSn) {
		Orders result = null;
		try {
			Session session = sessionFactory.getCurrentSession();
			Query<Orders> query = session.createQuery(HQL_QUERY_CUSTOMER_ORDER, Orders.class).setParameter("sysSn",
					sysSn);

			result = query.getSingleResult();
		} catch (Exception e) {
			logger.error(e);
		}
		return result;
	}

	@Override
	public boolean updateOrder(Orders order) {
		boolean status = false;

		try {
			Session session = sessionFactory.getCurrentSession();
			session.update(order);

			status = true;
		} catch (Exception e) {

			logger.error(e);
		}

		return status;
	}

	@Override
	public Long queryMax() {
		Session session = sessionFactory.getCurrentSession();
		String hql = "SELECT MAX(SYS_SN) FROM Orders";
		return (Long) session.createQuery(hql).uniqueResult();
	}

	// 以下為新增部分
	@Override
	public Object queryOrderSum(String createTime) {
		Object result = 0;
		try {
			Session session = sessionFactory.getCurrentSession();
			String hql = "SELECT sum(PRICE) FROM Orders WHERE CREATE_TIME like :createTime";
			result = session.createSQLQuery(hql).setParameter("createTime", "%" + createTime + "%").uniqueResult();
		} catch (Exception e) {
			logger.error(e);
		}

		if (result == null) {
			result = 0;
		}
		return result;
	}

	@Override
	public Long queryOrderCount(String createTime) {
		Long result = (long) 0;
		try {

			Session session = sessionFactory.getCurrentSession();
			String hql = "SELECT count(O_SYS_SN) FROM Orders WHERE CREATE_TIME like :createTime";
			result = (Long) session.createQuery(hql).setParameter("createTime", "%" + createTime + "%").uniqueResult();
		} catch (Exception e) {

			logger.error(e);
		}

		if (result == null) {
			result = (long) 0;
		}
		return result;
	}

	@Override
	public Long queryOrderPayCount() {
		Long result = (long) 0;
		try {

			Session session = sessionFactory.getCurrentSession();
			String hql = "SELECT count(O_SYS_SN) FROM Orders WHERE PAY_STATUS = :payStatus";
			result = (Long) session.createQuery(hql).setParameter("payStatus", "N").uniqueResult();
		} catch (Exception e) {

			logger.error(e);
		}

		if (result == null) {
			result = (long) 0;
		}
		return result;
	}

	@Override
	public Long queryOrderStatusCount() {
		Long result = (long) 0;

		try {
			Session session = sessionFactory.getCurrentSession();
			String hql = "SELECT count(O_SYS_SN) FROM Orders WHERE STATUS <:status";
			result = (Long) session.createQuery(hql).setParameter("status", 3).uniqueResult();
		} catch (Exception e) {

			logger.error(e);
		}

		if (result == null) {
			result = (long) 0;
		}
		return result;
	}

	@Override
	public List<OrdersDetail> queryDetail(Integer oSysSn) {
		String hql = "From OrdersDetail where orders in (select oSysSn from Orders where oSysSn = :oSysSn)";
		Session session = sessionFactory.getCurrentSession();
		List<OrdersDetail> ordersDetail = session.createQuery(hql).setParameter("oSysSn", oSysSn).getResultList();
		return ordersDetail;
	}
	
	@Override
	public List<Orders> allOrder() {
		List<Orders> result = null;
		try {
			Session session = sessionFactory.getCurrentSession();
			Query<Orders> query = session.createQuery(HQL_QUERY_ALL_ORDER, Orders.class);
			result = query.list();
		} catch (Exception e) {
			logger.error(e);
		}
		return result;
	}
}