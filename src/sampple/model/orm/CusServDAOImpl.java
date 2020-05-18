package sampple.model.orm;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import sampple.model.CusServ;
import sampple.model.dao.CusServDAO;

@Repository
public class CusServDAOImpl implements CusServDAO {

	private SessionFactory sessionFacotry;

	private static final Logger logger = Logger.getLogger(CusServDAOImpl.class);

	@Autowired
	public CusServDAOImpl(@Qualifier(value = "sessionFactory") SessionFactory sessionFacotry) {
		this.sessionFacotry = sessionFacotry;
	}

	private static final String HQL_QUERY_CSERV = "From CUS_SERV WHERE C_SYS_SN = :sysSn";	
	
	@Override
	public boolean insertCService(CusServ cService) {
		boolean status = false;
		try {
			Session session = sessionFacotry.getCurrentSession();
			session.saveOrUpdate(cService);

			status = true;
		} catch (Exception e) {
			logger.error(e);
		}
		return status;
	}

	@Override
	public CusServ queryCService(int sysSn) {
		CusServ result = null;
		try {
			Session session = sessionFacotry.getCurrentSession();
			Query<CusServ> query = session.createQuery(HQL_QUERY_CSERV, CusServ.class).setParameter("sysSn", sysSn);
			
			result = query.getSingleResult();
		} catch (Exception e) {
			logger.error(e);
		}
		return result;
	}
	
	@Override
	public List<CusServ> queryAllCService() {
		List<CusServ> result = null;
		try {
			Session session = sessionFacotry.getCurrentSession();
			Query<CusServ> query = session.createQuery("From CusServ", CusServ.class);
			
			result = query.list();
		} catch (Exception e) {
			logger.error(e);
		}
		return result;
	}
	
	public Long queryMax() {
		Session session = sessionFacotry.getCurrentSession();
		String hql = "SELECT MAX(SYS_SN) FROM USERS";
		return (Long) session.createQuery(hql).uniqueResult();
	}

}