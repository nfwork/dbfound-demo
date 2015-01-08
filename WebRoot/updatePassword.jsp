<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@ taglib uri="dbfound-tags" prefix="d"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<d:includeLibrary />
	</head>
	<script language="javascript">
	function check() {
		if (changeForm.form.isValid()) {
			var objectjson = changeForm.form.getValues();
			if (objectjson.password != objectjson.apassword) {
				alert("����������Ĺ���Ա���벻һ�£�����������!");
				return false;
			}
			Ext.Ajax.request( {
				url : 'login.execute!updatePassword',
				params : objectjson,
				success : function(response, action) {
					var obj = Ext.util.JSON.decode(response.responseText);
					if (obj.success == true) {
						Ext.Msg.alert('��ʾ', '�޸ĳɹ���');
					} else {
						Ext.Msg.alert('��ʾ', obj.message);
					}
				},
				failure : function() {
					Ext.Msg.alert('��ʾ', '�޸�ʧ�ܣ�');
				}
			});
		}
	}
	function reset() {
		changeForm.form.reset();
	}

	function alert(message) {
		Ext.Msg.alert('��ʾ', message);
	}
</script>

	<body>
		<d:form id="changeForm" width="300" labelWidth="70">
			<d:line columnWidth="1">
				<d:field prompt="ԭ����" required="true" width="180" name="ypassword" editor="password">
					<d:event name="enter" handle="check" />
				</d:field>
			</d:line>
			<d:line columnWidth="1">
				<d:field prompt="������" required="true" width="180" name="password" editor="password">
					<d:event name="enter" handle="check" />
				</d:field>
			</d:line>
			<d:line columnWidth="1">
				<d:field prompt="ȷ������" required="true" width="180" name="apassword" editor="password">
					<d:event name="enter" handle="check" />
				</d:field>
			</d:line>
		</d:form>
		<d:buttonGroup align="center">
			<d:button click="check" title="����" icon="DBFoundUI/images/save.gif" />
			<d:button title="����" click="reset" />
		</d:buttonGroup>
	</body>
</html>
