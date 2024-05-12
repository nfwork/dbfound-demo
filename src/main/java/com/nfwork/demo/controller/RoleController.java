package com.nfwork.demo.controller;

import com.nfwork.dbfound.core.Context;
import com.nfwork.dbfound.dto.ResponseObject;
import com.nfwork.dbfound.model.ModelEngine;
import com.nfwork.dbfound.web.base.ActionController;
import com.nfwork.dbfound.web.base.ActionMapping;
import com.nfwork.dbfound.web.base.ActionTransactional;
import com.nfwork.demo.entity.Role;

@ActionMapping("sys/role")
public class RoleController implements ActionController {

	public ResponseObject query(Context context){
		return ModelEngine.query(context, "sys/role", null, Role.class);
	}

	@ActionTransactional
	public ResponseObject save(Context context){
		return ModelEngine.batchExecute(context, "sys/role", null);
	}

	@ActionTransactional
	public ResponseObject delete(Context context){
		return ModelEngine.batchExecute(context, "sys/role", "delete");
	}

}
