package org.clepcea.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.clepcea.model.Contact;
import org.clepcea.model.Contract;
import org.clepcea.model.Supplier;
import org.clepcea.services.SupplierService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/v1/suppliers")
public class SuppliersControllerV1 {
	
	private static final Log logger = LogFactory.getLog(SuppliersControllerV1.class);
	
	@Autowired
	private SupplierService supplierService;
	
	@RequestMapping(value="/filter",method=RequestMethod.GET, produces="application/json")
	@ResponseBody
	public List<Supplier> getSupplierList(@RequestParam(value="name",  required=false) String supplierName){
		logger.info("v1-Get supplierlist called");
		
		HashMap<String,Object> filter = new HashMap<>();
		if(supplierName!=null){
			filter.put("name", supplierName);
		}
		
		return supplierService.listSuppliers(0, 50, filter);
	}
	
	@RequestMapping(value="/", method=RequestMethod.POST, consumes="application/json",produces="application/json")
	@ResponseBody
	public Supplier saveSupplier(@RequestBody Supplier supplier){
		logger.info("v1-Create supplier called");
		supplierService.saveSupplier(supplier);
		return supplier;
	}
	
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	public String getSupplier(HttpSession session, @PathVariable long id){
		return "";
	}
	
	@RequestMapping(value="/{id}",method=RequestMethod.DELETE)
	public Object deleteSupplier(@PathVariable long id,HttpServletResponse response){
		logger.info("v1-Delete supplier called");
		supplierService.deleteSupplierById(id);
		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		return null;
	}
	
	@RequestMapping(value="/{id}",method=RequestMethod.PUT)
	@ResponseBody
	public Supplier modifySupplier(@RequestBody Supplier supplier, @PathVariable long id){
		logger.info("v1-Modify supplier called");
		supplierService.saveSupplier(supplier);
		return supplier;
	}
	
	@RequestMapping(value="/{id}/contacts",method=RequestMethod.POST)
	public Object  addContact(@RequestBody Contact contact,  @PathVariable long id,HttpServletResponse response){
		logger.info("v1-Add contact to supplier called");
		supplierService.addContactBySupplierId(id, contact);
		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		return null;
	}
	
	@RequestMapping(value="/{id}/contracts",method=RequestMethod.POST)
	public Object  addContract(@RequestBody Contract contract,  @PathVariable long id,HttpServletResponse response){
		logger.info("v1-Add contract to supplier called");
		supplierService.addContractBySupplierId(id, contract);
		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		return null;
	}
}
