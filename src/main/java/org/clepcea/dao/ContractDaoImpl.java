package org.clepcea.dao;

import java.util.List;

import org.clepcea.model.Contract;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ContractDaoImpl implements ContractDao {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public void save(Contract contract) {
		Session session = this.sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		Contract c=this.getById(contract.getId());
		contract.setSupplier(c.getSupplier());
		session.saveOrUpdate(contract);
		tx.commit();
		session.close();
	}

	@Override
	public List<Contract> list(int start, int count) {
		Session session = sessionFactory.openSession();
		Query qry = session.createQuery("from Contract"); 
		if(count>0){
			qry.setFirstResult(start);
			qry.setMaxResults(count);
		}
		List<Contract> lst = qry.list();
		
		session.close();
		return lst;
	}

	@Override
	public void deleteById(long id) {
		Session session = sessionFactory.openSession();
		Contract contract = getById(id);
		if(contract!=null){
			session.delete(contract);
			session.flush();
		}
		session.close();

	}

	@Override
	public Contract getById(long id) {
		Session session = sessionFactory.openSession();
		Query query = session.createQuery("from Contract where id=:id");
		query.setParameter("id", id);	
		Contract contract = (Contract)query.uniqueResult(); 
		session.close();
		return contract;
	}

}
