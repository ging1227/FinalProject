package sampple.model.orm;

import java.util.HashMap;
import java.util.Map;

import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import sampple.model.Uinfo;
import sampple.model.Users;
import sampple.model.dao.UsersDAO;
import sampple.util.CryptUtil;

@Repository
public class UsersDAOImpl implements UsersDAO {

	private SessionFactory sessionFacotry;

	private static final Logger logger = Logger.getLogger(UsersDAOImpl.class);

	@Autowired
	public UsersDAOImpl(@Qualifier(value = "sessionFactory") SessionFactory sessionFacotry) {
		this.sessionFacotry = sessionFacotry;
	}

	private static final String HQL_QUERY_ID = "From Users WHERE EMAIL=:userName";

	@Override
	public boolean insertUser(Users user) {
		boolean status = false;

		try {
			Session session = sessionFacotry.getCurrentSession();
			session.saveOrUpdate(user);

			status = true;
		} catch (Exception e) {
			logger.error(e);
		}

		return status;
	}

	@Override
	public Map<String, Object> queryUser(Users user) {

		try {
			Map<String, Object> info = new HashMap<>();
			// 不通過
			String msg = "09";
			// 需加密
			String password = new CryptUtil().encoding(user.getPassword());
			Query<Users> query = sessionFacotry.getCurrentSession().createQuery(HQL_QUERY_ID, Users.class)
					.setParameter("userName", user.getEmail());

			// 查無此帳號
			if (query.uniqueResult() == null) {
				info.put("msg", msg);
				return info;
			}

			// 有這帳號做以下動作
			Users result = query.getSingleResult();

			// 帳號是否存在
			if (!result.getDeleteFlag().equals("Y")) {
				// 是否激活
				if (result.getStatus().equalsIgnoreCase("N")) {
					msg = "03";
				} else if (result.getPassword().equals(password)) {
					// 通過
					Users ub = new Users();
					ub.setEmail(result.getEmail());
					ub.setSysSn(result.getSysSn());

					Uinfo uinfo = new Uinfo();
					uinfo.setName(result.getUinfo().getName());
					uinfo.setUtype(result.getUinfo().getUtype());

					ub.setUinfo(uinfo);

					info.put("uBean", ub);
					msg = "01";

				} else {
					// 密碼錯誤
					msg = "02";
				}
			} else {
				// 帳號凍結
				msg = "04";
			}
			info.put("msg", msg);
			return info;
		} catch (Exception e) {
			logger.error(e);
		}
		return null;
	}

	@Override
	public void update(Users user) {
		try {
			Session session = sessionFacotry.getCurrentSession();
			Query<Users> query = session.createQuery(HQL_QUERY_ID, Users.class).setParameter("userName",
					user.getEmail());
			Users result = query.getSingleResult();

			if (result != null) {
				result.getUinfo().setName(user.getUinfo().getName());
				result.getUinfo().setBirth(user.getUinfo().getBirth());
				result.getUinfo().setTel(user.getUinfo().getTel());
				result.getUinfo().setAddr(user.getUinfo().getAddr());
				// result.getUinfo().setAdemail(user.getUinfo().getAdemail());
				session.update(result);
			}

		} catch (Exception e) {
			logger.error(e);
		}
	}

	@Override
	public boolean updateStatus(int syssn) {
		boolean status = false;

		try {
			Session session = sessionFacotry.getCurrentSession();
			Query<Users> query = session.createQuery("from Users where SYS_SN=:sys", Users.class);
			query.setParameter("sys", syssn);
			Users user = query.getSingleResult();

			user.setStatus("Y");
			session.update(user);
			status = true;

		} catch (Exception e) {
			logger.error(e);
		}
		return status;
	}

	@Override
	public boolean verifyEmail(String email) {
		boolean status = false;

		Session session = sessionFacotry.getCurrentSession();
		Query<Users> query = session.createQuery("from Users where EMAIL=:email", Users.class);
		query.setParameter("email", email);

		if (query.uniqueResult() != null) {
			status = true;
			return status;
		}

		return status;
	}

	@Override
	public Users query(String email) {
		Session session = sessionFacotry.getCurrentSession();
		Users user = new Users();
		try {
			Query<Users> query = session.createQuery("from Users where EMAIL=:email", Users.class);
			query.setParameter("email", email);
			user = query.getSingleResult();
		} catch (Exception e) {
			logger.error(e);
		}
		return user;
	}

	@Override
	public boolean updatePassword(String email, String password) {
		boolean status = false;

		try {
			Session session = sessionFacotry.getCurrentSession();
			Query<Users> query = session.createQuery("from Users where EMAIL=:email", Users.class);
			query.setParameter("email", email);
			Users user = query.getSingleResult();

			user.setPassword(new CryptUtil().encoding(password));
			session.update(user);
			status = true;

		} catch (Exception e) {
			logger.error(e);
		}
		return status;
	}

	@Override
	public void updatePicture(Users user) {
		Session session = sessionFacotry.getCurrentSession();
		Query<Users> query = session.createQuery(HQL_QUERY_ID, Users.class).setParameter("userName", user.getEmail());
		Users result = query.getSingleResult();

		result.getUinfo().setPicture(user.getUinfo().getPicture());
		session.update(result);
	}

	@Override
	public Users getUserByLine(String line) throws NoResultException, NonUniqueResultException {
		Users ub = null;
		Session session = sessionFacotry.getCurrentSession();
		String hql = "FROM Users WHERE line =:line";
		ub = (Users) session.createQuery(hql).setParameter("line", line).getSingleResult();
		return ub;
	}

	@Override
	public int addLineUser(Users user) {
		Session session = sessionFacotry.getCurrentSession();
		int pk = (int) session.save(user);
		System.out.println("pk:" + pk);
		return pk;
	}

	@Override
	public void updateDeleteFlag(String email, String deleteFlag, String utype) {
		Session session = sessionFacotry.getCurrentSession();
		Query<Users> query = session.createQuery(HQL_QUERY_ID, Users.class).setParameter("userName", email);
		Users result = query.getSingleResult();

		result.setDeleteFlag(deleteFlag);
		result.getUinfo().setUtype(utype);
		session.update(result);
	}

}
