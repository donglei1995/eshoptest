package com.service;

import java.util.List;

import com.ORM.*;
import com.base.*;
import org.hibernate.*;
import com.ORM.MysessionFactory;
/** ϵͳ�û�����ӿ�ʵ�� */
public class AdminServiceImpl extends BaseLog implements AdminService {

	/** ϵͳ����Ա��¼ */
	public Admin adminLogin(String loginName, String loginPwd) throws Exception {
		Session session = MysessionFactory.getSession();
		Transaction tx = null;
		Admin admin = null;
		try{
			String hql = "select a from Admin as a where a.loginName=:loginName and a.loginPwd=:loginPwd";
			Query query = session.createQuery(hql);
			query.setString("loginName", loginName);
			query.setString("loginPwd", loginPwd);
			query.setMaxResults(1);
			tx = session.beginTransaction();
			admin = (Admin)query.uniqueResult();
			tx.commit();
		}catch(Exception ex){
			if(tx!=null)tx.rollback();
			//logger.info("��ִ��AdminServiceImpl���е�adminLogin����ʱ���?\n");
			ex.printStackTrace();
		}finally{
			MysessionFactory.closeSession();
		}	
		return admin;
	}

	/** ��������Ա */	
	public boolean addAdmin(Admin admin) throws Exception {
		Session session = MysessionFactory.getSession();
		Transaction tx = null;
		boolean status = false;
		try{
			tx = session.beginTransaction();
			session.save(admin);
			tx.commit();
			status = true;
		}catch(Exception ex){
			if(tx!=null)tx.rollback();
			//logger.info("��ִ��AdminServiceImpl���е�addAdmin����ʱ���?\n");
			ex.printStackTrace();
		}finally{
			MysessionFactory.closeSession();
		}	
		return status;
	}

	/** �������Ա */
	public List browseAdmin() throws Exception {
		Session session = MysessionFactory.getSession();
		Transaction tx = null;
		List list = null;
		try{
			Query query = session.createQuery("from Admin as a order by a.id");
			tx = session.beginTransaction();
			list = query.list();
			tx.commit();
			if (!Hibernate.isInitialized(list))Hibernate.initialize(list);
		}catch(Exception ex){
			if(tx!=null)tx.rollback();
			//logger.info("��ִ��AdminServiceImpl���е�browseAdmin����ʱ���?\n");
			ex.printStackTrace();
		}finally{
			MysessionFactory.closeSession();
		}	
		return list;
	}

	/** ɾ��ָ���Ĺ���Ա */
	public boolean delAdmin(Integer id) throws Exception {
		Session session = MysessionFactory.getSession();
		Transaction tx = null;
		boolean status = false;
		try{
			tx = session.beginTransaction();
			Admin admin = (Admin)session.load(Admin.class, id);
			session.delete(admin);
			tx.commit();
			status = true;
		}catch(Exception ex){
			if(tx!=null)tx.rollback();
			//logger.info("��ִ��AdminServiceImpl���е�delAdmin����ʱ���?\n");
			ex.printStackTrace();
		}finally{
			MysessionFactory.closeSession();
		}	
		return status;
	}

	/** װ��ָ���Ĺ���Ա */
	public Admin loadAdmin(Integer id) throws Exception {
		Session session = MysessionFactory.getSession();
		Transaction tx = null;
		Admin admin = null;
		try{
			tx = session.beginTransaction();
			admin = (Admin)session.get(Admin.class, id);
			tx.commit();
		}catch(Exception ex){
			if(tx!=null)tx.rollback();
			//logger.info("��ִ��AdminServiceImpl���е�loadAdmin����ʱ���?\n");
			ex.printStackTrace();
		}finally{
			MysessionFactory.closeSession();
		}	
		return admin;
	}

	/** ���¹���Ա */	
	public boolean updateAdmin(Admin admin) throws Exception {
		Session session = MysessionFactory.getSession();
		Transaction tx = null;
		boolean status = false;
		try{
			tx = session.beginTransaction();
			session.update(admin);
			tx.commit();
			status = true;
		}catch(Exception ex){
			if(tx!=null)tx.rollback();
			//logger.info("��ִ��AdminServiceImpl���е�updateAdmin����ʱ���?\n");
			ex.printStackTrace();
		}finally{
			MysessionFactory.closeSession();
		}	
		return status;
	}
}