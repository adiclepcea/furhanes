package org.clepcea.services;

import java.util.List;

import org.clepcea.dao.UserDao;
import org.clepcea.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;
	
	@Override
	public User saveUser(User user) {
		return userDao.save(user);
	}

	@Override
	public List<User> listUsers() {
		return userDao.list();
	}

	@Override
	@Transactional
	public void deleteUserById(long id) {
		User u = userDao.getById(id);
		if(u!=null){
			u.setEnabled(false);
		}
		userDao.save(u);

	}

	@Override
	public User getUserById(long id) {
		return userDao.getById(id);
	}

}
