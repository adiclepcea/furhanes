package org.clepcea.services;

import java.util.HashMap;
import java.util.List;

import org.clepcea.dao.ContactDao;
import org.clepcea.model.Contact;
import org.springframework.beans.factory.annotation.Autowired;

public class ContactServiceImpl implements ContactService {

	@Autowired
	private ContactDao contactDao;
	
	public void setContactDao(ContactDao contactDao) {
		this.contactDao = contactDao;
	}
	
	@Override
	public void saveContact(Contact contact) {
		contactDao.save(contact);
	}

	@Override
	public List<Contact> listContacts(int start, int count, HashMap<String, Object> filter) {
		return contactDao.list(start, count);
	}

	@Override
	public Contact getContactById(long id) {
		return contactDao.getById(id);
	}

	@Override
	public void deleteContactById(long id) {
		contactDao.deleteById(id);
	}

}
