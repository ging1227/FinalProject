package sampple.model.dao;

import java.util.List;

import sampple.model.Orders;
import sampple.model.OrdersDetail;

public interface OrdersDAO {
	
	public boolean insertOrder(Orders order);
	
	public List<Orders> userOrder(int name);
	
	public List<Orders> allOrder();
	
	public Orders customerOrder(int sysSn);
	
	public boolean updateOrder(Orders order);
	
	public Long queryMax();
	//以下為新增部分
	public Object queryOrderSum(String createTime);
	
	public Long queryOrderCount(String createTime);

	public Long queryOrderPayCount();

	public Long queryOrderStatusCount();

	public List<OrdersDetail> queryDetail(Integer oSysSn);
	
}
