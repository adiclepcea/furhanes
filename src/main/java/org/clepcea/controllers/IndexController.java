package org.clepcea.controllers;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/")
public class IndexController {
	private static final Log logger = LogFactory.getLog(IndexController.class);
	
	@RequestMapping(value="",method=RequestMethod.GET)
	public String index(){
		return "index";
	}
}
