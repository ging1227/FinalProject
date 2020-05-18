package sampple.model.dao;

import java.util.List;

import sampple.model.CusServ;

public interface CusServDAO {
	
	/**
	 *  新增客服紀錄
	 *  @param Orders
	 *  @return boolean
	 *  
	 * */
	public boolean insertCService(CusServ cService);
	
	/**
	 *  查詢客服紀錄
	 *  @param sysSns
	 *  @return CusServ
	 *  
	 * */
	public CusServ queryCService(int sysSn);
	
	public Long queryMax();

	public List<CusServ> queryAllCService();
}
