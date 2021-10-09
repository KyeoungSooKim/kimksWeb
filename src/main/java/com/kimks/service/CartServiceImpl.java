package com.kimks.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimks.domain.CartListVO;
import com.kimks.domain.CartVO;
import com.kimks.mapper.CartMapper;

import lombok.Setter;

@Service
public class CartServiceImpl implements CartService {

	@Setter(onMethod_ = @Autowired)
	private CartMapper mapper;

	@Override
	public void addCart(CartVO vo) {
		// TODO Auto-generated method stub
		mapper.addCart(vo);
	}

	@Override
	public List<CartListVO> cartList(String u_id) {
		// TODO Auto-generated method stub
		return mapper.cartList(u_id);
	}

	@Override
	public void editAmount(CartVO vo) {
		// TODO Auto-generated method stub
		mapper.editAmount(vo);
	}

	@Override
	public void deleteCart(Long cart_code) {
		// TODO Auto-generated method stub
		mapper.deleteCart(cart_code);
	}

	@Override
	public void deleteCartByUserId(String u_id) {
		// TODO Auto-generated method stub
		mapper.deleteCartByUserId(u_id);
	}

	@Override
	public CartListVO selectCartList(String u_id, Long cart_code) {
		// TODO Auto-generated method stub
		return mapper.selectCartList(u_id, cart_code);
	}

	@Override
	public CartListVO selectCartListCookieId(String cookie_id, Long cart_code) {
		// TODO Auto-generated method stub
		return mapper.selectCartListCookieId(cookie_id, cart_code);
	}
	
	@Override
	public List<CartListVO> cartListCookieId(String cookie_id) {
		// TODO Auto-generated method stub
		return mapper.cartListCookieId(cookie_id);
	}

	@Override
	public void deleteCartByCookieId(String cookie_id) {
		// TODO Auto-generated method stub
		mapper.deleteCartByCookieId(cookie_id);
	}

}
