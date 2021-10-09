package com.kimks.util;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
@WebListener
public class SessionConfig implements HttpSessionListener {

	//중복로그인 방지
	//현재접속자수, 전체방문자 수
	private static int currentCount;
	private static int visitTotalCount;
	
	public static int getCurrentCount() {
		return currentCount;
	}
	public static int getVisitTotalCount() {
		return visitTotalCount;
	}

	private static final Map<String, HttpSession> sessions = new ConcurrentHashMap<>();
	
	public synchronized static String getSessionCheck(String type, String compareId) {
		String result = "";
		for(String key : sessions.keySet()) {
			HttpSession value = sessions.get(key);
			if(value != null && value.getAttribute(type) != null && value.getAttribute(type).toString().equals(compareId)) {
				System.out.println(value.getAttribute(type).toString());
				result = key.toString();
			}
		}
		removeSessionForDoubleLogin(result);
		return result;
	}
	
	private static void removeSessionForDoubleLogin(String result) {
		// TODO Auto-generated method stub
		if(result != null && result.length() > 0) {
			sessions.get(result).invalidate(); //로그인 세션 소멸
			sessions.remove(result); //맵에서 제거
		}
	}
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		// TODO Auto-generated method stub
		System.out.println("sessionCreated"+se);
		sessions.put(se.getSession().getId(), se.getSession());
		currentCount++;
		visitTotalCount++;
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		// TODO Auto-generated method stub
		System.out.println("sessionDestroyed");
		if(sessions.get(se.getSession().getId()) != null) {
			sessions.get(se.getSession().getId()).invalidate();
			sessions.remove(se.getSession().getId());
		}
		sessions.remove(se.getSession().getId());
		currentCount--;
	}

}
