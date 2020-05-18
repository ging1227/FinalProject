package sampple.model;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

@Entity
@Table(name = "orders")
@Component
public class Orders {

	private int oSysSn;
	private int uSysSn;
	private int status;
	private int price;
	private String consignee;
	private String addr;
	private String pay;
	private String payStatus;
	private String createTime;
	private String updateTime;
	private Set<OrdersDetail> ordersDetail;

	public Orders() {
	}

	public Orders(int oSysSn, int uSysSn, int status, int price, String consignee, String addr, String pay,
			String payStatus, String createTime, String updateTime) {
		this.oSysSn = oSysSn;
		this.uSysSn = uSysSn;
		this.status = status;
		this.price = price;
		this.consignee = consignee;
		this.addr = addr;
		this.pay = pay;
		this.payStatus = payStatus;
		this.createTime = createTime;
		this.updateTime = updateTime;
	}

	@Id
	@Column(name = "o_sys_sn")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public int getoSysSn() {
		return oSysSn;
	}

	public void setoSysSn(int oSysSn) {
		this.oSysSn = oSysSn;
	}

	@Column(name = "u_sys_sn")
	public int getuSysSn() {
		return uSysSn;
	}

	public void setuSysSn(int uSysSn) {
		this.uSysSn = uSysSn;
	}

	@Column(name = "status")
	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	@Column(name = "price")
	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	@Column(name = "consignee")
	public String getConsignee() {
		return consignee;
	}

	public void setConsignee(String consignee) {
		this.consignee = consignee;
	}

	@Column(name = "addr")
	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	@Column(name = "pay")
	public String getPay() {
		return pay;
	}

	public void setPay(String pay) {
		this.pay = pay;
	}

	@Column(name = "pay_status")
	public String getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(String payStatus) {
		this.payStatus = payStatus;
	}

	@Column(name = "create_time")
	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	@Column(name = "update_time")
	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "orders", cascade = CascadeType.ALL)
	public Set<OrdersDetail> getOrdersDetail() {
		return ordersDetail;
	}

	public void setOrdersDetail(Set<OrdersDetail> ordersDetail) {
		this.ordersDetail = ordersDetail;
	}

}
