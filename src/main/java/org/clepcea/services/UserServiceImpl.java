package org.clepcea.services;

import java.util.List;

import org.clepcea.dao.UserDao;
import org.clepcea.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;
	
	@Override
	public void saveUser(User user) {
		userDao.save(user);
	}

	@Override
	public List<User> listUsers() {
		return userDao.list();
	}

	@Override
	public void deleteUserById(long id) {
		userDao.deleteById(id);

	}

	@Override
	public User getUserById(long id) {
		return userDao.getById(id);
	}

}
