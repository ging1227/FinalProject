package sampple.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

@Entity
@Table(name = "cus_serv")
@Component
public class CusServ {
	private int cSysSn;
	private int uSysSn;
	private String content;
	private String status;

	@Id
	@Column(name = "c_sys_sn")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public int getcSysSn() {
		return cSysSn;
	}

	public void setcSysSn(int cSysSn) {
		this.cSysSn = cSysSn;
	}

	@Column(name = "u_sys_sn")
	public int getuSysSn() {
		return uSysSn;
	}

	public void setuSysSn(int uSysSn) {
		this.uSysSn = uSysSn;
	}

	@Column(name = "content")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Column(name = "status")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
