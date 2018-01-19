package com.iot.test.dao.impl;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.iot.test.common.DBCon;
import com.iot.test.dao.UserDAO;
import com.iot.test.utils.DBUtil;
import com.iot.test.vo.UserClass;


public class UserDAOimpl implements UserDAO{

	@Override
	public ArrayList<UserClass> slelectUserList() {
		ArrayList<UserClass> userlist =new ArrayList<UserClass>();
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		try {			
			con=DBCon.getCon();
			String sql ="select*from user_info ui, class_info ci\r\n" + 
					"where ui.cino = ci.cino";
			ps=con.prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()){
				UserClass uc=new UserClass();
				uc.setAddress(rs.getString("address"));
				uc.setCiDesc(rs.getString("cidesc"));
				uc.setCiName(rs.getString("ciname"));
				uc.setCiNo(rs.getInt("cino"));
				uc.setUiAge(rs.getInt("uiage"));
				uc.setUiId(rs.getString("uiId"));
				uc.setUiName(rs.getString("uiname"));
				uc.setUiNo(rs.getInt("uino"));
				uc.setUiPwd(rs.getString("uipwd"));
				uc.setUiRegdate(rs.getString("uiregdate"));
				 userlist.add(uc);
				 
			}
		} catch (Exception e) {
			
			e.printStackTrace();
		}finally{
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(ps!=null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

		}
			
		return userlist;
	}
	@Override
	public UserClass SelectUser(String uiId) {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		try {			
			con=DBCon.getCon();
			String sql ="select*,date_format(uiregdate,'%y,%m,%d') as rdate from user_info ui, class_info ci\r\n" + 
					"where ui.cino = ci.cino and ui.uiid=?";
			ps=con.prepareStatement(sql);
			ps.setString(1,uiId);
			rs=ps.executeQuery();
			while(rs.next()){
				UserClass uc=new UserClass();
				uc.setAddress(rs.getString("address"));
				uc.setCiDesc(rs.getString("cidesc"));
				uc.setCiName(rs.getString("ciname"));
				uc.setCiNo(rs.getInt("cino"));
				uc.setUiAge(rs.getInt("uiage"));
				uc.setUiId(rs.getString("uiId"));
				uc.setUiName(rs.getString("uiname"));
				uc.setUiNo(rs.getInt("uino"));
				uc.setUiPwd(rs.getString("uipwd"));
				uc.setUiRegdate(rs.getString("rdate"));
				return uc;
			}
		} catch (Exception e) {
			
			e.printStackTrace();
		}
			
		return null;
	}
	@Override
	public UserClass SelectUser(int uino) {
		return null;
	}
	@Override
	public int insertUser(UserClass uc) {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		try {			
			con=DBCon.getCon();
			String sql="insert into user_info(uiName,uiAge,uiId,uiPwd,address,ciNo, uiregdate) values(?,?,?,?,?,?,now())";
			ps=con.prepareStatement(sql);
			ps.setString(1,uc.getUiName());
			ps.setInt(2,uc.getUiAge());
			ps.setString(3,uc.getUiId());
			ps.setString(4,uc.getUiPwd());
			ps.setString(5,uc.getAddress());
			ps.setInt(6,uc.getCiNo());
			
			return ps.executeUpdate();
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}finally{
			DBUtil.close(rs);
			DBUtil.close(con);
			DBUtil.close(ps);
		}
		return 0;
	}
	
	@Override
	public int updateUser(UserClass uc) {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		try {			
			con=DBCon.getCon();
			String sql="update user_info"+ " set uiName=?,uiAge=?,address=? where uiNo=?";
			ps=con.prepareStatement(sql);
			ps.setString(1,uc.getUiName());
			ps.setInt(2,uc.getUiAge());
			ps.setString(3,uc.getAddress());
			ps.setInt(4,uc.getUiNo());
		
			
			return ps.executeUpdate();
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}finally{
			DBUtil.close(rs);
			DBUtil.close(con);
			DBUtil.close(ps);
		}
			return 0;
	}
	@Override
	public int deleteUser(UserClass uc) {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {			
			con=DBCon.getCon();
			String sql="delete from user_info where uiNo=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1,uc.getUiNo());
			
			return ps.executeUpdate();
			
		} catch (Exception e) {
			
		
		}finally{
		
			DBUtil.close(con);
			DBUtil.close(ps);
		}
		return 0;
		
	}



}
