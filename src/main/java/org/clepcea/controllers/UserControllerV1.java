package org.clepcea.controllers;

import java.util.List;

import org.clepcea.model.PasswordEncoderImpl;
import org.clepcea.model.Role;
import org.clepcea.model.User;
import org.clepcea.services.RoleService;
import org.clepcea.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value="/v1/users")
public class UserControllerV1 {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private RoleService roleService;

	
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public List<User> getUsersList(ModelMap model){
		
		List<User> lstUsers = userService.listUsers(); 
		
		return lstUsers;
	}
	
	@GetMapping(value="/{id}")
	public User getUserById(@PathVariable("id") int id){
		return userService.getUserById(id);
		
	}
	
	@RequestMapping(value="/{id}", method=RequestMethod.PUT,consumes="application/json",produces="application/json")
	public User saveUser(@RequestBody User user){
		
		if(user.getUsername()==null){
			return null;
		}
		
		if(user.getPass()!=null){
			user.setPass(PasswordEncoderImpl.sha256(user.getPass()));
		}
		
		return userService.saveUser(user);
	}
	
	@PostMapping(value="",consumes="application/json",produces="application/json")
	public User addUser(@RequestBody User user){
		if(user.getPass()!=null){
			user.setPass(PasswordEncoderImpl.sha256(user.getPass()));
		}
		return userService.saveUser(user);
	}
	
	
	@DeleteMapping(value="/{id}")
	public void deleteUser(@PathVariable("id") int id){
		userService.deleteUserById(id);
	}
	
	@RequestMapping(value="/roles", method=RequestMethod.GET)
	public List<Role> getRolesList(ModelMap model){
		
		List<Role> lstRoles = roleService.listRoles(); 
		
		return lstRoles;
	}
	
	@GetMapping(value="/roles/{id}")
	public Role getRoleById(@PathVariable("id") int id){
		return roleService.getRoleById(id);
	}
	
	@RequestMapping(value="/roles/{id}", method=RequestMethod.PUT,consumes="application/json",produces="application/json")
	public Role saveRole(@RequestBody Role role){
		
		if(role.getName()==null){
			return null;
		}
		
		return roleService.saveRole(role);
	}
	
	@PostMapping(value="/roles",consumes="application/json",produces="application/json")
	public Role addRole(@RequestBody Role role){
		return roleService.saveRole(role);
	}
	
	@DeleteMapping(value="/roles/{id}")
	public void deleteRole(@PathVariable("id") int id){
		roleService.deleteRoleById(id);
	}
	
}
