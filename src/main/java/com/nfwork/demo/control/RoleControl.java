package com.nfwork.demo.control;

import com.nfwork.dbfound.core.Context;
import com.nfwork.dbfound.dto.ResponseObject;
import com.nfwork.dbfound.model.ModelEngine;
import com.nfwork.dbfound.web.base.BaseControl;
import com.nfwork.demo.dto.Role;

public class RoleControl implements BaseControl {

	public ResponseObject query(Context context) throws Exception {
		context.getTransaction().end();
		return ModelEngine.query(context, "sys/role", null, Role.class);
	}

	public ResponseObject save(Context context) throws Exception {
		return ModelEngine.batchExecute(context, "sys/role", null);
	}
	
	public ResponseObject delete(Context context) throws Exception {
		return ModelEngine.batchExecute(context, "sys/role", "delete");
	}

	public ResponseObject execute(Context context) {
		return null;
	}
}
