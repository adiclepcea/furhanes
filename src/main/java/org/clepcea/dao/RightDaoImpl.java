package org.clepcea.dao;

import java.util.List;

import org.clepcea.model.Right;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class RightDaoImpl implements RightDao {

	@Autowired
	SessionFactory sessionFactory;
	
	@Override
	public List<Right> list() {
		Session session = sessionFactory.openSession();
		
		Criteria crit = session.createCriteria(Right.class);
		
		crit.addOrder(Order.asc("name"));
		
		List<Right> lst = crit.list();
		
		
		session.close();		
		return lst;
	}

}
