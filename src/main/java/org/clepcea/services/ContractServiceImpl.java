package org.clepcea.services;

import java.util.List;
import java.util.Map;

import org.clepcea.dao.ContractDao;
import org.clepcea.model.Contract;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ContractServiceImpl implements ContractService {

	@Autowired
	private ContractDao contractDao;
	@Override
	public void saveContract(Contract contract) {
		
		contractDao.save(contract);
	}

	@Override
	public List<Contract> listContracts(int start, int count, Map<String, Object> filter) {
		return contractDao.list(start, count,filter);
	}

	@Override
	public Contract getContractById(long id) {
		return contractDao.getById(id);
	}

	@Override
	public void deleteContractById(long id) {
		contractDao.deleteById(id);
	}

}
