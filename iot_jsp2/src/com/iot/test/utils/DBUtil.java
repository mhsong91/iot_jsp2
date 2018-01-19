package com.iot.test.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBUtil {
	
	public static void close(ResultSet rs) { 
		try {if(rs!=null) {
			rs.close();
			}
		} catch (Exception e) {
			
			e.printStackTrace();
		}
	}
	public static void close(Connection con) { 
		try {if(con!=null) {
			con.close();
			}
		} catch (Exception e) {
			
			e.printStackTrace();
		}
	}
	public static void close(PreparedStatement ps) { 
		try {if(ps!=null) {
			ps.close();
			}
		} catch (Exception e) {
			
			e.printStackTrace();
		}
	}
}
