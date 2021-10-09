package com.kimks.domain;

import java.util.Date;

import lombok.Data;
@Data
public class MemberVO {
	
	private String u_id;
	private String u_name;
	private String u_pw;
	private String u_email;
	private String u_zipcode;
	private String u_addr;
	private String u_addr_d;
	private String u_phone;
	private Date u_regdate;
	private Date u_updatedate;
	private String u_sessionid;
	private Date u_loginlimit;
}
