package com.kimks.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OrderVO {

	private Long odr_code;
	private String u_id;
	private String cookie_id;
	private String odr_name;
	private String odr_zipcode;
	private String odr_addr;
	private String odr_addr_d;
	private String odr_phone;
	private int odr_total_price;
	private Date odr_date;
	private int odr_count;
	private String odr_delivery;
}
