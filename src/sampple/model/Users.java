package sampple.model;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "users")
@Component
public class Users {

	private int sysSn;
	private String email;
	private String password;
	private String deleteFlag;
	private String status;
	private Uinfo uinfo;

	public Users() {
	}

	public Users(String email, String password) {
		this.email = email;
		this.password = password;
	}

	@Id
	@Column(name = "sys_sn")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public int getSysSn() {
		return sysSn;
	}

	public void setSysSn(int sysSn) {
		this.sysSn = sysSn;
	}

	@Column(name = "email", unique = true)
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "password")
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(name = "delete_flag")
	public String getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	@Column(name = "status")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "users", cascade = CascadeType.ALL)
	@JoinColumn
	@JsonIgnore
	public Uinfo getUinfo() {
		return uinfo;
	}

	public void setUinfo(Uinfo uinfo) {
		this.uinfo = uinfo;
	}

}
