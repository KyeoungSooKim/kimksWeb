package com.kimks.util;
//페이지, 검색 정보 저장을 위한 클래스

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class Criteria {

	private int pageNum; //클릭한 번호가 파라미터로 전송될 때 받기위함
	private int amount; //페이지당 출력될 게시물 갯수
	
	private String type; //검색타입
	private String keyword; //검색어
	

	public Criteria() {
		this(1,5);
	}
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}

	public String[] getTypeArr() {
		return type == null? new String[] {} : type.split("");
	}
	
}
