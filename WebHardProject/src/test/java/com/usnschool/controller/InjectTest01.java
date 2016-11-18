package com.usnschool.controller;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class InjectTest01 {
	@Inject
	private SqlSession session;
	
	@Test
	public void testSession() throws Exception{
		try{
			
			System.out.println(session != null);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
