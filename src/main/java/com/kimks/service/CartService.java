package com.kimks.service;

import java.util.List;

import com.kimks.domain.CartListVO;
import com.kimks.domain.CartVO;

public interface CartService {

	public void addCart(CartVO vo);
	
	public List<CartListVO> cartList(String u_id);
	
	public List<CartListVO> cartListCookieId(String cookie_id);
	
	public void editAmount(CartVO vo);
	
	public void deleteCart(Long cart_code);
	
	public void deleteCartByUserId(String u_id);
	
	public void deleteCartByCookieId(String cookie_id);

	public CartListVO selectCartList(String u_id, Long cart_code);

	public CartListVO selectCartListCookieId(String cookie_id, Long cart_code);
	
}
