package sampple.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sampple.model.CusServ;
import sampple.model.dao.CusServDAO;

@Service
public class CusServService {
	
	private CusServDAO csDao;
	
	public CusServService() {
		
	}
	
	@Autowired
	public CusServService(CusServDAO csDao) {
		this.csDao = csDao;
	}
	
	/**
	 *  新增客服紀錄
	 *  @param CusServ
	 *  @return boolean
	 *  
	 * */
	public boolean insert(CusServ cService) {
		return csDao.insertCService(cService);
	}
	
	/**
	 *  查詢客服紀錄
	 *  @param int
	 *  @return CusServ
	 *  
	 * */
	public CusServ query(int sysSn) {
		return csDao.queryCService(sysSn);
	}
	
	public List<CusServ> queryAllCService() {
		return csDao.queryAllCService();
	}
}
