package com.nfwork.demo.interceptor;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nfwork.dbfound.core.Context;
import com.nfwork.dbfound.dto.ResponseObject;
import com.nfwork.dbfound.util.JsonUtil;
import com.nfwork.dbfound.web.WebWriter;
import com.nfwork.dbfound.web.base.Interceptor;

public class AccessCheckInterceptor implements Interceptor {

	Map<String, String> map;

	public boolean jspInterceptor(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return check(request, response);
	}
	
	public boolean doInterceptor(Context context, String className,String method) throws Exception {
		return check(context.request, context.response);
	}

	public boolean executeInterceptor(Context context, String modelName,String executeName) throws Exception {
		return check(context.request, context.response);
	}

	public boolean exportInterceptor(Context context, String modelName,String queryName) throws Exception {
		return check(context.request, context.response);
	}

	public boolean queryInterceptor(Context context, String modelName,String queryName) throws Exception {
		return check(context.request, context.response);
	}

	private boolean check(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Object user_id = request.getSession().getAttribute("user_id");
		if (user_id == null) {
			String url = request.getServletPath();
			if(map.get(url) == null){
				if(url.endsWith(".jsp")) {
					request.getRequestDispatcher("/sessionExpire.jsp").forward(request, response);
				}else {
					ResponseObject object = new ResponseObject();
					object.setMessage("登录超时，请重新登录");
					object.setSuccess(false);
					WebWriter.jsonWriter(response, JsonUtil.toJson(object));
				}
				return false;
			}
		}
		return true;
	}

	public void init() {
		map = new HashMap<>();
		map.put("/login.jsp", "1");
		map.put("/relogin.jsp", "1");
		map.put("/close.jsp", "1");
		map.put("/loginWindow.jsp", "1");
		map.put("/login.execute","1");
	}

}
