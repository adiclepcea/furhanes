package org.clepcea.services;

import java.util.List;

import org.clepcea.model.User;

public interface UserService {
	public User saveUser(User user);
	public List<User> listUsers();
	public void deleteUserById(long id);
	public User getUserById(long id);
	
}
