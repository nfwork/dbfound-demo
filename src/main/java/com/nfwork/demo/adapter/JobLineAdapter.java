package com.nfwork.demo.adapter;

import com.nfwork.dbfound.core.Context;
import com.nfwork.dbfound.model.ModelEngine;
import com.nfwork.dbfound.model.adapter.MapQueryAdapter;
import com.nfwork.dbfound.model.bean.Param;
import com.nfwork.dbfound.util.TransactionUtil;

import java.util.Map;

public class JobLineAdapter implements MapQueryAdapter {

    @Override
    public void beforeQuery(Context context, Map<String, Param> params) {
        try {
            TransactionUtil.execute(context,()->ModelEngine.execute(context, "job/jobLine", "init"));
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}