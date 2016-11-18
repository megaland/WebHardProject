package com.usnschool.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

public class LoginInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession httpsession = request.getSession();
		if(httpsession.getAttribute("login") == null){
			Cookie cookie = WebUtils.getCookie(request, "logincookie");
			Cookie gradecookie = WebUtils.getCookie(request, "gradecookie");
			Cookie pointcookie = WebUtils.getCookie(request, "pointcookie");
			if(cookie != null){
				httpsession.setAttribute("login", cookie.getValue());
				httpsession.setAttribute("grade", gradecookie.getValue());
				httpsession.setAttribute("point", pointcookie.getValue());
			}
		}
		return true;
	}

}
