package com.nfwork.demo.adapter;

import com.nfwork.dbfound.core.Context;
import com.nfwork.dbfound.model.adapter.ExecuteAdapter;
import com.nfwork.dbfound.model.bean.Param;
import com.nfwork.dbfound.web.file.FilePart;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class UploadAdapter implements ExecuteAdapter {

    @Override
    public void beforeExecute(Context context, Map<String, Param> params) {
        Object object = context.getData("param.files");
        if(object instanceof FilePart){
            List<FilePart> list = new ArrayList<>();
            list.add((FilePart) object);
            context.setParamData("files", list);
        }
    }
}
