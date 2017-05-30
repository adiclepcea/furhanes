package org.clepcea.services;

import java.util.HashMap;
import java.util.List;

import org.clepcea.model.Contact;
import org.clepcea.model.Supplier;

public interface SupplierService {
	
	public void saveSupplier(Supplier supplier);
	public List<Supplier> listSuppliers(int start, int count, HashMap<String, Object> filter);
	public void deleteSupplierById(long id);
	public Supplier getSupplierById(long id);
	public List<Contact> listContactsBySupplierId(long id);
	public void addContactBySupplierId(long id, Contact contact);
}
