package com.iot.test.dao;

import java.util.ArrayList;

import com.iot.test.vo.UserClass;

public interface UserDAO {

	ArrayList<UserClass> slelectUserList();
	UserClass SelectUser(int uino);
	UserClass SelectUser(String uiId);
	int insertUser(UserClass uc);
	int updateUser(UserClass uc);
	int deleteUser(UserClass uc);	
}
