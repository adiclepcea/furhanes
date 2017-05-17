package org.clepcea.controllers;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.clepcea.model.Supplier;
import org.omg.CORBA.Request;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/suppliers")
public class SupplierController {
	private static final Log logger = LogFactory.getLog(SupplierController.class);
	
	@RequestMapping(value="/input",method=RequestMethod.GET)
	public String inputFurnizor(Model model){
		logger.info("Create supplier called");
		model.addAttribute("supplier",new Supplier());
		return "SupplierForm";
	}
	
	@RequestMapping(value="/", method=RequestMethod.POST)
	public String saveSupplier(Model model){
		return "SupplierDetails";
	}
	
	@RequestMapping(value="/id",method=RequestMethod.GET)
	public String getSupplier(HttpSession session){
		return "";
	}
	
	@RequestMapping(value="/filter",method=RequestMethod.GET)
	public String filterSuppliers(HttpSession session){
		return "";
	}
	
	@RequestMapping(value="/id",method=RequestMethod.DELETE)
	public String deleteSupplier(HttpSession session){
		return "";
	}
	
	@RequestMapping(value="/id",method=RequestMethod.PUT)
	public String modifySupplier(HttpSession session){
		return "";
	}
	
}
