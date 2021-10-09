package com.kimks.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimks.domain.LoginDTO;
import com.kimks.domain.MemberVO;
import com.kimks.mapper.MemberMapper;
import com.kimks.util.Criteria;

import lombok.Setter;

@Service
public class MemberSerivceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Override
	public void join(MemberVO vo) {
		// TODO Auto-generated method stub
		mapper.join(vo);
	}

	@Override
	public String idCheck(String u_id) {
		// TODO Auto-generated method stub
		return mapper.idCheck(u_id);
	}

	@Override
	public MemberVO login(LoginDTO dto) {
		// TODO Auto-generated method stub
		return mapper.login(dto);
	}

	@Override
	public void modify(MemberVO vo) {
		// TODO Auto-generated method stub
		mapper.modify(vo);
	}

	@Override
	public void delete(LoginDTO dto) {
		// TODO Auto-generated method stub
		mapper.delete(dto);
	}

	@Override
	public void changePW(MemberVO vo) {
		// TODO Auto-generated method stub
		mapper.changePW(vo);
	}

	@Override
	public MemberVO loginCheckWithSessionId(String u_sessionid) {
		// TODO Auto-generated method stub
		return mapper.loginCheckWithSessionId(u_sessionid);
	}

	@Override
	public void keepLogin(String u_id, Date loginlimit, String u_sessionid) {
		// TODO Auto-generated method stub
		mapper.keepLogin(u_id, loginlimit, u_sessionid);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<MemberVO> getListWithPaging(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getListWithPaging(cri);
	}

	@Override
	public void deleteByAd(String u_id) {
		// TODO Auto-generated method stub
		mapper.deleteByAd(u_id);
	}

	@Override
	public MemberVO userInfo(String u_id) {
		// TODO Auto-generated method stub
		return mapper.userInfo(u_id);
	}

	@Override
	public void modifyByAd(MemberVO vo) {
		// TODO Auto-generated method stub
		mapper.modifyByAd(vo);
	}

	@Override
	public MemberVO findID(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.findID(vo);
	}

	@Override
	public MemberVO findPW(String u_id, String u_email) {
		// TODO Auto-generated method stub
		return mapper.findPW(u_id, u_email);
	}

}
