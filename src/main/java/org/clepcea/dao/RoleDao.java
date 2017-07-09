package org.clepcea.dao;

import java.util.List;

import org.clepcea.model.Role;

public interface RoleDao {
	public void save(Role role);
	public List<Role> list();
	public void deleteById(long id);
	public Role getById(long id);
}
