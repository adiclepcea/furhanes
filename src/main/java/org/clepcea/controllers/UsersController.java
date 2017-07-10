package org.clepcea.controllers;

import java.util.List;

import org.clepcea.model.Right;
import org.clepcea.model.Role;
import org.clepcea.model.User;
import org.clepcea.services.RightService;
import org.clepcea.services.RoleService;
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
	
	@Autowired
	private RoleService roleService;
	
	@Autowired
	private RightService rightService;
	
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String getUsersList(ModelMap model){
		
		List<User> lstUsers = userService.listUsers(); 
		List<Role> lstRoles = roleService.listRoles();
		List<Right> lstRights = rightService.listRights();
		
		model.addAttribute("users",lstUsers);
		model.addAttribute("roles",lstRoles);
		model.addAttribute("rights",lstRights);
		
		return "UsersList";
	}

	
}
