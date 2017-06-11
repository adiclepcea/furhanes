package org.clepcea.services;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import org.clepcea.model.Contract;

public interface ContractService {
	public void saveContract(Contract contract);
	public List<Contract> listContracts(int start, int count, Map<String,Object> filter);
	public Contract getContractById(long id);
	public void deleteContractById(long id);
	public Map<String,Long> getStatistics();
	public void writeListToExcel(int start, int count, Map<String, Object> filter, OutputStream os) throws IOException;
}
