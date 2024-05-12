package com.nfwork.demo.controller;

import com.nfwork.dbfound.core.Context;
import com.nfwork.dbfound.core.DBFoundConfig;
import com.nfwork.dbfound.dto.ResponseObject;
import com.nfwork.dbfound.web.base.ActionController;
import com.nfwork.dbfound.web.base.ActionMapping;

@ActionMapping("log")
public class LogController implements ActionController {

    @Override
    public ResponseObject execute(Context context) throws Exception {
        Integer open = context.getInt("param.open");
        if(open!= null) {
            DBFoundConfig.setOpenLog(open == 1);
        }
        return new ResponseObject();
    }
}
