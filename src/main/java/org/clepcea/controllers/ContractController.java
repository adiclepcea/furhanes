package org.clepcea.controllers;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.clepcea.model.Contract;
import org.clepcea.services.ContractService;
import org.clepcea.services.FileUploadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/contracts")
public class ContractController {
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
		contractService.saveContract(contract);
		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		return null;
	}
	
	@RequestMapping(value="/{id}/file",method=RequestMethod.POST)
	public Object  addScan(@RequestParam MultipartFile file,  @PathVariable long id,HttpServletResponse response){
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
				}catch(IOException ioex){}
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
	@RequestMapping(value="{id}/download", method=RequestMethod.GET)
	public void getContractFile(@PathVariable long id, HttpServletResponse response){
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
			
				InputStream is = new FileInputStream(scanFile);
				org.apache.commons.io.IOUtils.copy(is, response.getOutputStream());
			}catch(IOException ioex){
				logger.warn("Error downloadin file");
				logger.warn(ioex.getMessage());
			}
		}
		
	}
}
