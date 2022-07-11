<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="dbfound-tags" prefix="d"%>

<d:initProcedure>
	<d:execute modelName="job/jobLine" executeName="init" />
</d:initProcedure>

<d:forward modelName="job/jobLine" />