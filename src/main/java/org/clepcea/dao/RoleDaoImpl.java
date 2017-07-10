package org.clepcea.dao;

import java.util.List;

import org.clepcea.model.Role;
import org.clepcea.model.User;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class RoleDaoImpl implements RoleDao {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public void save(Role role) {
		Session session = this.sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		session.saveOrUpdate(role);
		tx.commit();
		session.close();
	}

	@Override
	public List<Role> list() {
		Session session = sessionFactory.openSession();
		
		Criteria crit = session.createCriteria(Role.class);
		
		crit.addOrder(Order.asc("name"));
		
		List<Role> lst = crit.list();
		for(Role r : lst ){
			r.getRights().size();
		}
		
		session.close();		
		return lst;
	}

	@Override
	public void deleteById(long id) {
		Session session = sessionFactory.openSession();
		Role role = new Role();
		role.setId(id);
	
		session.delete(role);
		session.flush();
		
		session.close();

	}

	@Override
	public Role getById(long id) {
		Session session = sessionFactory.openSession();
		Query query = session.createQuery("from Role where id=:id");
		query.setParameter("id", id);	
		Role role = (Role)query.uniqueResult(); 
		role.getRights().size();
		
		session.close();
		return role;
	}

}
