package sampple.model.orm;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import sampple.model.OrdersDetail;
import sampple.model.dao.OrdersDetailDAO;

@Repository
public class OrdersDetailDAOImpl implements OrdersDetailDAO {

	private SessionFactory sessionFacotry;

	private static final Logger logger = Logger.getLogger(OrdersDetailDAOImpl.class);

	@Autowired
	public OrdersDetailDAOImpl(@Qualifier(value = "sessionFactory") SessionFactory sessionFacotry) {
		this.sessionFacotry = sessionFacotry;
	}

	private static final String HQL_QUERY_ORDER = "From ORDERS_DETAIL WHERE P_SYS_SN = :sysSn";
	private static final String HQL_QUERY_ALL_ORDER_DETAIL = "From OrdersDetail";

	@Override
	public boolean insertODtl(List<OrdersDetail> oDtl) {
		boolean status = false;
		try {
			Session session = sessionFacotry.getCurrentSession();
			
			// 設計成逐筆加入資料庫單一訂單對應多件物品
			for (OrdersDetail obj : oDtl) {	
				session.saveOrUpdate(obj);
			}

			status = true;
		} catch (Exception e) {
			logger.error(e);
		}
		return status;
	}

	@Override
	public List<OrdersDetail> queryODtl(int sysSn) {
		List<OrdersDetail> result = null;
		try {
			Session session = sessionFacotry.getCurrentSession();
			Query<OrdersDetail> query = session.createQuery(HQL_QUERY_ORDER, OrdersDetail.class).setParameter("sysSn", sysSn);
			
			result = query.list();
		} catch (Exception e) {
			logger.error(e);
		}
		return result;
	}
	
	@Override
	public List<OrdersDetail> queryAllODtl(){
		List<OrdersDetail> result = null;
		try {
			Session session = sessionFacotry.getCurrentSession();
			Query<OrdersDetail> queryDetail = session.createQuery(HQL_QUERY_ALL_ORDER_DETAIL, OrdersDetail.class);
			
			result = queryDetail.list();
		} catch (Exception e) {
			logger.error(e);
		}
		
		return result;
	}

}