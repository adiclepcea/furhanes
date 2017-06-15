package org.clepcea.dao;

import java.util.List;
import java.util.Set;

import org.clepcea.model.Contract;
import org.clepcea.model.Supplier;
import org.clepcea.model.User;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
public class UserDaoImpl implements UserDao {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	@Transactional
	public void save(User user) {
		Session session = this.sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		session.saveOrUpdate(user);
		tx.commit();
		session.close();
	}

	@Override
	public List<User> list() {
		Session session = sessionFactory.openSession();
		
		Criteria crit = session.createCriteria(User.class);
		
		crit.addOrder(Order.asc("username"));
		
		List<User> lst = crit.list();
		
		for(User u : lst){
			u.getRoles().size();
		}
		session.close();		
		return lst;
	}

	@Override
	public void deleteById(long id) {
		Session session = sessionFactory.openSession();
		User user = new User();
		user.setId(id);
	
		session.delete(user);
		session.flush();
		
		session.close();
	}

	@Override
	public User getById(long id) {
		Session session = sessionFactory.openSession();
		Query query = session.createQuery("from User where id=:id");
		query.setParameter("id", id);	
		User user = (User)query.uniqueResult(); 
		session.close();
		return user;
	}

}
