package org.clepcea.dao;

import java.util.List;

import org.clepcea.model.Contact;
import org.clepcea.model.Supplier;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ContactDaoImpl implements ContactDao {

	@Autowired
	private SessionFactory sessionFactory;
	
	public void setSessionFactory(SessionFactory sessionFactory){
		this.sessionFactory = sessionFactory;
	}
	
	@Override
	public void save(Contact contact) {
		Session session = this.sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		if(contact.getSurname().equals("")){
			contact.setSurname(null);
		}
		Contact c=this.getById(contact.getId());
		contact.setSupplier(c.getSupplier());
		session.saveOrUpdate(contact);
		tx.commit();
		session.close();
	}

	@Override
	public List<Contact> list(int start, int count) {
		Session session = sessionFactory.openSession();
		Query qry = session.createQuery("from Contact"); 
		if(count>0){
			qry.setFirstResult(start);
			qry.setMaxResults(count);
		}
		List<Contact> lst = qry.list();
		
		session.close();
		return lst;
	}

	@Override
	public void deleteById(long id) {
		Session session = sessionFactory.openSession();
		Contact contact = getById(id);
		if(contact!=null){
			session.delete(contact);
			session.flush();
		}
		session.close();
	}

	@Override
	public Contact getById(long id) {
		Session session = sessionFactory.openSession();
		Query query = session.createQuery("from Contact where id=:id");
		query.setParameter("id", id);	
		Contact contact = (Contact)query.uniqueResult(); 
		session.close();
		return contact;
	}

}
