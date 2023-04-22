package com.nfwork.demo.adapter;

import com.nfwork.dbfound.core.Context;
import com.nfwork.dbfound.core.DBFoundConfig;
import com.nfwork.dbfound.model.adapter.ExecuteAdapter;
import com.nfwork.dbfound.model.bean.Param;

import java.util.Map;

public class LogAdapter implements ExecuteAdapter {

    @Override
    public void beforeExecute(Context context, Map<String, Param> params) {
        DBFoundConfig.setOpenLog("1".equals(params.get("open").getValue()));
    }
}
