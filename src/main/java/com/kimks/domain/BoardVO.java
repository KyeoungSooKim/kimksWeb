package com.kimks.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {

	private Long bno;
	private int cate_code;
	private int cate_prt;
	private String title;
	private String writer;
	private String city;
	private Long price;
	private String content;
	private String img_name;
	private String soldout;
	private Long hit;
	private Date regdate;
	private Date updatedate;
}
