package sampple.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sampple.model.OrdersDetail;
import sampple.model.dao.OrdersDetailDAO;

@Service
public class OrdersDetailService {
	
	private OrdersDetailDAO oDtlDao;
	
	@Autowired
	public OrdersDetailService(OrdersDetailDAO oDtlDao) {
		this.oDtlDao = oDtlDao;
	}
	
	/**
	 *  新增訂單說明
	 *  @param List<OrdersDetail>
	 *  @return boolean
	 *  
	 * */
	public boolean insert(List<OrdersDetail> oDtl) {
		return oDtlDao.insertODtl(oDtl);
	}
	
	/**
	 *  查詢訂單說明
	 *  @param int
	 *  @return List<OrdersDetail>
	 *  
	 * */
	public List<OrdersDetail> query(int sysSn) {
		return oDtlDao.queryODtl(sysSn);
	}
	

	public List<OrdersDetail> queryAllODtl(){
		return oDtlDao.queryAllODtl();		
	}
}
