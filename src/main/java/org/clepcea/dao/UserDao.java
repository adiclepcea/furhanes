package org.clepcea.dao;

import java.util.List;

import org.clepcea.model.User;

public interface UserDao {
	public void save(User user);
	public List<User> list();
	public void deleteById(long id);
	public User getById(long id);
}
