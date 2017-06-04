package org.clepcea.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import org.clepcea.model.Contact;
import org.clepcea.model.Contract;
import org.clepcea.model.Supplier;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

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
	@Transactional
	public List<Supplier> list(int start, int count,HashMap<String, Object> filter) {
		Session session = sessionFactory.openSession();
		
		Criteria crit = session.createCriteria(Supplier.class);
		if(filter!=null){
			crit.add(Restrictions.ilike("name", "%"+filter.get("name").toString()+"%"));
			crit.setMaxResults(count);
			crit.setFirstResult(start);
		}
		crit.addOrder(Order.asc("name"));
		List<Supplier> lst = crit.list();
		
		for(Supplier s : lst){
			s.getContacts().size();
			s.getContracts().size();
		}
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
	@Transactional
	public List<Contact> contactListBySupplierId(long id) {
		Session session = sessionFactory.openSession();
		Query query = session.createQuery("from Supplier where id=:id");
		query.setParameter("id", id);	
		Supplier supplier = (Supplier)query.uniqueResult();
		List<Contact> contacts = supplier==null?new ArrayList<Contact>():supplier.getContacts();
		contacts.size();
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
	@Override
	@Transactional
	public List<Contract> contractListBySupplierId(long id) {
		Session session = sessionFactory.openSession();
		Query query = session.createQuery("from Supplier where id=:id");
		query.setParameter("id", id);	
		Supplier supplier = (Supplier)query.uniqueResult();
		List<Contract> contracts = supplier==null?new ArrayList<Contract>():supplier.getContracts();
		contracts.size();
		session.close();
		return contracts;
	}
	@Override
	public void addContractToSupplierId(long id,Contract contract) {
		System.out.println("addContractToSupplierCalled");
		Session session = sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		Supplier supplier = (Supplier)session.load(Supplier.class, id);
		contract.setSupplier(supplier);
		supplier.getContracts().add(contract);
		session.saveOrUpdate(contract);
		tx.commit();
		session.close();
	}

}
