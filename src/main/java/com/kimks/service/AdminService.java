package com.kimks.service;

import com.kimks.domain.AdminVO;

public interface AdminService {

	public AdminVO adminLogin(AdminVO vo);
	
	public void loginTimeUpdate(AdminVO vo);
	
	public void adminPWChange(AdminVO vo);
}
