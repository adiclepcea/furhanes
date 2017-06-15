package org.clepcea.controllers;

import java.util.Arrays;
import java.util.List;

import org.clepcea.model.User;
import org.clepcea.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/users")
public class UsersController {
	
	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String getUsersList(ModelMap model){
		
		List<User> lstUsers = userService.listUsers(); 
		
		model.addAttribute("users",lstUsers);
		
		return "UsersList";
	}
}
