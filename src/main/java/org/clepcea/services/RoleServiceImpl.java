package org.clepcea.services;

import java.util.List;

import org.clepcea.dao.RoleDao;
import org.clepcea.model.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RoleServiceImpl implements RoleService {

	@Autowired
	RoleDao roleDao;
	
	@Override
	public Role saveRole(Role role) {
		roleDao.save(role);
		return roleDao.getById(role.getId());
	}

	@Override
	public List<Role> listRoles() {
		return roleDao.list();
	}

	@Override
	public void deleteRoleById(long id) {
		roleDao.deleteById(id);

	}

	@Override
	public Role getRoleById(long id) {
		return roleDao.getById(id);
	}

}
