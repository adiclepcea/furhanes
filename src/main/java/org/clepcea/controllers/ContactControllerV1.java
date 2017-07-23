package org.clepcea.controllers;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.clepcea.model.Contact;
import org.clepcea.services.ContactService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/v1/contacts")
public class ContactControllerV1 {
	private static final Log logger = LogFactory.getLog(ContactControllerV1.class);
	
	@Autowired
	private ContactService contactService;
	
	@PreAuthorize("hasRole('ROLE_RIGHT_CONTACTS_W')")
	@RequestMapping(value="/{id}", method=RequestMethod.DELETE)
	public Object delete(@PathVariable long id, HttpServletResponse response){
		logger.info("deleteContact Called");
		contactService.deleteContactById(id);
		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		return null;
	}
	
	@PreAuthorize("hasRole('ROLE_RIGHT_CONTACTS_W')")
	@RequestMapping(value="/{id}", method=RequestMethod.PUT,consumes="application/json",produces="application/json")
	@ResponseBody
	public Object saveContact(@RequestBody Contact contact, HttpServletResponse response){
		logger.info("saveContact Called");
		contactService.saveContact(contact);
		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		return null;
	}
}
