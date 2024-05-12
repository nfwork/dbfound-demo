<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="dbfound-tags" prefix="d"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>访问日志分析</title>
    <d:includeLibrary/>
</head>

<script type="text/javascript">
    function query() {
        dataGrid.query();
    }

    function reset() {
        queryForm.form.reset();
    }

    function upload(){
        if (uploadform.form.isValid()) {
            Ext.getBody().mask('正在导入数据，请耐心等待.......', 'x-mask-loading');
            uploadform.form.submit({
                url:'sys/accessLog.execute!import',
                method:'post',
                success:function(response, action){
                    Ext.getBody().unmask();
                    query();
                },
                failure:function(response,action){
                    let text = action.response.responseText.replace(/<.*?>/ig,"")
                    let obj = Ext.decode(text);
                    Ext.getBody().unmask();
                    if(obj.success) {
                        query();
                    }else{
                        $D.showError(obj.message +"!");
                    }
                }
            });
        }else{
            $D.showMessage('请选择上传文件！');
        }
    }

    let groupItems = [ {
        boxLabel : 'ip',
        name : 'c1',
        inputValue : 'ip'
    }, {
        boxLabel : 'url',
        name : 'c2',
        inputValue : 'url'
    }, {
        boxLabel : 'status',
        name : 'c3',
        inputValue : 'status'
    }];

    function formatSize(size) {
        if (!size)
            return "";
        var num = 1024.00; //byte

        if (size < num)
            return size + "B";
        if (size < Math.pow(num, 2))
            return (size / num).toFixed(2) + "K"; //kb
        if (size < Math.pow(num, 3))
            return (size / Math.pow(num, 2)).toFixed(2) + "M"; //M
        if (size < Math.pow(num, 4))
            return (size / Math.pow(num, 3)).toFixed(2) + "G"; //G
        return (size / Math.pow(num, 4)).toFixed(2) + "T"; //T
    }

    function setFormat(grid){
        grid.getStore().baseParams["export_filename"]= "访问日志.xlsx";
        grid.exportFormats = {"size":"#,##0"};
        return true;
    }
</script>

<body>
<d:form id="uploadform" title="请选择文件" labelWidth="70" fileUpload="true" >
    <d:line columnWidth="0.5">
        <d:field columnWidth="0.5" name="file" id="file_cmp" anchor="90%" required="true" prompt="数据文件" editor="file" />
        <d:field columnWidth="0.3" width="80" editor="button" name="querybtn" prompt="导入">
            <d:event name="click" handle="upload"/>
        </d:field>
    </d:line>
</d:form>

<d:form id="queryForm" title="查询条件" labelWidth="60">
    <d:line columnWidth="0.18">
        <d:field name="ip" anchor="95%" prompt="ip" editor="textfield">
            <d:event name="enter" handle="query" />
        </d:field>
        <d:field name="ua" anchor="95%" prompt="ua" editor="textfield">
            <d:event name="enter" handle="query" />
        </d:field>
        <d:field name="url" anchor="95%" prompt="url" editor="textfield">
            <d:event name="enter" handle="query" />
        </d:field>
        <d:field name="status" anchor="95%" prompt="status" editor="textfield">
            <d:event name="enter" handle="query" />
        </d:field>
        <d:field columnWidth="0.22" name="group" anchor="100%" editor="checkboxgroup" items="groupItems" prompt="查询分组" />
    </d:line>
</d:form>

<d:buttonGroup>
    <d:button id="query" title="查询" click="query" />
    <d:button title="重置" click="reset" />
</d:buttonGroup>

<d:grid id="dataGrid" title="数据列表" pagerSize="50" forceFit="false" height="$D.getFullHeight('dataGrid')" queryForm="queryForm" model="sys/accessLog" autoQuery="true">
    <d:toolBar>
        <d:gridButton type="excel" beforeAction="setFormat"/>
    </d:toolBar>
    <d:columns>
        <d:column name="id" prompt="id" align="center" sortable="true" width="50"/>
        <d:column name="time" prompt="time" align="center" width="150" />
        <d:column name="url" prompt="url" align="center" width="200"/>
        <d:column name="ip" prompt="ip" align="center" width="120" />
        <d:column name="times" prompt="times" align="center" width="80" sortable="true" />
        <d:column name="status" prompt="status" align="center" width="80" sortable="true" />
        <d:column name="cost" prompt="cost" align="center" width="80" sortable="true" />
        <d:column name="size" prompt="size" renderer="formatSize" align="center" width="80" sortable="true" />
        <d:column name="ua" prompt="ua" align="center" width="220" />
    </d:columns>
</d:grid>

<script type="application/javascript">
    document.getElementById("file_cmp").accept = ".csv,.xls,.xlsx"
</script>
</body>
</html>
