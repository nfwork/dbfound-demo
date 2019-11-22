package com.nfwork.demo.check;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nfwork.dbfound.core.Context;
import com.nfwork.dbfound.web.base.Interceptor;

public class AccessCheckInterceptor implements Interceptor {

	Map<String, String> map;

	public boolean jspInterceptor(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Object user_id = request.getSession().getAttribute("user_id");

		if (user_id == null) {
			String url = request.getServletPath().substring(1);
			if (check(url)) {
				return true;
			} else {
				request.getRequestDispatcher("/sessionExpire.jsp").forward(
						request, response);
				return false;
			}
		} else {
			return true;
		}
	}
	
	public boolean doInterceptor(Context context, String className,
			String method) throws Exception {
		return true;
	}

	public boolean executeInterceptor(Context context, String modelName,
			String executeName) throws Exception {
		return true;
	}

	public boolean exportInterceptor(Context context, String modelName,
			String queryName) throws Exception {
		return true;
	}

	public boolean queryInterceptor(Context context, String modelName,
			String queryName) throws Exception {
		return true;
	}
	
	public boolean check(String url) {
		if (map.get(url) == null) {
			return false;
		} else {
			return true;
		}
	}

	public void init() {
		map = new HashMap<String, String>();
		map.put("login.jsp", "1");
		map.put("relogin.jsp", "1");
		map.put("close.jsp", "1");
		map.put("loginWindow.jsp", "1");
	}

}
