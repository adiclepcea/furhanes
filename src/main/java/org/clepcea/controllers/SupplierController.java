package org.clepcea.controllers;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.clepcea.model.Supplier;
import org.clepcea.services.SupplierService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	@PreAuthorize("hasRole('ROLE_RIGHT_SUPPLIERS')")
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String filterSuppliers(ModelMap model,
			@RequestParam(value="startFrom",  required=false) Integer startFrom,
			@RequestParam(value="count",  required=false) Integer count,
			@RequestParam(value="name", required=false) String name){
		
		logger.info("list suppliers called ");
		
		if(startFrom==null){
			startFrom = 0;
		}
		
		if(count==null){
			count = 0;
		}
		
		model.addAttribute("request_count",count);
		if(name!=null){
			HashMap<String, Object> filter = new HashMap<>();
			filter.put("name", name);
			model.addAttribute("suppliers", supplierService.listSuppliers(startFrom, count, filter));
			model.addAttribute("filter",name);
		}else{
			model.addAttribute("suppliers", supplierService.listSuppliers(startFrom, count, null));
			model.addAttribute("filter","");
		}
		
		return "SupplierList";
	}
	
	@PreAuthorize("hasRole('ROLE_RIGHT_CONTACTS')")
	@RequestMapping(value="/{id}/contacts",method=RequestMethod.GET)
	public String getContacts(ModelMap model, @PathVariable long id){
		 model.addAttribute("contacts",supplierService.listContactsBySupplierId(id));
		 model.addAttribute("supplier_id",id);
		 return "ContactList";
	}
	
	@PreAuthorize("hasRole('ROLE_RIGHT_CONTRACTS')")
	@RequestMapping(value="/{id}/contracts",method=RequestMethod.GET)
	public String getContracts(ModelMap model, @PathVariable long id){
		 model.addAttribute("contracts",supplierService.listContractsBySupplierId(id));
		 model.addAttribute("supplier_id",id);
		 return "ContractList";
	}
	
}
