package com.kimks.util;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {

	private int startPage; // 블럭에서 첫번째 페이지 정보
	private int endPage; // 블럭에서 마지막 페이지 정보
	private boolean prev, next; // 이전,다음 표시 여부를 가지고 있는 값 
	
	private int total; // 게시판 테이블의 전체 데이타개수
	private Criteria cri;
	private int realEnd;
	public PageDTO(int total, Criteria cri) {
		super();
		this.total = total;
		this.cri = cri;
		
		this.endPage = (int) (Math.ceil(cri.getPageNum() / 5.0)) * 5; 
		 
		this.startPage = this.endPage - 4;
		
		this.realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
	
		if(realEnd <= this.endPage) {
			this.endPage = realEnd;
		}
		this.prev = this.startPage > 1; 
		this.next = this.endPage < realEnd;
	} 
}
