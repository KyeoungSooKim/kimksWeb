package com.kimks.mapper;

import com.kimks.domain.AdminVO;

public interface AdminMapper {

	public AdminVO adminLogin(AdminVO vo);
	
	public void loginTimeUpdate(AdminVO vo);
	
	public void adminPWChange(AdminVO vo);
}
