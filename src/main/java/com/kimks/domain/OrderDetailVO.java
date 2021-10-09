package com.kimks.domain;

import lombok.Data;

@Data
public class OrderDetailVO {
//odr_code, pdt_num, odr_amount, odr_price
	private Long odr_code;
	private Long pdt_code;
	private int odr_amount;
	private int odr_price;
}
