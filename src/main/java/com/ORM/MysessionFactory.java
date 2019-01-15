package com.ORM;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class MysessionFactory {
	private  static Configuration configuration = new Configuration();
	private static SessionFactory sessionFactory;
	static{
		configuration.configure("/hibernate.cfg.xml");
		configuration.buildSessionFactory();
	}
	public static Session getSession(){
		return sessionFactory.openSession();
	}
	public static void closeSession(){
		sessionFactory.close();
	}
}
