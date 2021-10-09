package com.kimks.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {

	private int rv_num;
	private String u_id;
	private Integer pdt_code;
	private String rv_content;
	private int rv_score;
	private Date rv_regdate;
}
