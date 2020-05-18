package sampple.model.dao;

import java.util.List;

import sampple.model.Uinfo;

public interface UinfoDAO {
	/**
	 *  新增資訊
	 *  @param Uinfo
	 *  @return boolean
	 *  
	 * */
	public boolean insertInfo(Uinfo uinfo);
	
	/**
	 *  查詢資料
	 *  @param sysSn
	 *  @return Uinfo
	 *  
	 * */
	public Uinfo queryInfo(int sysSn);
	
	/**
	 * 	修改資料
	 *  @param Uinfo
	 *  @return boolean
	 *  
	 * */
	public boolean updateInfo(Uinfo uinfo);
	
	/**
	 * 	查詢資料(後台查詢用)
	 *  @param Uinfo
	 *  @return List Uinfo
	 *  
	 * */
	public List<Uinfo> queryAllInfo();
}
