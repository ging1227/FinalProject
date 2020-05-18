package sampple.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import sampple.model.Orders;
import sampple.model.OrdersDetail;
import sampple.model.dao.OrdersDAO;

@Service
public class OrdersService {

	private OrdersDAO orderDao;
	
	@Autowired
	public OrdersService(OrdersDAO orderDao) {
		this.orderDao = orderDao;
	}
	
	public boolean insert(Orders order) {
		return orderDao.insertOrder(order);
	}
	
	public List<Orders> userQuery(int name) {
		return orderDao.userOrder(name);
	}
	
	public List<Orders> allOrder(){
		return orderDao.allOrder();
	}
	
	public Orders customerQuery(int sysSn) {
		return orderDao.customerOrder(sysSn);
	}
	
	public boolean update(Orders order) {
		return orderDao.updateOrder(order);
	}
	
	//以下為新增部分
	public Object queryOrderSum(String createTime) {
		return orderDao.queryOrderSum(createTime);
	}
	
	public Long queryOrderCount(String createTime) {
		return orderDao.queryOrderCount(createTime);
	}
	
	public Long queryOrderPayCount() {
		return orderDao.queryOrderPayCount();
	}

	public Long queryOrderStatusCount() {
		return orderDao.queryOrderStatusCount();
	}
	public List<OrdersDetail>  queryDetail(Integer oSysSn) {
		return orderDao.queryDetail(oSysSn);
	}
}
