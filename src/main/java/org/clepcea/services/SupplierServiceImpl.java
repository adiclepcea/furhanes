package org.clepcea.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.clepcea.dao.SupplierDao;
import org.clepcea.model.Contact;
import org.clepcea.model.Contract;
import org.clepcea.model.Supplier;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SupplierServiceImpl implements SupplierService{
	private ArrayList<Supplier> suppliers = new ArrayList<Supplier>();
	
	@Autowired
	private SupplierDao supplierDao;
	
	public SupplierServiceImpl(){
		Supplier s1 = new Supplier();
		s1.setId(1);
		s1.setName("Eta2u");
		s1.setAddress("Arad, str. Revolutiei, nr 78");
		s1.setBank("Banca Romana pentru Dezvoltare");
		s1.setIban("ROABNA0000112233000022336");
		s1.setMail("office@eta2u.ro");
		s1.setCui("RO11234433");
		s1.setJ("J02/033/1999");
		s1.setPhone("0040257252382");
		
		Supplier s2 = new Supplier();
		s2.setId(2);
		s2.setName("Compania de Informatica Piatra Neamt");
		s2.setAddress("Jud. Neamt, Loc. Piatra Neamt,\r\n str. Industria fina, nr 234/bis\r\n cod: 7766338");
		s2.setBank("Banca Comerciala Romana");
		s2.setIban("ROABNA0000112233765423874");
		s2.setMail("office@compania-informatica.ro");
		s2.setCui("RO11232623");
		s2.setJ("J02/023/1992");
		s2.setPhone("0040248252382");
		
		Supplier s3 = new Supplier();
		s3.setId(3);
		s3.setName("Intrepri1nderea de mecanica fina");
		s3.setAddress("Jud. Timis, Loc. Timisoara,\r\n str. Industria fina, nr 234/bis\r\n cod: 4425463");
		s3.setBank("Banca Comerciala Romana");
		s3.setIban("ROABNA0000112233765425487");
		s3.setCui("RO11231111");
		s3.setJ("J02/023/1994");
		s3.setFax("0040256252382");
		
		suppliers.add(s1);
		suppliers.add(s2);
		suppliers.add(s3);
		
	}
	@Override
	public void saveSupplier(Supplier supplier) {
		supplierDao.save(supplier);
	}

	@Override
	public List<Supplier> listSuppliers(int start, int count, HashMap<String, Object> filter) {
		return supplierDao.list(start,count,filter);
	}

	@Override
	public void deleteSupplierById(long id) {
		supplierDao.deleteById(id);
	}

	@Override
	public Supplier getSupplierById(long id) {
		return supplierDao.getById(id);
	}
	@Override
	public List<Contact> listContactsBySupplierId(long id) {
		return supplierDao.contactListBySupplierId(id);
	}
	@Override
	public void addContactBySupplierId(long id, Contact contact) {
		supplierDao.addContactToSupplierId(id, contact);
	}
	@Override
	public List<Contract> listContractsBySupplierId(long id) {
		return supplierDao.contractListBySupplierId(id);
	}
	@Override
	public void addContractBySupplierId(long id, Contract contract) {
		supplierDao.addContractToSupplierId(id, contract);
	}
	
}
