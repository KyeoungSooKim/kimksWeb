package com.kimks.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimks.domain.AdminVO;
import com.kimks.mapper.AdminMapper;

import lombok.Setter;

@Service
public class AdminServiceImpl implements AdminService {

	@Setter(onMethod_ = @Autowired)
	private AdminMapper mapper;
	
	@Override
	public AdminVO adminLogin(AdminVO vo) {
		// TODO Auto-generated method stub
		return mapper.adminLogin(vo);
	}

	@Override
	public void loginTimeUpdate(AdminVO vo) {
		// TODO Auto-generated method stub
		mapper.loginTimeUpdate(vo);
	}

	@Override
	public void adminPWChange(AdminVO vo) {
		// TODO Auto-generated method stub
		mapper.adminPWChange(vo);
	}

}
