package org.clepcea.controllers;


import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.clepcea.model.Contact;
import org.clepcea.model.Supplier;
import org.clepcea.services.SupplierService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value="/suppliers")
public class SupplierController {
	private static final Log logger = LogFactory.getLog(SupplierController.class);
	
	@Autowired
	private SupplierService supplierService;
	
	@PreAuthorize("hasRole('ROLE_RIGHT_SUPPLIERS')")
	@RequestMapping(value="/input",method=RequestMethod.GET)
	public String inputFurnizor(Model model,HttpSession session,@RequestParam(value="id", required=false) Long id){
		logger.info("Input supplier called");
		Supplier supplier;
		if(id!=null){
			supplier = supplierService.getSupplierById(id);
		}else{
			supplier = new Supplier();
		}
		model.addAttribute("supplier",supplier);
		return "SupplierForm";
	}
		
	@RequestMapping(value="/", method=RequestMethod.POST, consumes="application/json",produces="application/json")
	@ResponseBody
	public Supplier saveSupplier(@RequestBody Supplier supplier){
		logger.info("Create supplier called");
		supplierService.saveSupplier(supplier);
		return supplier;
	}
	
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	public String getSupplier(HttpSession session, @PathVariable long id){
		return "";
	}
	
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String filterSuppliers(ModelMap model,
			@RequestParam(value="startFrom",  required=false) Integer startFrom,
			@RequestParam(value="count",  required=false) Integer count){
		
		if(startFrom==null){
			startFrom = 0;
		}
		if(count==null){
			count = 0;
		}
		logger.info("list suppliers called "+startFrom+", count="+count);
		model.addAttribute("suppliers", supplierService.listSuppliers(startFrom, count, null));
		return "SupplierList";
	}
	
	@RequestMapping(value="/{id}",method=RequestMethod.DELETE)
	public Object deleteSupplier(@PathVariable long id,HttpServletResponse response){
		logger.info("Delete supplier called");
		supplierService.deleteSupplierById(id);
		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		return null;
	}
	
	@RequestMapping(value="/{id}",method=RequestMethod.PUT)
	@ResponseBody
	public Supplier modifySupplier(@RequestBody Supplier supplier, @PathVariable long id){
		logger.info("Modify supplier called");
		supplierService.saveSupplier(supplier);
		return supplier;
	}
	
	@RequestMapping(value="/{id}/contacts",method=RequestMethod.GET)
	public String getContacts(ModelMap model, @PathVariable long id){
		 model.addAttribute("contacts",supplierService.listContactsBySupplierId(id));
		 model.addAttribute("supplier_id",id);
		 return "ContactList";
	}
	
	@RequestMapping(value="/{id}/contacts",method=RequestMethod.POST)
	public Object  addContact(@RequestBody Contact contact,  @PathVariable long id,HttpServletResponse response){
		logger.info("Add contact to supplier called");
		supplierService.addContactBySupplierId(id, contact);
		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		return null;
	}
	
}
