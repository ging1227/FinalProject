package sampple.model.dao;

import java.util.Map;

import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;

import sampple.model.Users;

public interface UsersDAO {
	/**
	 * 註冊帳號
	 * 
	 * @param Users
	 * @return boolean
	 * 
	 */
	public boolean insertUser(Users user);

	/**
	 * 帳號登入
	 * 
	 * @param Users
	 * @return Map<String, Object>
	 * 
	 */
	public Map<String, Object> queryUser(Users user);

	/**
	 * 修改資料
	 * 
	 * @param Users
	 * 
	 */
	public void update(Users user);
	
	/**
	 * 激活帳號
	 * 
	 * @param int
	 * @return boolean
	 * 
	 */
	public boolean updateStatus(int syssn);
	
	/**
	 * 驗證郵箱
	 * 
	 * @param String
	 * @return boolean
	 * 
	 */
	public boolean verifyEmail(String email);
	
	/**
	 * 顯示資料
	 * 
	 * @param String
	 * @return Users
	 * 
	 */
	public Users query(String email);
	
	/**
	 * 顯示資料
	 * 
	 * @param String
	 * @param String
	 * @return boolean
	 * 
	 */
	public boolean updatePassword(String email, String password);
	
	/**
	 * 修改使用者頭像
	 * 
	 * @param Users
	 * 
	 */
	public void updatePicture(Users user);
		
	/**
	 * 取得Line使用者
	 * 
	 * @param String
	 * @return Users
	 * 
	 */
	public Users getUserByLine(String line) throws NoResultException, NonUniqueResultException;

	/**
	 * 新增Line使用者
	 * 
	 * @param Users
	 * @return int
	 * 
	 */
	public int addLineUser(Users user);
	
	
	/**
	 * 修改使用者狀態(後台)
	 * 
	 * @param String
	 * @param String
	 * @param String
	 * @return void
	 * 
	 */
	public void updateDeleteFlag(String email, String deleteFlag, String utype);
}
