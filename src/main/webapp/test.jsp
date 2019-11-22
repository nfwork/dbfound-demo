<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="dbfound-tags" prefix="d"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<d:includeLibrary />
	</head>
	<body>
		<d:grid title="已用户列表" style="width:220px;left:0px;top:0px;position:absolute;" id="userGrid1" singleSelect="true" height="300" model="sys/user" autoQuery="true" pagerSize="10">
			<d:columns>
				<d:column name="user_code" prompt="用户编号" width="120" />
				<d:column name="user_name" prompt="用户名" width="120" />
			</d:columns>
			<d:events>
				<d:event name="rowdblclick" handle="commit"></d:event>
			</d:events>
		</d:grid>
		
		<d:buttonGroup style="width:70px;left:220px;top:100px;position:absolute;">
			<d:button id="query" width="50" title="<=" />
		</d:buttonGroup>
		<d:buttonGroup style="width:70px;left:220px;top:150px;position:absolute;">
			<d:button id="query" width="50"  title="=>" />
		</d:buttonGroup>
		
		<d:grid style="left:280px;width:220px;position:absolute;" title="用户列表" id="userGrid2" singleSelect="true" height="300" model="sys/user" autoQuery="true" pagerSize="10">
			<d:columns>
				<d:column name="user_code" prompt="用户编号" width="120" />
				<d:column name="user_name" prompt="用户名" width="120" />
			</d:columns>
			<d:events>
				<d:event name="rowdblclick" handle="commit"></d:event>
			</d:events>
		</d:grid>
	</body>
</html>
