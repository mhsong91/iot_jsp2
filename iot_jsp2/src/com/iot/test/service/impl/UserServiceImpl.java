package com.iot.test.service.impl;


import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.iot.test.dao.UserDAO;
import com.iot.test.dao.impl.UserDAOimpl;
import com.iot.test.service.UserService;
import com.iot.test.vo.UserClass;

public  class UserServiceImpl implements UserService {
	private Gson gs = new Gson();
	private UserDAO ud = new UserDAOimpl();

	@Override
	public HashMap<String, Object> login(HttpServletRequest req, HttpServletResponse res) {
		UserClass uc = gs.fromJson(req.getParameter("param"), UserClass.class);
		System.out.println(uc);
		UserClass checkuc = ud.SelectUser(uc.getUiId());
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("msg", "로그인에 성공하셨습니다.");
		hm.put("login", "ok");
		if (checkuc!= null) {
			if (!checkuc.getUiPwd().equals(uc.getUiPwd())) {
				hm.put("msg", "비밀번호를 확인하세요.");
				hm.put("login", "no");
			} else {
				System.out.println(uc.isSaveId());
				Cookie cId=new Cookie("userId", uc.getUiId());
				cId.setPath("/");
				Cookie cSave=new Cookie("saveId", ""+uc.isSaveId());
				cId.setPath("/");
				int maxAge=0;
				if(uc.isSaveId()) {
					maxAge=60*60*24;
				}
				cId.setMaxAge(maxAge);
				cSave.setMaxAge(maxAge);
				res.addCookie(cId);
				res.addCookie(cSave);					
				HttpSession hs = req.getSession();
				hs.setAttribute("user", checkuc);
			}
		} else {
			hm.put("msg", "아이디를 확인하세요");
			hm.put("login", "no");
		}

		return hm;
	}

	@Override
	public void logout(HttpServletRequest req) {
		HttpSession hs = req.getSession();
		hs.invalidate();

	}

	@Override
	public void signin(HttpServletRequest req) {
		String json = req.getParameter("param");			
		UserClass uc = gs.fromJson(json, UserClass.class);
		int result =ud.insertUser(uc);
		HashMap<String,Object> rm= new HashMap<String,Object>();
		rm.put("result","no");
		rm.put("msg","실패");
		if(result==1) {
			rm.put("result", "ok");
			rm.put("msg","새로운 세상에 온것을 환영합니다^^.");
		}
		req.setAttribute("restr",gs.toJson(rm));
		
	}

	@Override
	public ArrayList<UserClass> getuserlist() {
		// TODO Auto-generated method stub
		return ud.slelectUserList();
	}

	@Override
	public String deleteUser(HttpServletRequest req) {
		int uiNo=Integer.parseInt(req.getParameter("uiNo"));
		UserClass uc= new UserClass();
		uc.setUiNo(uiNo);
		int result = ud.deleteUser(uc);
		
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
	public String updateUser(HttpServletRequest req) {
		String param=req.getParameter("param");
		UserClass uc= gs.fromJson(param,UserClass.class);
		int result=ud.updateUser(uc);
		HashMap<String,String> rm = new HashMap<String,String>();
		rm.put("result","no");
		rm.put("msg","수정 실패했다");
		if(result==1) {
			rm.put("result", "ok");
			rm.put("msg","수정성공^^.");
		}
		return gs.toJson(rm);
	}
		


}


// String id = req.getParameter("userId");
// String pwd = req.getParameter("userPwd");
//
// HashMap<String, Object> hm = new HashMap<String, Object>();
// hm.put("msg", "로그인에 성공하셨습니다.");
// hm.put("login","ok");
// if(uc.getUiId().equals("test")) {
// if(!uc.getUiPwd().equals("test")) {
//
// hm.put("msg","비밀번호를 확인하세요.");
// hm.put("login","no");
// }else {
// HttpSession hs = req.getSession();
// hs.setAttribute("user",uc);
//
// }
// }else {
// hm.put("msg", "아이디를 확인하세요");
// hm.put("login","no");
// }
