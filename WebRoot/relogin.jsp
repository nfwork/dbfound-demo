<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="dbfound-tags" prefix="d"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<d:includeLibrary />
	</head>
	<script type="text/javascript">
		function login() {
			if (loginForm.form.isValid()) {
				var objectjson = loginForm.form.getValues();
				Ext.Ajax.request( {
					url : 'login.execute',
					params : objectjson,
					success : function(response, action) {
						var obj = Ext.util.JSON.decode(response.responseText);
						if (obj.success == true) {
							var url=parent.location.href;
							parent.location.href=url;
						} else{
							alert( obj.message)
						}
					},
					failure : function() {
						Ext.Msg.alert('提示', '登录失败！');
					}
				});
			}
		}

		function alert(message){
			Ext.MessageBox.show( {
				title : '提示',
				msg :  message,
				buttons : Ext.MessageBox.OK,
				icon : Ext.MessageBox.WARNING
			});
		}
		
		function reset() {
			loginForm.form.reset();
		}
	</script>
	<body style="overflow:hidden">
	    <div class="top_table" style="width:100%">
		  <div class="top_table_leftbg" >
			<div class="system_logo" ><img src="images/relogin.jpg" width="100%" height="66"></div>
		  </div>
	    </div>
		<d:form id="loginForm" labelWidth="60">
			<d:line columnWidth="1">
               <d:choose>
                 <d:when test="${cookie.user_code.value==null}">
                    <d:field name="user_code" required="true" editor="textfield" prompt="用户名">
                       <d:event name="enter" handle="login"/>
                    </d:field>
                 </d:when>
                 <d:otherwise>
                    <d:field name="user_code" readOnly="true" value="${cookie.user_code.value}" required="true" editor="textfield" prompt="用户名" />
                 </d:otherwise>
               </d:choose>
			</d:line>
			<d:line columnWidth="1">
				<d:field name="password" required="true" editor="password" prompt="密码">
				  <d:event name="enter" handle="login"/>
				</d:field>
			</d:line>
			<d:toolBar>
				<d:formButton action="" title="确 定" beforeAction="login"></d:formButton>
				<d:formButton action="" title="重 置" beforeAction="reset"></d:formButton>
			</d:toolBar>
		</d:form>
	</body>
</html>
