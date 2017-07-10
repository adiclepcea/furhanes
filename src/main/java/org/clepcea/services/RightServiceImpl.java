package org.clepcea.services;

import java.util.List;

import org.clepcea.dao.RightDao;
import org.clepcea.model.Right;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RightServiceImpl implements RightService {

	@Autowired
	RightDao rightDao;
	
	@Override
	public List<Right> listRights() {
		return rightDao.list();
	}

}
