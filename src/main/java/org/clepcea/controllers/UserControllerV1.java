package org.clepcea.controllers;

import java.util.List;

import org.clepcea.model.PasswordEncoderImpl;
import org.clepcea.model.User;
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
		System.out.println(user.getFirstName());
		System.out.println(user.getLastName());
		System.out.println(user.getUsername());
		System.out.println(user.getId());
		if(user.getPass()!=null){
			user.setPass(PasswordEncoderImpl.sha256(user.getPass()));
		}
		return userService.saveUser(user);
	}
	
	
	@DeleteMapping(value="/{id}")
	public void deleteUser(@PathVariable("id") int id){
		userService.deleteUserById(id);
	}
	
}
