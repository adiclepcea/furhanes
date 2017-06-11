package org.clepcea.dao;

import java.util.List;
import java.util.Map;

import org.clepcea.model.Contract;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
public class ContractDaoImpl implements ContractDao {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	@Transactional
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
	@Transactional
	public Long getExpiredContractsCount(){
		Session session = this.sessionFactory.openSession();
		Long rez=(Long)session.createQuery("Select count(*) from Contract where expirationDate<current_date and doNotRenew=false and undefinite=false").uniqueResult();
		session.close();
		if(rez==null){
			rez = 0L;
		}
		return rez;
	}
	
	@Override
	@Transactional
	public Long getExpiringContractsCount(){
		Session session = this.sessionFactory.openSession();
		Long rez = (Long)session.createQuery("Select count(*) from Contract where expirationDate<current_date+20 and expirationDate>=current_date and doNotRenew=false and undefinite=false").uniqueResult();
		session.close();
		if(rez==null){
			rez = 0L;
		}
		return rez;
	}
	
	@Override
	@Transactional
	public Long getRunningContractsCount(){
		Session session = this.sessionFactory.openSession();
		Long rez = (Long)session.createQuery("Select count(*) from Contract where expirationDate>=current_date+20 or undefinite=true").uniqueResult();
		session.close();
		if(rez==null){
			rez = 0L;
		}
		return rez;
	}
	
	@Override
	@Transactional
	public Long getFinishedContractsCount(){
		Session session = this.sessionFactory.openSession();
		Long rez = (Long)session.createQuery("Select count(*) from Contract where expirationDate<current_date and undefinite=false and doNotRenew=true").uniqueResult();
		session.close();
		if(rez==null){
			rez = 0L;
		}
		return rez;
	}
	
	@Override
	@Transactional
	public List<Contract> list(int start, int count,Map<String, Object> filter) {
		Session session = sessionFactory.openSession();
		String hql = "from Contract ";
		boolean filterUsed = false; 
		if(filter!=null){
			if(filter.containsKey("expired") && filter.get("expired").equals("true")){
				hql+="where (expirationDate < current_date and undefinite=false and doNotRenew=false)";
				filterUsed=true;
			}
			if(filter.containsKey("expiring") && filter.get("expiring").equals("true")){
				if(filterUsed){
					hql+=" or (expirationDate between current_date and current_date+20 and undefinite=false and doNotRenew=false)";
				}else{
					hql+="where (expirationDate between current_date and current_date+20 and undefinite=false and doNotRenew=false)";
					filterUsed = true;
				}
				
			}
			if(filter.containsKey("running") && filter.get("running").equals("true")){
				if(filterUsed){
					hql+=" or (undefinite=true or (coalesce(expirationDate,current_date) > current_date+20))";
				}else{
					hql+="where (undefinite=true or (coalesce(expirationDate,current_date) > current_date+20))";
					filterUsed = true;
				}
			}
			if(filter.containsKey("finished") && filter.get("finished").equals("true")){
				if(filterUsed){
					hql+=" or (expirationDate < current_date and undefinite=false and doNotRenew=true)";
				}else{
					hql+="where (expirationDate < current_date and undefinite=false and doNotRenew=true)";
					filterUsed = true;
				}
			}
			
		}
		
		hql+=" order by supplier.name, contractDate";
		Query qry = session.createQuery(hql);
		if(count>0){
			qry.setFirstResult(start);
			qry.setMaxResults(count);
		}
		List<Contract> lst = qry.list();
		
		session.close();
		return lst;
	}

	@Override
	@Transactional
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
