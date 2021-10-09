package com.kimks.service;

import java.util.Date;
import java.util.List;

import com.kimks.domain.LoginDTO;
import com.kimks.domain.MemberVO;
import com.kimks.domain.ProductVO;
import com.kimks.util.Criteria;

public interface MemberService {

	public void join(MemberVO vo);
	
	public String idCheck(String u_id);
	
	public MemberVO login(LoginDTO dto);
	
	public void modify(MemberVO vo);
	
	public void delete(LoginDTO dto);
	
	public void changePW(MemberVO vo);
	
	public MemberVO loginCheckWithSessionId(String u_sessionid);
	
	public void keepLogin(String u_id, Date loginlimit, String u_sessionid);

	public int getTotalCount(Criteria cri);
	
	public List<MemberVO> getListWithPaging(Criteria cri);

	public void deleteByAd(String u_id);

	public MemberVO userInfo(String u_id);

	public void modifyByAd(MemberVO vo);

	public MemberVO findPW(String u_id, String u_email);

	public MemberVO findID(MemberVO vo);
}
