package org.clepcea.controllers;


import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.clepcea.model.Contract;
import org.clepcea.services.ContractService;
import org.clepcea.services.FileUploadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/contracts")
public class ContractController {
	private static final Log logger = LogFactory.getLog(ContractController.class);
	
	@Autowired
	private ContractService contractService;
	@Autowired
	private FileUploadService fileUploadService;
	
	
	@RequestMapping(value="/{id}/file",method=RequestMethod.POST)
	public Object  addScan(@RequestParam MultipartFile file,  @PathVariable long id,HttpServletResponse response) {
		logger.info("Allocate file to contract called with "+fileUploadService.getFileExtension(file.getOriginalFilename()));			
		Contract c = contractService.getContractById(id);
		String fileName = null;
		if(c!=null){
			String f = c.getScanFile();
			String err = null;
			try{
				if(f!=null){
					fileUploadService.deleteUploadedFile(f);
				}
				fileName = fileUploadService.uploadFile(file, "contracts", ""+id+"."+fileUploadService.getFileExtension(file.getOriginalFilename()));				
			}catch(NullPointerException npex){				
				err=npex.getMessage();
			}catch(IOException ioex){
				err="Could not save the file";
			}
			if(err!=null){
				try{
					response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
					response.getWriter().print(err);
					response.flushBuffer();
					return null;
				}catch(IOException ioex){return null;}
			}
		}
		
		if(fileName!=null){
			c.setOriginalFileName(file.getOriginalFilename());
			c.setScanFile(fileName);
			contractService.saveContract(c);
		}
		
		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		return null;
	}
	
	@RequestMapping(value="{id}/download", method=RequestMethod.GET)
	public void getScantFile(@PathVariable long id, HttpServletResponse response){
		Contract c = contractService.getContractById(id);
		String fileName = c.getScanFile(); 
		if(fileName!=null){
			try{
				File scanFile = new File(fileName);
				if(!scanFile.exists()){
					response.setStatus(HttpServletResponse.SC_NOT_FOUND);
					response.getWriter().println("The contract file could not be found!");
					response.flushBuffer();
					return;
				}
				response.addHeader("Content-Disposition ", "attachment;filename=\""+c.getOriginalFileName()+"\"");
				InputStream is = new FileInputStream(scanFile);
				org.apache.commons.io.IOUtils.copy(is, response.getOutputStream());
			}catch(IOException ioex){
				logger.warn("Error downloadin file");
				logger.warn(ioex.getMessage());
			}
		}
	}
	
	private boolean isInteger(String str){
		return str.matches("^[0-9]{1,10}$");
	}
	
	@RequestMapping(value="list", method=RequestMethod.GET)
	public String getContractList(ModelMap model,
			//@RequestParam(value="startFrom",  required=false) Integer startFrom,
			//@RequestParam(value="count",  required=false) Integer count,
			//@RequestParam(value="order", required=false) String order,
			@RequestParam Map<String, Object> filter){
		
		int startFrom=0;
		int count=0;
		model.addAttribute("supplier_id",0);
		//if(startFrom==null){
		//	startFrom=0;
		//}
		//if(count==null){
		//	count=0;
		//}
		Map<String,Object> passFilter=null;
		if(filter!=null){
			logger.info(filter);			
			if(filter.containsKey("startFrom") && isInteger(filter.get("startFrom").toString())){
				startFrom = Integer.parseInt(filter.get("startFrom").toString());
			}
			if(filter.containsKey("count") && isInteger(filter.get("count").toString())){
				count = Integer.parseInt(filter.get("count").toString());
			}
			passFilter = filter.entrySet().stream().filter(it->it.getKey().equals("expired") || it.getKey().equals("expiring")).collect(Collectors.toMap(it->it.getKey(),it->it.getValue()));
			
		}
		model.addAttribute("contracts", contractService.listContracts(startFrom, count, passFilter));
		model.addAttribute("expired", passFilter!=null && passFilter.containsKey("expired") && passFilter.get("expired").equals("true"));
		model.addAttribute("expiring", passFilter!=null && passFilter.containsKey("expiring") && passFilter.get("expiring").equals("true"));
		return "ContractList";
	}
	
}
