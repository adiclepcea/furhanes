package org.clepcea.services;

import java.util.List;
import java.util.Map;

import org.clepcea.model.Contract;

public interface ContractService {
	public void saveContract(Contract contract);
	public List<Contract> listContracts(int start, int count, Map<String,Object> filter);
	public Contract getContractById(long id);
	public void deleteContractById(long id);
}
