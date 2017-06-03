package org.clepcea.controllers;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.clepcea.model.Contract;
import org.clepcea.services.ContractService;
import org.clepcea.services.FileUploadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/v1/contracts")
public class ContractControllerV1 {
private static final Log logger = LogFactory.getLog(ContractController.class);
	
	@Autowired
	private ContractService contractService;
	@Autowired
	private FileUploadService fileUploadService;
	
	@RequestMapping(value="/{id}", method=RequestMethod.DELETE)
	public Object deleteContract(@PathVariable long id, HttpServletResponse response){
		logger.info("deleteContract Called");
		deleteScan(id, response);
		contractService.deleteContractById(id);
		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		return null;
	}
	
	@RequestMapping(value="/{id}", method=RequestMethod.PUT,consumes="application/json",produces="application/json")
	@ResponseBody
	public Object saveContract(@RequestBody Contract contract, HttpServletResponse response){
		logger.info("saveContact Called");		
		Contract c = contractService.getContractById(contract.getId());
		contract.setSupplier(c.getSupplier());
		contractService.saveContract(contract);
		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		return null;
	}
	
	@RequestMapping(value="/{id}/file",method=RequestMethod.DELETE)
	public Object  deleteScan(@PathVariable long id,HttpServletResponse response){
		logger.info("Delete  contract file called");		
		Contract c = contractService.getContractById(id);
		String f = null;
		if(c!=null){
			f = c.getScanFile();
			String err = null;
			try{
				if(f!=null){
					fileUploadService.deleteUploadedFile(f);
				}
			}catch(NullPointerException npex){				
				err=npex.getMessage();
			}catch(IOException ioex){
				err="Could not delete the file";
			}
			if(err!=null){
				try{
					response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
					response.getWriter().print(err);
					response.flushBuffer();
					return null;
				}catch(IOException ioex){}
			}
		}
		
		if(f!=null){
			c.setOriginalFileName(null);
			c.setScanFile(null);
			contractService.saveContract(c);
		}
		
		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		return null;
	}
	
}
