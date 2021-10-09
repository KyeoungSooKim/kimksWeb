package com.kimks.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BannerVO {

	//bn_code, bn_name, bn_img, bn_regdate
	private Long bn_code;
	private String bn_name;
	private String bn_img;
	private Date bn_regdate;
	private Integer bn_order;
	
	private MultipartFile file1;
}
