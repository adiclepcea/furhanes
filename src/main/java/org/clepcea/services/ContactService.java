package org.clepcea.services;

import java.util.HashMap;
import java.util.List;

import org.clepcea.model.Contact;

public interface ContactService {
	public void saveContact(Contact contact);
	public List<Contact> listContacts(int start, int count, HashMap<String,Object> filter);
	public Contact getContactById(long id);
	public void deleteContactById(long id);
}
