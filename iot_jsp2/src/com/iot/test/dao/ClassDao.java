package com.iot.test.dao;

import java.util.List;

import com.iot.test.vo.ClassInfo;
import com.iot.test.vo.UserClass;

public interface ClassDao {
	List<ClassInfo> selectClassList();
	int insertClass(ClassInfo ci);
	int updateClass(ClassInfo ci);
	int deleteClass(ClassInfo ci);	
	
}
