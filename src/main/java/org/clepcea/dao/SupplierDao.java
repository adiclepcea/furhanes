package org.clepcea.dao;

import java.util.List;

import org.clepcea.model.Supplier;

public interface SupplierDao {
	public void save(Supplier supplier);
	public List<Supplier> list(int start,int count);
	public void deleteById(long id);
	public Supplier getById(long id);
}
