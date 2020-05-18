package sampple.model.dao;

import java.util.List;

import sampple.model.OrdersDetail;

public interface OrdersDetailDAO {	
	
	public boolean insertODtl(List<OrdersDetail> oDtl);
		
	public List<OrdersDetail> queryODtl(int sysSn);
	
	public List<OrdersDetail> queryAllODtl();

}
