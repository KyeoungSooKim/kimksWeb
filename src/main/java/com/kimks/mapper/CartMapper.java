package com.kimks.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kimks.domain.CartListVO;
import com.kimks.domain.CartVO;

public interface CartMapper {

	public void addCart(CartVO vo);
	
	public List<CartListVO> cartList(String u_id);
	
	public List<CartListVO> cartListCookieId(String cookie_id);
	
	public CartListVO selectCartList(@Param("u_id") String u_id,@Param("cart_code") Long cart_code);
	
	public CartListVO selectCartListCookieId(@Param("cookie_id") String cookie_id,@Param("cart_code") Long cart_code);
	
	public void editAmount(CartVO vo);
	
	public void deleteCart(Long cart_code);
	
	public void deleteCartByUserId(String u_id);
	
	public void deleteCartByCookieId(String cookie_id);

}
