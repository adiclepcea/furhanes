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
public class SupplierDaoImpl implements SupplierDao {
	
	@Autowired
	private SessionFactory sessionFactory;
	
	public void setSessionFactory(SessionFactory sessionFactory){
		this.sessionFactory = sessionFactory;
	}
	@Override
	public void save(Supplier supplier) {
		Session session = this.sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		if(supplier.getCui().equals("")){
			supplier.setCui(null);
		}
		if(supplier.getJ().equals("")){
			supplier.setJ(null);
		}
		session.saveOrUpdate(supplier);
		tx.commit();
		session.close();
	}

	@Override
	public List<Supplier> list(int start, int count) {
		Session session = sessionFactory.openSession();
		Query qry = session.createQuery("from Supplier"); 
		if(count>0){
			qry.setFirstResult(start);
			qry.setMaxResults(count);
		}
		List<Supplier> lst = qry.list();
		
		session.close();
		return lst;
	}

	@Override
	public void deleteById(long id) {
		Session session = sessionFactory.openSession();
		Supplier supplier = new Supplier();
		supplier.setId(id);
	
		session.delete(supplier);
		session.flush();
		
		session.close();
	}
	
	@Override
	public Supplier getById(long id){
		Session session = sessionFactory.openSession();
		Query query = session.createQuery("from Supplier where id=:id");
		query.setParameter("id", id);	
		Supplier supplier = (Supplier)query.uniqueResult(); 
		session.close();
		return supplier;
	}
	@Override
	public List<Contact> contactListBySupplierId(long id) {
		Session session = sessionFactory.openSession();
		Query query = session.createQuery("from Supplier where id=:id");
		query.setParameter("id", id);	
		Supplier supplier = (Supplier)query.uniqueResult();
		List<Contact> contacts = supplier.getContacts();
		session.close();
		return contacts;
	}
	@Override
	public void addContactToSupplierId(long id,Contact contact) {
		System.out.println("addContactToSupplierCalled");
		Session session = sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		Supplier supplier = (Supplier)session.load(Supplier.class, id);
		contact.setSupplier(supplier);
		supplier.getContacts().add(contact);
		session.saveOrUpdate(contact);
		tx.commit();
		session.close();
	}

}
