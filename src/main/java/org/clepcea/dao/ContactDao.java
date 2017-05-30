package org.clepcea.dao;

import java.util.List;

import org.clepcea.model.Contact;

public interface ContactDao {
	public void save(Contact contact);
	public List<Contact> list(int start,int count);
	public void deleteById(long id);
	public Contact getById(long id);
}
