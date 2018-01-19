package com.iot.test.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.iot.test.vo.ClassInfo;
import com.iot.test.vo.UserClass;

public interface ClassService {
	
	List<ClassInfo> getClassList();
	public String updateClass(HttpServletRequest req);
	public String deleteClass(HttpServletRequest req);
	public String insert(HttpServletRequest req);
	
}
