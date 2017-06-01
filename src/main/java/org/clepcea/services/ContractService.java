package org.clepcea.services;

import java.util.HashMap;
import java.util.List;

import org.clepcea.model.Contract;

public interface ContractService {
	public void saveContract(Contract contract);
	public List<Contract> listContracts(int start, int count, HashMap<String,Object> filter);
	public Contract getContractById(long id);
	public void deleteContractById(long id);
}
