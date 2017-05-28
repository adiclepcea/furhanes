package org.clepcea.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;

@Controller
@RequestMapping("/login")
public class LoginController{
	@RequestMapping("/")
	@ResponseStatus(HttpStatus.UNAUTHORIZED)
	public String Login(Model model,@RequestParam(value="error",required=false) String error){
		if(error!=null){
			model.addAttribute("error",error==""?"Invalid credentials supplied":error);
		}		
		
		return "LoginForm";
	}
}
