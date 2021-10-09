package com.kimks.domain;

import lombok.Data;

@Data
public class UserOrderDetailInfoVO {
//od.odr_code, od.pdt_num, od.odr_amount, od.odr_price, p.pdt_name, p.pdt_img
	
	private Long odr_code;
	private Long pdt_code;
	private int odr_amount;
	private int odr_price;
	private String pdt_name;
	private String pdt_img;
	private String rv_check;
}
