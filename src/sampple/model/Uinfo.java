package sampple.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.springframework.stereotype.Component;
import org.hibernate.annotations.Parameter; 

@Entity
@Table(name = "u_info")
@Component
public class Uinfo {
	private int sysSn;
	private String name;
	private String id;
	private String addr;
	private String gender;
	private String birth;
	private String tel;
	private String ademail;
	private String utype;
	private String picture;
	private Users users;
	
	@GenericGenerator(name="generator",strategy = "foreign",parameters = @Parameter(name="property",value="users"))
	@Column(name="sys_sn")
	@GeneratedValue(generator = "generator")
	@Id
	public int getSysSn() {
		return sysSn;
	}
	public void setSysSn(int sysSn) {
		this.sysSn = sysSn;
	}
	
	@Column(name="name")
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@Column(name="birth")
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	
	@Column(name="tel")
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	
	@Column(name="addr")
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	@Column(name="id")
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	@Column(name="u_type")
	public String getUtype() {
		return utype;
	}
	public void setUtype(String type) {
		this.utype = type;
	}
	
	@OneToOne(fetch = FetchType.LAZY)
	@PrimaryKeyJoinColumn
	public Users getUsers() {
		return users;
	}
	public void setUsers(Users users) {
		this.users = users;
	}
	
	@Column(name="gender")
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	
	@Column(name="ad_email")
	public String getAdemail() {
		return ademail;
	}
	public void setAdemail(String ademail) {
		this.ademail = ademail;
	}
	@Column(name="picture")
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	
	
}
