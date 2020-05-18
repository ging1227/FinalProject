package sampple.model.service;

import java.util.Map;

import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import sampple.model.Users;
import sampple.model.dao.UsersDAO;


@Service
public class UsersService {
private UsersDAO usersDao;
	
	public UsersService() {
	}

	@Autowired
	public UsersService(UsersDAO usersDao) {
		this.usersDao = usersDao;
	}
	
	/**
	 *  註冊帳號
	 *  @param Users
	 *  @return boolean
	 *  
	 * */
	public boolean insert(Users user) {
		return usersDao.insertUser(user);
	}
	
	/**
	 *  帳號登入
	 *  @param Users
	 *  @return Map<String, Object>
	 *  
	 * */
	public Map<String, Object> queryUser(Users user) {
		return usersDao.queryUser(user);
	}
	
	/**
	 * 	修改資料
	 *  @param Users
	 *  
	 * */
	public void update(Users user) {
		usersDao.update(user);
	}
	
	/**
	 * 	激活帳號
	 *  @param int
	 *  @return boolean
	 *  
	 * */
	public boolean updateStatus(int syssn) {
		return usersDao.updateStatus(syssn);
	}
	
	/**
	 * 	驗證使用者所輸入的帳號(EMAIL)是否存在
	 *  @param String
	 *  @return boolean
	 *  
	 * */
	public boolean verifyEmail(String email) {
		return usersDao.verifyEmail(email);
	}
	
	/**
	 * 	顯示資料, 確認信箱
	 *  @param String
	 *  @return boolean
	 *  
	 * */
	public Users query(String email){
		return usersDao.query(email);
	}
	
	/**
	 * 	修改密碼
	 *  @param String
	 *  @param String
	 *  @return boolean
	 *  
	 * */
	public boolean updatePassword(String email, String password) {
		
		return usersDao.updatePassword(email, password);
	}
	
	/**
	 *  修改大頭貼
	 *  @param Users
	 *  
	 * */
	public void updatePicture(Users user) {
		usersDao.updatePicture(user);	
	}
	
	/**
	 * 取得Line使用者
	 * 
	 * @param String
	 * @return Users
	 * 
	 */
	@Transactional
	public Users getUserByLine(String line) throws NoResultException, NonUniqueResultException {
		return usersDao.getUserByLine(line);
	}
	
	/**
	 * 新增Line使用者
	 * 
	 * @param String
	 * @return Users
	 * 
	 */
	@Transactional
	public int addLineUser(Users user) {
		return usersDao.addLineUser(user);
	}
	
	
	/**
	 * 修改使用者狀態(後台)
	 * 
	 * @param String
	 * @param String
	 * @param String
	 * @return void
	 * 
	 */
	public void updateDeleteFlag(String email, String deleteFlag, String utype) {
		usersDao.updateDeleteFlag(email, deleteFlag, utype);
	}

}
