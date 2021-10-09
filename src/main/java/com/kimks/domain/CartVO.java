package com.kimks.domain;

import lombok.Data;

@Data
public class CartVO {

	private Long cart_code;
	private Integer pdt_code;
	private String u_id;
	private String cookie_id;
	private Integer cart_amount;
}
