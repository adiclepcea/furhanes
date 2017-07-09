package org.clepcea.services;

import java.util.List;

import org.clepcea.model.Role;

public interface RoleService {
	public void saveRole(Role role);
	public List<Role> listRoles();
	public void deleteRoleById(long id);
	public Role getRoleById(long id);
}
