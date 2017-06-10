package org.clepcea.dao;

import java.util.List;
import java.util.Map;

import org.clepcea.model.Contract;

public interface ContractDao {
	public void save(Contract contract);
	public List<Contract> list(int start,int count,Map<String, Object> filter);
	public void deleteById(long id);
	public Contract getById(long id);
}
