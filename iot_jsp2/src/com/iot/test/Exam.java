package com.iot.test;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import com.iot.test.vo.ClassInfo;

public class Exam {

	
	public static void main(String[] orgs) {
		try {
			Class c= Class.forName("com.iot.test.vo.ClassInfo");
			Method[] ms = c.getDeclaredMethods();
			for(Method m:ms) {
				System.out.print("메소드면"+m.getName());
				System.out.print(",파라미터 타입들"+m.getParameterTypes());
				System.out.println(",리턴타입"+m.getReturnType());
			
			}
			ClassInfo ci =null;
			Constructor[] cons =c.getDeclaredConstructors();
			for(Constructor con:cons) {
				System.out.println("생성자명"+con.getName());
				ci=(ClassInfo)con.newInstance();
				}
			Class[] param=new Class[1];
			param[0]=Integer.TYPE;
			Method setCiNo = c.getMethod("setCiNo",param);
			Object[] p= new Object[1];
			p[0]= new Integer(1);
			setCiNo.invoke(ci,p);
			if(ci != null) {
				System.out.println(ci);
			}
			
		} catch (ClassNotFoundException | SecurityException | InstantiationException | IllegalAccessException | IllegalArgumentException | InvocationTargetException | NoSuchMethodException e) {
			
			e.printStackTrace();
		}
		
	}
}
