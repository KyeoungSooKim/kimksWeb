package com.kimks.domain;

import lombok.Data;

@Data
public class CartListVO {
//c.cart_code, c.pdt_num_pk, c.mem_id, c.cart_amount, p.pdt_img, p.pdt_name
	private Integer cart_code;
	private Integer pdt_code;
	private String u_id;
	private Integer cart_amount;
	private String pdt_img;
	private String pdt_name;
	private String pdt_price;
	private Integer pdt_discount;
	private Integer pdt_amount;
}
