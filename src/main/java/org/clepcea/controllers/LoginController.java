package org.clepcea.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/login")
public class LoginController {
	@RequestMapping("/")
	public String Login(Model model,@RequestParam(value="error",required=false) String error){
		if(error!=null){
			model.addAttribute("error",error==""?"Invalid credentials supplied":error);
		}		
		return "LoginForm";
	}
}
