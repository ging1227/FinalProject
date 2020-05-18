package sampple.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sampple.model.Uinfo;
import sampple.model.dao.UinfoDAO;

@Service
public class UinfoService {
private UinfoDAO uinfoDao;
	
	@Autowired
	public UinfoService(UinfoDAO uinfoDao) {
		this.uinfoDao = uinfoDao;
	}
	
	/**
	 *  新增資訊
	 *  @param Uinfo
	 *  @return boolean
	 *  
	 * */
	public boolean insert(Uinfo uinfo) {
		return uinfoDao.insertInfo(uinfo);
	}
	
	/**
	 *  查詢資料
	 *  @param int
	 *  @return Uinfo
	 *  
	 * */
	public Uinfo query(int sysSn) {
		return uinfoDao.queryInfo(sysSn);
	}
	
	/**
	 * 	修改資料
	 *  @param Uinfo
	 *  @return boolean
	 *  
	 * */
	public boolean update(Uinfo uinfo) {
		return uinfoDao.updateInfo(uinfo);
	}
	
	/**
	 * 	查詢資料(後台查詢用)
	 *  @param Uinfo
	 *  @return List Uinfo
	 *  
	 * */
	public List<Uinfo> queryAllInfo(){		
		return uinfoDao.queryAllInfo();
	};
}
