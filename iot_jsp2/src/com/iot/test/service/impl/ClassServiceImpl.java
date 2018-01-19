package com.iot.test.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.google.gson.Gson;
import com.iot.test.dao.ClassDao;
import com.iot.test.dao.UserDAO;
import com.iot.test.dao.impl.ClassDaoImpl;
import com.iot.test.dao.impl.UserDAOimpl;
import com.iot.test.service.ClassService;
import com.iot.test.vo.ClassInfo;
import com.iot.test.vo.UserClass;

public  class ClassServiceImpl implements ClassService{
	private ClassDao cdao = new ClassDaoImpl();
	private Gson gs = new Gson();
	
	
	

	@Override
	public String updateClass(HttpServletRequest req) {
		String param = req.getParameter("param");
		ClassInfo ci= gs.fromJson(param,ClassInfo.class);
		int result= cdao.updateClass(ci);
		HashMap<String,String> rm = new HashMap<String,String>();
		rm.put("result","no");
		rm.put("msg","수정 실패했다");
		if(result==1) {
			rm.put("result", "ok");
			rm.put("msg","수정성공^^.");
		}
		return gs.toJson(rm);
	}

	@Override
	public String deleteClass(HttpServletRequest req) {
		int uiNo=Integer.parseInt(req.getParameter("ciNo"));
		ClassInfo ci= new ClassInfo();
		ci.setCiNo(uiNo);
		int result = cdao.deleteClass(ci);
		
		HashMap<String,String> rm = new HashMap<String,String>();
		rm.put("result","no");
		rm.put("msg","삭제가 실패했다");
		if(result==1) {
			rm.put("result", "ok");
			rm.put("msg","성공^^.");
		}
		return gs.toJson(rm);
	}

	@Override
	public List<ClassInfo> getClassList() {
		
		return cdao.selectClassList();
	}

	@Override
	public String insert(HttpServletRequest req) {
		
		String param=req.getParameter("param");
		ClassInfo ci= gs.fromJson(param,ClassInfo.class);
		int result= cdao.insertClass(ci);
		HashMap<String,String> rm = new HashMap<String,String>();
		rm.put("result","no");
		rm.put("msg"," 실패");
		if(result==1) {
			rm.put("result", "ok");
			rm.put("msg","성공^^.");
		}
		return gs.toJson(rm);
	}

	

	;
	

	
	



	


}

